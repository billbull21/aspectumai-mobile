import 'package:aspectumai/core/network/dio_client.dart';
import 'package:aspectumai/features/auth/models/login_response_model.dart';
import 'package:dio/dio.dart';

abstract class IAuthRepository {
  Future<LoginResponseModel> login(String email, String password);
  Future<void> logout();
}

class AuthRepository implements IAuthRepository {
  final DioClient _client;

  AuthRepository(DioClient client) : _client = client;

  @override
  Future<LoginResponseModel> login(String email, String password) async {
    try {
      final response = await _client.post(
        'auth/sign-in',
        data: {
          'email': email,
          'password': password,
        },
      );

      return LoginResponseModel.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw e.error.toString();
    }
  }

  @override
  Future<void> logout() async {
    // Simulate a network call
    await Future.delayed(const Duration(seconds: 2));
  }
}
