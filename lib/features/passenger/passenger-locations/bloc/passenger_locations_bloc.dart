import 'package:bloc/bloc.dart';
import 'package:cabby/app/di.dart';
import 'package:cabby/core/common/loading_status.dart';
import 'package:cabby/core/resources/color_manager.dart';
import 'package:cabby/domain/models/google_maps.dart';
import 'package:cabby/domain/models/location_details.dart';
import 'package:cabby/domain/models/location_direction.dart';
import 'package:cabby/domain/usecases/google_maps_usecase.dart';
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

  PassengerLocationsBloc() : super(PassengerLocationsState()) {
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
        emit(state.copyWith(loadingStatus: LoadingStatus.loading));
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
            emit(state.copyWith(loadingStatus: LoadingStatus.done));
          },
        );
      } else if (event is PassengerLocationDirection) {
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
                durationValue: success['routes'][0]['legs'][0]['duration']
                    ['value'],
                distanceValue: success['routes'][0]['legs'][0]['distance']
                    ['value'],
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
          },
        );
      } else if (event is PassengerLoadingStatusIdle) {
        emit(
          state.copyWith(loadingStatus: LoadingStatus.idle),
        );
      } else if (event is PassengerLocationsPickupDiscard) {
        emit(state.copyWith(
            pickupLocation: null, pickupLocationInputText: null));
      } else if (event is PassengerLocationsDestinationDiscard) {
        emit(state.copyWith(
            destinationLocation: null, destinationLocationInputText: null));
      }
    });
  }
}
