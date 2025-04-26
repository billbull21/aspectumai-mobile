import 'package:aspectumai/core/resources/data_state.dart';
import 'package:aspectumai/features/auth/data/data_sources/auth_source.dart';
import 'package:aspectumai/features/auth/domain/entities/login_response_entity.dart';
import 'package:aspectumai/features/auth/domain/repositories/login_repository.dart';

class AuthRepositoryImpl extends AuthRepository {
  final IAuthSource _loginSource;
  AuthRepositoryImpl(IAuthSource loginSource) : _loginSource = loginSource;

  @override
  Future<DataState<LoginResponseEntity>> login({
    required String email,
    required String password,
  }) async {
    try {
      final data = await _loginSource.login(email, password);
      return DataStateSuccess<LoginResponseEntity>(data.toEntity());
    } catch (e) {
      return DataStateError(e.toString());
    }
  }

  @override
  Future<DataState<void>> logout() {
    // TODO: implement logout
    throw UnimplementedError();
  }
}
