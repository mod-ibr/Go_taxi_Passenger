import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taxi/Core/Services/auth_local_services.dart';
import 'package:taxi/Core/Services/auth_remote_services.dart';
import 'package:taxi/Features/Auth/ViewModel/cubit/auth_cubit.dart';

import 'core/Network/network_connection_checker.dart';

final sl = GetIt.instance;

Future<void> servicesLocator() async {
  //! Features - Auth

  // Bloc

  sl.registerFactory<AuthCubit>(
    () => AuthCubit(
        authLocalServices: sl(),
        authRemoteServices: sl(),
        networkConnectionChecker: sl()),
  );

  // Services
  sl.registerLazySingleton<AuthLocalServices>(
      () => AuthLocalServicesSharedPrefes(sl()));
  sl.registerLazySingleton<AuthRemoteServices>(
      () => AuthRemoteServicesFireBase());

  //! Core
  sl.registerLazySingleton<NetworkConnectionChecker>(
      () => NetworkConnectionCheckerImpl(sl()));

  //! External
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
