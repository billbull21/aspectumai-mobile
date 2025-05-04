import 'package:aspectumai/core/resources/data_state.dart';
import 'package:aspectumai/features/auth/domain/usecases/login_usecase.dart';
import 'package:aspectumai/features/auth/presentation/bloc/auth/auth_cubit.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginUsecase _loginUsecase;
  final AuthCubit _authCubit;

  LoginCubit(LoginUsecase loginUsecase, AuthCubit authCubit)
      : _loginUsecase = loginUsecase,
        _authCubit = authCubit,
        super(LoginInitial());

  void login(String email, String password) async {
    emit(LoginLoading());

    final result = await _loginUsecase.call(LoginParams(
      email: email,
      password: password,
    ));

    if (result is DataStateSuccess) {
      _authCubit.loggedIn(result.data!.token!);
      emit(LoginSuccess(token: result.data!.token!));
    } else {
      emit(LoginFailure(result.error.toString()));
      return;
    }
  }
}
