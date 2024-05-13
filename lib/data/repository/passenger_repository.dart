import 'package:cabby/data/data_source/passenger_remote_data_source.dart';
import 'package:cabby/data/network/failure.dart';
import 'package:cabby/data/request/auth_request.dart';
import 'package:dartz/dartz.dart';

abstract interface class PassengerRepository {
  Future<Either<Failure, dynamic>> estimatedFare(
      EstimatedFareRequest estimatedFareRequest);
}

class PassengerRepositoryImpl implements PassengerRepository {
  final PassengerRemoteDataSource _passengerRemoteDataSource;

  PassengerRepositoryImpl(this._passengerRemoteDataSource);

  @override
  Future<Either<Failure, dynamic>> estimatedFare(
      EstimatedFareRequest estimatedFareRequest) async {
    try {
      final response =
          await _passengerRemoteDataSource.estimatedFare(estimatedFareRequest);
      return Right(response);
    } catch (error) {
      return Left(FailureExceptionHandler.handle(error).failure);
    }
  }
}
