import 'package:cabby/data/network/failure.dart';
import 'package:cabby/data/repository/google_maps_repository.dart';
import 'package:cabby/domain/models/google_maps.dart';
import 'package:cabby/domain/usecases/base_usecase.dart';
import 'package:dartz/dartz.dart';

class ReverseGeoCodeUseCase
    implements BaseUseCase<ReverseGeoCodeQuery, dynamic> {
  final GoogleMapsRepository _googleMapsRepository;

  ReverseGeoCodeUseCase(this._googleMapsRepository);

  @override
  Future<Either<Failure, dynamic>> execute(ReverseGeoCodeQuery input) async {
    return await _googleMapsRepository.reverseGeoCode(input);
  }
}

class AutoCompleteSearchUseCase
    implements BaseUseCase<AutoCompleteSearchQuery, dynamic> {
  final GoogleMapsRepository _googleMapsRepository;

  AutoCompleteSearchUseCase(this._googleMapsRepository);

  @override
  Future<Either<Failure, dynamic>> execute(
      AutoCompleteSearchQuery input) async {
    return await _googleMapsRepository.autoCompleteSearch(input);
  }
}

class PlaceDirectionDetailsUseCase
    implements BaseUseCase<PlaceDirectionDetailsQuery, dynamic> {
  final GoogleMapsRepository _googleMapsRepository;

  PlaceDirectionDetailsUseCase(this._googleMapsRepository);

  @override
  Future<Either<Failure, dynamic>> execute(
      PlaceDirectionDetailsQuery input) async {
    return await _googleMapsRepository.placeDirectionDetails(input);
  }
}
