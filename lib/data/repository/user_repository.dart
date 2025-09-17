import 'package:cabby/data/providers/api_provider.dart';
import 'package:cabby/domain/models/payment.model.dart';
import 'package:cabby/domain/models/user_model.dart';

class UserRepository {
  final ApiProvider apiProvider;

  UserRepository({
    required this.apiProvider,
  });

  // Get user profile
  Future<UserModel> getUserProfile() async {
    try {
      final response = await apiProvider.get('/users/profile');
      return UserModel.fromJson(response.data['data']);
    } catch (e) {
      throw Exception('Failed to get user profile: ${e.toString()}');
    }
  }

  // Update user profile
  Future<UserModel> updateUserProfile({
    String? firstName,
    String? lastName,
    String? phoneNumber,
    String? homeAddress,
    String? workAddress,
  }) async {
    try {
      final Map<String, dynamic> data = {};

      if (firstName != null) data['firstName'] = firstName;
      if (lastName != null) data['lastName'] = lastName;
      if (phoneNumber != null) data['phoneNumber'] = phoneNumber;
      if (homeAddress != null) data['homeAddress'] = homeAddress;
      if (workAddress != null) data['workAddress'] = workAddress;

      final response = await apiProvider.put(
        '/users/profile',
        data: data,
      );

      return UserModel.fromJson(response.data['data']);
    } catch (e) {
      throw Exception('Failed to update user profile: ${e.toString()}');
    }
  }

  // Add favorite location
  Future<List<Map<String, dynamic>>> addFavoriteLocation({
    required String name,
    required String address,
    required double latitude,
    required double longitude,
  }) async {
    try {
      final response = await apiProvider.post(
        '/users/favorites',
        data: {
          'name': name,
          'address': address,
          'latitude': latitude,
          'longitude': longitude,
        },
      );

      return List<Map<String, dynamic>>.from(response.data['data']);
    } catch (e) {
      throw Exception('Failed to add favorite location: ${e.toString()}');
    }
  }

  // Remove favorite location
  Future<List<Map<String, dynamic>>> removeFavoriteLocation(String locationId) async {
    try {
      final response = await apiProvider.delete('/users/favorites/$locationId');
      return List<Map<String, dynamic>>.from(response.data['data']);
    } catch (e) {
      throw Exception('Failed to remove favorite location: ${e.toString()}');
    }
  }

  // Add payment method
  Future<List<Map<String, dynamic>>> addPaymentMethod({
    required String type,
    bool isDefault = false,
    Map<String, dynamic>? cardDetails,
  }) async {
    try {
      final response = await apiProvider.post(
        '/users/payment-methods',
        data: {
          'type': type,
          'default': isDefault,
          'cardDetails': cardDetails,
        },
      );

      return List<Map<String, dynamic>>.from(response.data['data']);
    } catch (e) {
      throw Exception('Failed to add payment method: ${e.toString()}');
    }
  }

  // Remove payment method
  Future<List<Map<String, dynamic>>> removePaymentMethod(String methodId) async {
    try {
      final response = await apiProvider.delete('/users/payment-methods/$methodId');
      return List<Map<String, dynamic>>.from(response.data['data']);
    } catch (e) {
      throw Exception('Failed to remove payment method: ${e.toString()}');
    }
  }

  // Get payment history
  Future<List<PaymentModel>> getPaymentHistory({
    int page = 1,
    int limit = 10,
  }) async {
    try {
      final response = await apiProvider.get(
        '/payments/history',
        queryParameters: {
          'page': page,
          'limit': limit,
        },
      );

      final List<dynamic> paymentsJson = response.data['data'];
      return paymentsJson.map((json) => PaymentModel.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Failed to get payment history: ${e.toString()}');
    }
  }

  // Get payment details
  Future<PaymentModel> getPaymentDetails(String paymentId) async {
    try {
      final response = await apiProvider.get('/payments/$paymentId');
      return PaymentModel.fromJson(response.data['data']);
    } catch (e) {
      throw Exception('Failed to get payment details: ${e.toString()}');
    }
  }

  // Generate payment receipt
  Future<Map<String, dynamic>> generateReceipt(String paymentId) async {
    try {
      final response = await apiProvider.get('/payments/$paymentId/receipt');
      return response.data['data'];
    } catch (e) {
      throw Exception('Failed to generate receipt: ${e.toString()}');
    }
  }
}
