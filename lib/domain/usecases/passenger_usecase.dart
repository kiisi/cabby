import 'package:cabby/data/network/failure.dart';
import 'package:cabby/data/repository/passenger_repository.dart';
import 'package:cabby/data/request/auth_request.dart';
import 'package:cabby/domain/usecases/base_usecase.dart';
import 'package:dartz/dartz.dart';

class EstimatedFareUseCase
    implements BaseUseCase<EstimatedFareRequest, dynamic> {
  final PassengerRepository _passengerRepository;

  EstimatedFareUseCase(this._passengerRepository);

  @override
  Future<Either<Failure, dynamic>> execute(EstimatedFareRequest input) async {
    return await _passengerRepository.estimatedFare(input);
  }
}
