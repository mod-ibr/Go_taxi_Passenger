import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taxi/Core/Utils/Functions/animated_navigation.dart';
import 'package:taxi/Core/Utils/Functions/awesome_dialog_message.dart';
import 'package:taxi/Features/Auth/View/loginView/login_view.dart';
import 'package:taxi/Features/Auth/ViewModel/cubit/auth_cubit.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is SucceededAuthState) {
          AwesomeDialogMessage()
              .showSuccessAwesomeDialog(
                  message: 'logged out successfully', context: context)
              .then((value) {
            AnimatedNavigation()
                .navigate(widget: const LogInView(), context: context);
          });
        }
      },
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () {
                BlocProvider.of<AuthCubit>(context).logOut();
              },
              icon: const Icon(Icons.logout),
            )
          ],
          title: const Text('Home View'),
        ),
      ),
    );
  }
}
