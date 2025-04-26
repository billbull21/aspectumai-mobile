import 'package:aspectumai/core/resources/data_state.dart';
import 'package:aspectumai/core/usecase/usecase.dart';
import 'package:aspectumai/features/auth/domain/entities/login_response_entity.dart';
import 'package:aspectumai/features/auth/domain/repositories/login_repository.dart';

class LoginUsecase
    extends UseCase<DataState<LoginResponseEntity>, LoginParams> {
  final AuthRepository _repository;

  LoginUsecase(AuthRepository repository) : _repository = repository;

  @override
  Future<DataState<LoginResponseEntity>> call(LoginParams params) {
    return _repository.login(
      email: params.email,
      password: params.password,
    );
  }
}

class LoginParams extends Params{
  final String email;
  final String password;

  LoginParams({
    required this.email,
    required this.password,
  });
}