import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taxi/Features/Maps/ViewModel/MapsCubit/maps_cubit.dart';

import 'Features/Auth/View/splashView/splash_view.dart';
import 'Features/Auth/ViewModel/cubit/auth_cubit.dart';
import 'firebase_options.dart';
import 'services_locator.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.servicesLocator();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(
          create: (_) => di.sl<AuthCubit>(),
        ),
        BlocProvider<MapsCubit>(
          create: (_) => di.sl<MapsCubit>(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'Ubuntu'),
      title: 'Fluter FireBase Auth',
      home: SplashScreen(),
    );
  }
}
