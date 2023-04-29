import 'package:dartz/dartz.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

import '../Errors/exception.dart';

abstract class MapsRemoteServices {
  Future<CameraPosition> getPositionLocator();
  Future<Unit> requestLocationPermission();
}

class MapsRemoteServicesGeoLocator implements MapsRemoteServices {
  late final Position currentPosition;
  @override
  Future<CameraPosition> getPositionLocator() async {
    try {
      await requestLocationPermission();
      currentPosition = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.bestForNavigation);
      LatLng pos = LatLng(currentPosition.latitude, currentPosition.longitude);
      CameraPosition cp = CameraPosition(target: pos, zoom: 14);
      return cp;
    } catch (e) {
      print('####### CamPosLocNotFoundException ERROR :$e');
      throw CamPosLoErrorException();
    }
  }

  @override
  Future<Unit> requestLocationPermission() async {
    final permissionStatus = await Permission.location.request();
    if (permissionStatus == PermissionStatus.granted) {
      // User granted location permission, proceed with getting location
      print(
          '######## User granted location permission, proceed with getting location');
    } else {
      // User denied location permission, handle the error
      print('######## User denied location permission, handle the error');
    }
    return Future.value(unit);
  }
}
