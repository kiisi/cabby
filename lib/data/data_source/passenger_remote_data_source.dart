import 'package:cabby/data/network/app_api.dart';
import 'package:cabby/data/request/auth_request.dart';

abstract interface class PassengerRemoteDataSource {
  Future<dynamic> estimatedFare(EstimatedFareRequest estimatedFareRequest);
}

class PassengerRemoteDataSourceImpl implements PassengerRemoteDataSource {
  final AppServiceClient _appServiceClient;

  PassengerRemoteDataSourceImpl(this._appServiceClient);

  @override
  Future<dynamic> estimatedFare(
      EstimatedFareRequest estimatedFareRequest) async {
    return await _appServiceClient.estimatedFare(
      distance: estimatedFareRequest.distance,
      duration: estimatedFareRequest.duration,
    );
  }
}
