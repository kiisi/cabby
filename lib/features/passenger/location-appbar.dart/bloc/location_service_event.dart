part of 'location_service_bloc.dart';

@immutable
abstract class LocationServiceEvent {}

class LocationServiceEnabled extends LocationServiceEvent {}

class LocationServiceDisabled extends LocationServiceEvent {}
