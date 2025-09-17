import 'dart:async';
import 'package:cabby/data/repository/ride_repository.dart';
import 'package:cabby/domain/models/driver_model.dart';
import 'package:cabby/features/bloc/ride/ride_event.dart';
import 'package:cabby/features/bloc/ride/ride_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

// Ride Bloc
class RideBloc extends Bloc<RideEvent, RideState> {
  final RideRepository rideRepository;

  // Subscriptions to socket events
  StreamSubscription? _driverLocationSubscription;
  StreamSubscription? _rideAcceptedSubscription;
  StreamSubscription? _driverArrivedSubscription;
  StreamSubscription? _rideStartedSubscription;
  StreamSubscription? _rideCompletedSubscription;
  StreamSubscription? _rideCancelledSubscription;
  StreamSubscription? _newMessageSubscription;

  RideBloc({required this.rideRepository}) : super(RideInitial()) {
    on<RequestRide>(_onRequestRide);
    on<GetNearbyDrivers>(_onGetNearbyDrivers);
    on<GetActiveRide>(_onGetActiveRide);
    on<CancelRide>(_onCancelRide);
    on<RateDriver>(_onRateDriver);
    on<ConnectToRideUpdates>(_onConnectToRideUpdates);
    on<DisconnectFromRideUpdates>(_onDisconnectFromRideUpdates);
    on<DriverLocationUpdated>(_onDriverLocationUpdated);
    on<RideAccepted>(_onRideAccepted);
    on<DriverArrived>(_onDriverArrived);
    on<RideStarted>(_onRideStarted);
    on<RideCompleted>(_onRideCompleted);
    on<RideCancelled>(_onRideCancelled);
    on<SendMessage>(_onSendMessage);
    on<MessageReceived>(_onMessageReceived);
    on<GetRideHistory>(_onGetRideHistory);

    // Initialize socket listeners
    _initSocketListeners();
  }

  void _initSocketListeners() {
    _driverLocationSubscription = rideRepository.listenForDriverLocation().listen(
      (locationData) {
        add(DriverLocationUpdated(locationData: locationData));
      },
    );

    _rideAcceptedSubscription = rideRepository.listenForRideAccepted().listen(
      (acceptData) {
        add(RideAccepted(acceptData: acceptData));
      },
    );

    _driverArrivedSubscription = rideRepository.listenForDriverArrived().listen(
      (arrivalData) {
        add(DriverArrived(arrivalData: arrivalData));
      },
    );

    _rideStartedSubscription = rideRepository.listenForRideStarted().listen(
      (startData) {
        add(RideStarted(startData: startData));
      },
    );

    _rideCompletedSubscription = rideRepository.listenForRideCompleted().listen(
      (completionData) {
        add(RideCompleted(completionData: completionData));
      },
    );

    _rideCancelledSubscription = rideRepository.listenForRideCancelled().listen(
      (cancellationData) {
        add(RideCancelled(cancellationData: cancellationData));
      },
    );

    _newMessageSubscription = rideRepository.listenForNewMessage().listen(
      (messageData) {
        add(MessageReceived(messageData: messageData));
      },
    );
  }

  Future<void> _onRequestRide(
    RequestRide event,
    Emitter<RideState> emit,
  ) async {
    emit(RideLoading());
    try {
      final ride = await rideRepository.requestRide(
        pickupAddress: event.pickupAddress,
        pickupLat: event.pickupLat,
        pickupLng: event.pickupLng,
        destinationAddress: event.destinationAddress,
        destinationLat: event.destinationLat,
        destinationLng: event.destinationLng,
        paymentMethod: event.paymentMethod,
      );
      emit(DriverSearching(ride));
    } catch (error) {
      emit(RideFailure(error.toString()));
    }
  }

  Future<void> _onGetNearbyDrivers(
    GetNearbyDrivers event,
    Emitter<RideState> emit,
  ) async {
    try {
      final drivers = await rideRepository.getNearbyDrivers(
        latitude: event.latitude,
        longitude: event.longitude,
        radius: event.radius,
      );
      emit(NearbyDriversLoaded(drivers));
    } catch (error) {
      emit(RideFailure(error.toString()));
    }
  }

  Future<void> _onGetActiveRide(
    GetActiveRide event,
    Emitter<RideState> emit,
  ) async {
    emit(RideLoading());
    try {
      final ride = await rideRepository.getActiveRide();

      if (ride == null) {
        emit(RideInitial());
        return;
      }

      switch (ride.status) {
        case 'pending':
          emit(DriverSearching(ride));
          break;
        case 'accepted':
          final driver = ride.driver;
          if (driver != null) {
            emit(RideAcceptedState(
              ride: ride,
              driver: driver,
              estimatedArrivalTime: '5 mins', // This would come from the backend in a real app
            ));
          } else {
            emit(RideFailure('Ride accepted but driver data is missing'));
          }
          break;
        case 'arrived_at_pickup':
          emit(DriverArrivedState(ride));
          break;
        case 'started':
          emit(RideInProgressState(
            ride: ride,
            driverLocation: ride.driver?.currentLocation,
          ));
          break;
        case 'completed':
          emit(RideCompletedState(ride));
          break;
        case 'cancelled':
          emit(RideCancelledState(
            ride: ride,
            reason: ride.cancellationReason ?? 'No reason provided',
            cancelledBy: ride.cancelledBy ?? 'unknown',
          ));
          break;
        default:
          emit(RideFailure('Unknown ride status: ${ride.status}'));
      }
    } catch (error) {
      emit(RideFailure(error.toString()));
    }
  }

  Future<void> _onCancelRide(
    CancelRide event,
    Emitter<RideState> emit,
  ) async {
    emit(RideLoading());
    try {
      await rideRepository.cancelRide(event.rideId, reason: event.reason);

      // We'll let the socket event update the state, but in case it doesn't,
      // we can also call getActiveRide again.
      await Future.delayed(const Duration(seconds: 1));
      add(GetActiveRide());
    } catch (error) {
      emit(RideFailure(error.toString()));
    }
  }

  Future<void> _onRateDriver(
    RateDriver event,
    Emitter<RideState> emit,
  ) async {
    try {
      await rideRepository.rateDriver(
        rideId: event.rideId,
        rating: event.rating,
        feedback: event.feedback,
      );

      // Refresh ride if current ride is the one being rated
      if (state is RideCompletedState) {
        final completedRide = (state as RideCompletedState).ride;
        if (completedRide.id == event.rideId) {
          final updatedRide = await rideRepository.getRideById(event.rideId);
          emit(RideCompletedState(updatedRide));
        }
      }
    } catch (error) {
      emit(RideFailure(error.toString()));
    }
  }

  Future<void> _onConnectToRideUpdates(
    ConnectToRideUpdates event,
    Emitter<RideState> emit,
  ) async {
    rideRepository.connectToRideRoom(event.rideId);
  }

  Future<void> _onDisconnectFromRideUpdates(
    DisconnectFromRideUpdates event,
    Emitter<RideState> emit,
  ) async {
    rideRepository.disconnectFromRideRoom(event.rideId);
  }

  Future<void> _onDriverLocationUpdated(
    DriverLocationUpdated event,
    Emitter<RideState> emit,
  ) async {
    // Update driver location if a ride is in progress
    if (state is RideInProgressState) {
      final currentState = state as RideInProgressState;
      final locationData = event.locationData;

      // Check if this location update is for the current ride
      if (locationData['rideId'] == currentState.ride.id) {
        final driverLocation = GeoLocation(
          type: 'Point',
          coordinates: [
            locationData['location']['coordinates'][0],
            locationData['location']['coordinates'][1],
          ],
        );

        emit(RideInProgressState(
          ride: currentState.ride,
          driverLocation: driverLocation,
        ));
      }
    }
  }

  Future<void> _onRideAccepted(
    RideAccepted event,
    Emitter<RideState> emit,
  ) async {
    // If we're searching for a driver, update the state
    if (state is DriverSearching) {
      final currentRide = (state as DriverSearching).ride;
      final acceptData = event.acceptData;

      if (acceptData['rideId'] == currentRide.id) {
        // Get the active ride from the API to get the updated ride details
        add(GetActiveRide());
      }
    }
  }

  Future<void> _onDriverArrived(
    DriverArrived event,
    Emitter<RideState> emit,
  ) async {
    if (state is RideAcceptedState) {
      final currentState = state as RideAcceptedState;
      final arrivalData = event.arrivalData;

      if (arrivalData['rideId'] == currentState.ride.id) {
        add(GetActiveRide());
      }
    }
  }

  Future<void> _onRideStarted(
    RideStarted event,
    Emitter<RideState> emit,
  ) async {
    if (state is DriverArrivedState) {
      final currentState = state as DriverArrivedState;
      final startData = event.startData;

      if (startData['rideId'] == currentState.ride.id) {
        add(GetActiveRide());
      }
    }
  }

  Future<void> _onRideCompleted(
    RideCompleted event,
    Emitter<RideState> emit,
  ) async {
    if (state is RideInProgressState) {
      final currentState = state as RideInProgressState;
      final completionData = event.completionData;

      if (completionData['rideId'] == currentState.ride.id) {
        add(GetActiveRide());
      }
    }
  }

  Future<void> _onRideCancelled(
    RideCancelled event,
    Emitter<RideState> emit,
  ) async {
    final cancellationData = event.cancellationData;

    // Check if this cancellation is for the current ride
    if (state is DriverSearching) {
      final currentRide = (state as DriverSearching).ride;
      if (cancellationData['rideId'] == currentRide.id) {
        add(GetActiveRide());
      }
    } else if (state is RideAcceptedState) {
      final currentRide = (state as RideAcceptedState).ride;
      if (cancellationData['rideId'] == currentRide.id) {
        add(GetActiveRide());
      }
    } else if (state is DriverArrivedState) {
      final currentRide = (state as DriverArrivedState).ride;
      if (cancellationData['rideId'] == currentRide.id) {
        add(GetActiveRide());
      }
    } else if (state is RideInProgressState) {
      final currentRide = (state as RideInProgressState).ride;
      if (cancellationData['rideId'] == currentRide.id) {
        add(GetActiveRide());
      }
    }
  }

  Future<void> _onSendMessage(
    SendMessage event,
    Emitter<RideState> emit,
  ) async {
    rideRepository.sendMessage(event.rideId, event.message);
  }

  Future<void> _onMessageReceived(
    MessageReceived event,
    Emitter<RideState> emit,
  ) async {
    final messageData = event.messageData;

    // Emit new message state
    emit(NewMessageReceived(
      rideId: messageData['rideId'],
      senderId: messageData['senderId'],
      senderRole: messageData['senderRole'],
      message: messageData['message'],
      timestamp: DateTime.parse(messageData['timestamp']),
    ));

    // Then revert back to the previous state
    // We do this so that message handling can be done by the UI while
    // maintaining the correct ride state
    await Future.delayed(const Duration(milliseconds: 10));
    if (state is NewMessageReceived) {
      add(GetActiveRide());
    }
  }

  Future<void> _onGetRideHistory(
    GetRideHistory event,
    Emitter<RideState> emit,
  ) async {
    emit(RideLoading());
    try {
      final rides = await rideRepository.getRideHistory(
        page: event.page,
        limit: event.limit,
      );

      // In a real app, we'd get pagination info from the API response
      emit(RideHistoryLoaded(
        rides: rides,
        totalRides: rides.length,
        currentPage: event.page,
        totalPages: 1,
      ));
    } catch (error) {
      emit(RideFailure(error.toString()));
    }
  }

  @override
  Future<void> close() {
    _driverLocationSubscription?.cancel();
    _rideAcceptedSubscription?.cancel();
    _driverArrivedSubscription?.cancel();
    _rideStartedSubscription?.cancel();
    _rideCompletedSubscription?.cancel();
    _rideCancelledSubscription?.cancel();
    _newMessageSubscription?.cancel();
    return super.close();
  }
}
