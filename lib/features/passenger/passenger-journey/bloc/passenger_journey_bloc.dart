import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'passenger_journey_event.dart';
part 'passenger_journey_state.dart';

class PassengerJourneyBloc extends Bloc<PassengerJourneyEvent, PassengerJourneyState> {
  PassengerJourneyBloc() : super(PassengerJourneyInitial()) {
    on<PassengerJourneyEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
