import 'package:cabby/data/data_source/google_maps_remote_data_source.dart';
import 'package:cabby/data/network/failure.dart';
import 'package:cabby/domain/models/google_maps.dart';
import 'package:dartz/dartz.dart';

abstract interface class GoogleMapsRepository {
  Future<Either<Failure, dynamic>> reverseGeoCode(
      ReverseGeoCodeQuery reverseGeoCodeQuery);

  Future<Either<Failure, dynamic>> autoCompleteSearch(
      AutoCompleteSearchQuery autoCompleteSearchQuery);

  Future<Either<Failure, dynamic>> placeLocationDetails(
      PlaceLocationDetailsQuery placeLocationDetailsQuery);

  Future<Either<Failure, dynamic>> placeLocationDirection(
      PlaceLocationDirectionQuery placeLocationDirectionQuery);
}

class GoogleMapsRepositoryImpl implements GoogleMapsRepository {
  final GoogleMapsRemoteDataSource _googleMapsRemoteDataSource;

  GoogleMapsRepositoryImpl(this._googleMapsRemoteDataSource);

  @override
  Future<Either<Failure, dynamic>> reverseGeoCode(
      ReverseGeoCodeQuery reverseGeoCodeQuery) async {
    try {
      final response =
          await _googleMapsRemoteDataSource.reverseGeoCode(reverseGeoCodeQuery);
      return Right(response);
    } catch (error) {
      return Left(FailureExceptionHandler.handle(error).failure);
    }
  }

  @override
  Future<Either<Failure, dynamic>> autoCompleteSearch(
      AutoCompleteSearchQuery autoCompleteSearchQuery) async {
    try {
      final response = await _googleMapsRemoteDataSource
          .autocompleteSearch(autoCompleteSearchQuery);
      return Right(response);
    } catch (error) {
      return Left(FailureExceptionHandler.handle(error).failure);
    }
  }

  @override
  Future<Either<Failure, dynamic>> placeLocationDetails(
      PlaceLocationDetailsQuery placeLocationDetailsQuery) async {
    try {
      final response = await _googleMapsRemoteDataSource
          .placeLocationDetails(placeLocationDetailsQuery);
      return Right(response);
    } catch (error) {
      return Left(FailureExceptionHandler.handle(error).failure);
    }
  }

  @override
  Future<Either<Failure, dynamic>> placeLocationDirection(
      PlaceLocationDirectionQuery placeLocationDirectionQuery) async {
    try {
      final response = await _googleMapsRemoteDataSource
          .placeLocationDirection(placeLocationDirectionQuery);
      return Right(response);
    } catch (error) {
      return Left(FailureExceptionHandler.handle(error).failure);
    }
  }
}
