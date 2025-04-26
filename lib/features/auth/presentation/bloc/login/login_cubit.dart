import 'package:aspectumai/core/resources/data_state.dart';
import 'package:aspectumai/features/auth/domain/usecases/login_usecase.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginUsecase _loginUsecase;
  LoginCubit(LoginUsecase loginUsecase)
      : _loginUsecase = loginUsecase,
        super(LoginInitial());

  void login(String email, String password) async {
    emit(LoginLoading());

    final result = await _loginUsecase.call(LoginParams(
      email: email,
      password: password,
    ));

    if (result is DataStateSuccess) {
      emit(LoginSuccess());
    } else {
      emit(LoginFailure(result.error.toString()));
      return;
    }
  }
}
