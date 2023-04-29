import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taxi/Core/Services/auth_local_services.dart';
import 'package:taxi/Core/Services/auth_remote_services.dart';
import 'package:taxi/Core/Services/maps_local_services.dart';
import 'package:taxi/Core/Services/maps_remote_services.dart';
import 'package:taxi/Features/Maps/ViewModel/MapsCubit/maps_cubit.dart';

import 'Features/Auth/ViewModel/cubit/auth_cubit.dart';
import 'core/Network/network_connection_checker.dart';

final sl = GetIt.instance;

Future<void> servicesLocator() async {
  //! Features

  // Auth Bloc

  sl.registerLazySingleton<AuthCubit>(
    () => AuthCubit(
      authLocalServices: sl(),
      authRemoteServices: sl(),
      networkConnectionChecker: sl(),
    ),
  );

  // Maps Bloc
  sl.registerLazySingleton<MapsCubit>(
    () => MapsCubit(
      mapsRemoteServices: sl<MapsRemoteServices>(),
      mapsLocalServices: sl<MapsLocalServices>(),
      networkConnectionChecker: sl<NetworkConnectionChecker>(),
    ),
  );
  //! Core

  //Auth Services
  sl.registerLazySingleton<NetworkConnectionChecker>(
      () => NetworkConnectionCheckerImpl(sl()));
  sl.registerLazySingleton<AuthLocalServices>(
      () => AuthLocalServicesSharedPrefes(sl()));
  sl.registerLazySingleton<AuthRemoteServices>(
      () => AuthRemoteServicesFireBase());
  //Maps Services
  sl.registerLazySingleton<MapsLocalServices>(
      () => MapsLocalServicesSharedPrefes(sl<SharedPreferences>()));
  sl.registerLazySingleton<MapsRemoteServices>(
      () => MapsRemoteServicesGeoLocator());

  //! External
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
