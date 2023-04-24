
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taxi/Features/Auth/ViewModel/cubit/auth_cubit.dart';

import '../../../Core/Widgets/loading_widget.dart';
import '../../../home_view.dart';
import 'loginView/login_view.dart';

class HomeViewOrAuthView extends StatelessWidget {
  const HomeViewOrAuthView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        if (state is LoadingAuthState) {
          return const LoadingWidget();
        } else if (state is LoggedInState) {
          // Schedule navigation to occur after the widget tree has finished building
          Future.delayed(Duration.zero, () {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => const HomeView(),
            ));
          });
        } else if (state is NotLoggedInState) {
          // Schedule navigation to occur after the widget tree has finished building
          Future.delayed(Duration.zero, () {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => const LogInView(),
            ));
          });
        }
        return const LoadingWidget();
      },
    );
  }
}