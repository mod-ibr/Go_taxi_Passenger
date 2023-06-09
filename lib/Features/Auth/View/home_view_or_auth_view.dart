import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
 
import '../../../Core/Utils/Functions/animated_navigation.dart';
import '../../../Core/Widgets/loading_widget.dart';
import '../../Maps/View/MapsView/maps_home_view.dart';
import '../ViewModel/cubit/auth_cubit.dart';
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
          Future.delayed(
            Duration.zero,
            () {
              AnimatedNavigation()
                  .navigate(widget: const MapsHomeView(), context: context);
            },
          );
        } else if (state is NotLoggedInState) {
          // Schedule navigation to occur after the widget tree has finished building
          Future.delayed(Duration.zero, () {
            AnimatedNavigation()
                .navigate(widget: const LogInView(), context: context);
          });
        }
        return const LoadingWidget();
      },
    );
  }
}
