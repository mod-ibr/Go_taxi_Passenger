import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taxi/Core/Errors/exception.dart';

import '../Utils/Constants/maps_constants.dart';

abstract class MapsLocalServices {
  Future<Unit> setPositionLocator(
      {required CameraPosition cameraPosition,
      required CamPosLocType camPosLocType});
  Future<CameraPosition> getPositionLocator(
      {required CamPosLocType camPosLocType});
}

class MapsLocalServicesSharedPrefes implements MapsLocalServices {
  final SharedPreferences sharedPreferences;

  MapsLocalServicesSharedPrefes(this.sharedPreferences);

  @override
  Future<Unit> setPositionLocator(
      {required CameraPosition cameraPosition,
      required CamPosLocType camPosLocType}) async {
    // Convert the CameraPosition object to a Map
    Map<String, Object> cameraPositionMap =
        cameraPosition.toMap() as Map<String, Object>;

    // Convert the Map to a JSON string
    String cameraPositionJson = jsonEncode(cameraPositionMap);

    if (camPosLocType == CamPosLocType.currentLocation) {
      await sharedPreferences.setString(
          MapsConstants.currentPosLoc, cameraPositionJson);
    } else if (camPosLocType == CamPosLocType.home) {
      await sharedPreferences.setString(
          MapsConstants.homePosLoc, cameraPositionJson);
    } else if (camPosLocType == CamPosLocType.work) {
      await sharedPreferences.setString(
          MapsConstants.workPosLoc, cameraPositionJson);
    }
    return Future.value(unit);
  }

  @override
  Future<CameraPosition> getPositionLocator(
      {required CamPosLocType camPosLocType}) async {
    late final String camPosLoc;

    // get the Camera Position Locarot String
    if (camPosLocType == CamPosLocType.currentLocation) {
      camPosLoc =
          sharedPreferences.getString(MapsConstants.currentPosLoc) ?? '';
    } else if (camPosLocType == CamPosLocType.home) {
      camPosLoc = sharedPreferences.getString(MapsConstants.homePosLoc) ?? '';
    } else if (camPosLocType == CamPosLocType.work) {
      camPosLoc = sharedPreferences.getString(MapsConstants.workPosLoc) ?? '';
    }

    // convert Camera Position Locator String to CameraPosation
    if (camPosLoc.isNotEmpty) {
      // Convert the JSON string to a Map
      Map<String, dynamic> cameraPositionMap = jsonDecode(camPosLoc);

      // Create a new CameraPosition object from the Map
      CameraPosition savedCameraPosition =
          CameraPosition.fromMap(cameraPositionMap)!;

      return savedCameraPosition;
    } else {
      throw CamPosLocNotFoundException();
    }
  }
}
