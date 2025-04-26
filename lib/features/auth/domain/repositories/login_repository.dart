import 'package:aspectumai/core/resources/data_state.dart';
import 'package:aspectumai/features/auth/domain/entities/login_response_entity.dart';

abstract class AuthRepository {
  Future<DataState<LoginResponseEntity>> login({
    required String email,
    required String password,
  });
  Future<DataState<void>> logout();
}
