import 'package:aspectumai/features/auth/presentation/bloc/auth/auth_cubit.dart';
import 'package:aspectumai/features/auth/presentation/page/login/login_screen.dart';
import 'package:aspectumai/features/home/presentation/page/home_screen.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class IndexPage extends StatelessWidget {
  const IndexPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        if (state is AuthenticatedState) {
          return const HomeScreen();
        }
        if (state is UnAuthenticatedState) {
          return const LoginScreen();
        }
        return const Scaffold();
      },
    );
  }
}
