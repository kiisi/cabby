import 'package:bloc/bloc.dart';
import 'package:cabby/app/di.dart';
import 'package:cabby/domain/models/google_maps.dart';
import 'package:cabby/domain/models/location_direction.dart';
import 'package:cabby/domain/usecases/google_maps_usecase.dart';
import 'package:cabby/features/passenger/passenger-locations/passenger_locations.dart';
import 'package:meta/meta.dart';

part 'passenger_locations_event.dart';
part 'passenger_locations_state.dart';

class PassengerLocationsBloc
    extends Bloc<PassengerLocationsEvent, PassengerLocationsState> {
  final ReverseGeoCodeUseCase _reverseGeoCodeUseCase =
      getIt<ReverseGeoCodeUseCase>();

  final AutoCompleteSearchUseCase _autoCompleteSearchUseCase =
      getIt<AutoCompleteSearchUseCase>();

  final PlaceDirectionDetailsUseCase _placeDirectionDetailsUseCase =
      getIt<PlaceDirectionDetailsUseCase>();

  PassengerLocationsBloc() : super(PassengerLocationsState()) {
    on<PassengerLocationsEvent>((event, emit) async {
      if (event is PassengerLocationsPickup) {
        (await _reverseGeoCodeUseCase.execute(
          ReverseGeoCodeQuery(
              latlng: '${event.latitude},${event.longitude}',
              key: 'AIzaSyCtm3sRh1A-rbIawxq5bdv7NDFDlMoze0c'),
        ))
            .fold(
          (failure) {
            print("Failure Message ${failure.message}");
          },
          (success) {
            emit(
              state.copyWith(
                pickupLocation: LocationDirection(
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
      } else if (event is LocationAutoCompleteSearch) {
        print('************6666*********');
        (await _autoCompleteSearchUseCase.execute(
          AutoCompleteSearchQuery(
              input: '"${event.input}"',
              key: 'AIzaSyCtm3sRh1A-rbIawxq5bdv7NDFDlMoze0c'),
        ))
            .fold(
          (failure) {
            print("Failure Message ${failure.message}");
          },
          (success) {
            print("================ SUCESS RESULTS ===============");
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
        print("*****************888888***********");
        (await _placeDirectionDetailsUseCase.execute(
          PlaceDirectionDetailsQuery(
              placeId: event.placeId ?? '',
              key: 'AIzaSyCtm3sRh1A-rbIawxq5bdv7NDFDlMoze0c'),
        ))
            .fold(
          (failure) {
            print("Failure Message ${failure.message}");
          },
          (success) {
            print("================ <<SUCESS RESULTS>> ===============");
            print(event.inputFocus);
            print(event.placeId);
            if (event.inputFocus == InputFocus.pickup) {
              print("Running Pickup");
              emit(
                state.copyWith(
                  pickupLocation: LocationDirection(
                    latitude: success['result']["geometry"]["location"]["lat"],
                    longitude: success['result']["geometry"]["location"]["lng"],
                    address: success['result']['formatted_address'],
                  ),
                ),
              );
            } else {
              print("Running Destination");
              emit(
                state.copyWith(
                  destinationLocation: LocationDirection(
                    latitude: success['result']["geometry"]["location"]["lat"],
                    longitude: success['result']["geometry"]["location"]["lng"],
                    address: success['result']['formatted_address'],
                  ),
                ),
              );
            }

            // List<LocationPredictionAutoComplete> locationPredictions =
            //     (success['predictions'] as List)
            //         .map((jsonData) =>
            //             LocationPredictionAutoComplete.fromJson(jsonData))
            //         .toList();
            // emit(state.copyWith(
            //     locationPredictionAutoComplete: locationPredictions));
          },
        );
      }
    });
  }
}
