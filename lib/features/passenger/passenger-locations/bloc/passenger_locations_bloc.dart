import 'package:auto_route/auto_route.dart';
import 'package:bloc/bloc.dart';
import 'package:cabby/app/di.dart';
import 'package:cabby/core/common/loading_status.dart';
import 'package:cabby/core/resources/color_manager.dart';
import 'package:cabby/data/request/auth_request.dart';
import 'package:cabby/domain/models/google_maps.dart';
import 'package:cabby/domain/models/location_details.dart';
import 'package:cabby/domain/models/location_direction.dart';
import 'package:cabby/domain/usecases/google_maps_usecase.dart';
import 'package:cabby/domain/usecases/passenger_usecase.dart';
import 'package:cabby/features/passenger/passenger-locations/view/passenger_locations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter_platform_interface/google_maps_flutter_platform_interface.dart';
import 'package:meta/meta.dart';

part 'passenger_locations_event.dart';
part 'passenger_locations_state.dart';

class PassengerLocationsBloc
    extends Bloc<PassengerLocationsEvent, PassengerLocationsState> {
  final ReverseGeoCodeUseCase _reverseGeoCodeUseCase =
      getIt<ReverseGeoCodeUseCase>();

  final AutoCompleteSearchUseCase _autoCompleteSearchUseCase =
      getIt<AutoCompleteSearchUseCase>();

  final PlaceLocationDetailsUseCase _placeLocationDetailsUseCase =
      getIt<PlaceLocationDetailsUseCase>();

  final PlaceLocationDirectionUseCase _placeLocationDirectionUseCase =
      getIt<PlaceLocationDirectionUseCase>();

  final EstimatedFareUseCase _estimatedFareUseCase =
      getIt<EstimatedFareUseCase>();

  PassengerLocationsBloc()
      : super(PassengerLocationsState(
          estimatedFareLoadingStatus: LoadingStatus.idle,
          extraLoadingStatus: LoadingStatus.idle,
          locationDetailsLoadingStatus: LoadingStatus.idle,
        )) {
    on<PassengerLocationsEvent>((event, emit) async {
      if (event is PassengerLocationsPickup) {
        (await _reverseGeoCodeUseCase.execute(
          ReverseGeoCodeQuery(
            latlng: '${event.latitude},${event.longitude}',
          ),
        ))
            .fold(
          (failure) {
            print("Failure Message ${failure.message}");
          },
          (success) {
            emit(
              state.copyWith(
                pickupLocationInputText: success['results'][0]
                    ['formatted_address'],
                pickupLocation: LocationDetails(
                  latitude: event.latitude,
                  longitude: event.longitude,
                  address: success['results'][0]['formatted_address'],
                ),
              ),
            );
          },
        );
      } else if (event is PassengerLocationsDestination) {
        // emit(state.copyWith(destinationLocation: event.destinationLocation));
      } else if (event is LocationsInputUpdater) {
        if (event.inputFocus == InputFocus.pickup) {
          emit(state.copyWith(pickupLocationInputText: event.input));
        } else {
          emit(state.copyWith(destinationLocationInputText: event.input));
        }
      } else if (event is LocationAutoCompleteSearch) {
        (await _autoCompleteSearchUseCase.execute(
          AutoCompleteSearchQuery(
            input: '"${event.input}"',
          ),
        ))
            .fold(
          (failure) {
            print("Failure Message ${failure.message}");
          },
          (success) {
            print(success);
            List<LocationPredictionAutoComplete> locationPredictions =
                (success['predictions'] as List)
                    .map((jsonData) =>
                        LocationPredictionAutoComplete.fromJson(jsonData))
                    .toList();
            emit(state.copyWith(
                locationPredictionAutoComplete: locationPredictions));
          },
        );
      } else if (event is PassengerLocationDetails) {
        emit(state.copyWith(
            locationDetailsLoadingStatus: LoadingStatus.loading));
        (await _placeLocationDetailsUseCase.execute(
          PlaceLocationDetailsQuery(
            placeId: event.placeId ?? '',
          ),
        ))
            .fold(
          (failure) {
            print("Failure Message ${failure.message}");
          },
          (success) {
            if (event.inputFocus == InputFocus.pickup) {
              emit(
                state.copyWith(
                  pickupLocationInputText: success['result']['name'],
                  pickupLocation: LocationDetails(
                    latitude: success['result']["geometry"]["location"]["lat"],
                    longitude: success['result']["geometry"]["location"]["lng"],
                    address: success['result']['formatted_address'],
                    shortAddress: success['result']['name'],
                  ),
                ),
              );
            } else {
              emit(
                state.copyWith(
                  destinationLocationInputText: success['result']['name'],
                  destinationLocation: LocationDetails(
                    latitude: success['result']["geometry"]["location"]["lat"],
                    longitude: success['result']["geometry"]["location"]["lng"],
                    address: success['result']['formatted_address'],
                    shortAddress: success['result']['name'],
                  ),
                ),
              );
            }
            emit(state.copyWith(
                locationDetailsLoadingStatus: LoadingStatus.done));
            add(
              PassengerLocationDirection(
                origin: LatLng(state.pickupLocation?.latitude ?? 0,
                    state.pickupLocation?.longitude ?? 0),
                destination: LatLng(state.destinationLocation?.latitude ?? 0,
                    state.destinationLocation?.longitude ?? 0),
              ),
            );

            emit(state.copyWith(
                estimatedFareLoadingStatus: LoadingStatus.loading));

            AutoRouter.of(event.context).pushNamed('/passenger-journey');
          },
        );
      } else if (event is PassengerLocationDirection) {
        emit(state.copyWith(extraLoadingStatus: LoadingStatus.loading));

        (await _placeLocationDirectionUseCase.execute(
          PlaceLocationDirectionQuery(
              destination:
                  '${event.destination.latitude},${event.destination.longitude}',
              origin: '${event.origin.latitude},${event.origin.longitude}'),
        ))
            .fold(
          (failure) {
            print("Failure Message ${failure.message}");
          },
          (success) {
            LocationDirection locationDirection = LocationDirection(
                durationValue:
                    success['routes'][0]['legs'][0]['duration']['value'] + 0.0,
                distanceValue:
                    success['routes'][0]['legs'][0]['distance']['value'] + 0.0,
                durationText: success['routes'][0]['legs'][0]['duration']
                    ['text'],
                distanceText: success['routes'][0]['legs'][0]['distance']
                    ['text'],
                encodedPoints: success['routes'][0]['overview_polyline']
                    ['points']);
            emit(state.copyWith(locationDirection: locationDirection));
            // set and draw polyline
            List<LatLng> pLineCordinates = [];
            // Map<PolylineId, Polyline> polylines = {};
            Set<Polyline> polylineSet = {};
            PolylinePoints polylinePoints = PolylinePoints();
            List<PointLatLng> decodePolylinePoints =
                polylinePoints.decodePolyline(locationDirection.encodedPoints);

            if (decodePolylinePoints.isNotEmpty) {
              decodePolylinePoints.forEach((PointLatLng pointLatLng) {
                pLineCordinates
                    .add(LatLng(pointLatLng.latitude, pointLatLng.longitude));
              });
              polylineSet.clear();
              Polyline polyline = Polyline(
                polylineId: const PolylineId('PolyLineId'),
                color: ColorManager.primary,
                jointType: JointType.round,
                width: 4,
                endCap: Cap.buttCap,
                startCap: Cap.roundCap,
                points: pLineCordinates,
                geodesic: true,
              );
              polylineSet.add(polyline);
              emit(state.copyWith(polylineSet: polylineSet));
            }
            emit(state.copyWith(extraLoadingStatus: LoadingStatus.done));
            add(PassengerLocationsEstimatedFare());
          },
        );
      } else if (event is PassengerLocationsPickupDiscard) {
        emit(state.copyWithPickupLocationSetToNull());
      } else if (event is PassengerLocationsDestinationDiscard) {
        emit(state.copyWithDestinationLocationSetToNull());
      } else if (event is PassengerLocationsEstimatedFare) {
        emit(state.copyWith(estimatedFareLoadingStatus: LoadingStatus.loading));
        (await _estimatedFareUseCase.execute(
          EstimatedFareRequest(
            distance: state.locationDirection?.distanceValue ?? 0,
            duration: state.locationDirection?.durationValue ?? 0,
          ),
        ))
            .fold(
          (failure) {
            print("Failure Message ${failure}");
            print("Failure Message ${failure.message}");
          },
          (success) {
            print('==========&&&&&&&&&&&&==========');
            print(success['data']['fare']);
            emit(
              state.copyWith(
                estimatedFareValue: success['data']['fare'],
                estimatedFareCurrency: success['data']['currency'],
              ),
            );
          },
        );
        emit(state.copyWith(estimatedFareLoadingStatus: LoadingStatus.done));
      }
    });
  }
}
