import 'package:aspectumai/features/auth/bloc/auth/auth_cubit.dart';
import 'package:aspectumai/features/auth/repositories/auth_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final IAuthRepository _authRepository;
  final AuthCubit _authCubit;

  LoginCubit(IAuthRepository authRepository, AuthCubit authCubit)
      : _authRepository = authRepository,
        _authCubit = authCubit,
        super(LoginInitial());

  void login(String email, String password) async {
    emit(LoginLoading());

    try {
      final result = await _authRepository.login(
        email,
        password,
      );

      _authCubit.loggedIn(result.token!);
      emit(LoginSuccess(token: result.token!));
    } catch (e) {
      emit(LoginFailure(e.toString()));
    }
  }
}
