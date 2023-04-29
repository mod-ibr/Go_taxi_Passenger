import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:taxi/Core/Errors/failures.dart';

import '../../../../Core/Errors/errors_strings.dart';
import '../../../../Core/Errors/exception.dart';
import '../../../../core/Network/network_connection_checker.dart';

import '../../../../Core/Services/maps_local_services.dart';
import '../../../../Core/Services/maps_remote_services.dart';

part 'maps_state.dart';

class MapsCubit extends Cubit<MapsState> {
  final MapsLocalServices mapsLocalServices;
  final MapsRemoteServices mapsRemoteServices;
  final NetworkConnectionChecker networkConnectionChecker;
  late final CameraPosition cameraPosition;
  MapsCubit(
      {required this.mapsRemoteServices,
      required this.mapsLocalServices,
      required this.networkConnectionChecker})
      : super(MapsInitial());

  void setUpPositionLocator() async {
    emit(LoadingCurrentPostionState());
    final Either<Failure, CameraPosition> failureOrSuccess =
        await _setUpPositionLocator();
    failureOrSuccess.fold(
      (failure) => emit(ErrorUpdateCameraPositionState(
          message: _mapFailureToMessage(failure))),
      (success) {
        emit(SucceededUpdateCameraPositionState(cameraPosition: success));
      },
    );
  }

  Future<Either<Failure, CameraPosition>> _setUpPositionLocator() async {
    try {
      CameraPosition cameraPosition =
          await mapsRemoteServices.getPositionLocator();

      return Right(cameraPosition);
    } on CamPosLoErrorException {
      return Left(CamPosLocErrorFailure());
    }
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return ErrorsStrings.serverFailureMessage;
      case OfflineFailure:
        return ErrorsStrings.offlineFailureMessage;
      case CamPosLocNotFoundFailure:
        return ErrorsStrings.camPosLocNotFoundFailureMessage;
      case CamPosLocErrorFailure:
        return ErrorsStrings.camPosLocErrorFailureMessage;
      default:
        return "Unexpected Error , Please try again later .";
    }
  }

  void refreshTheState() async {
    emit(RefreshState());
  }
}
