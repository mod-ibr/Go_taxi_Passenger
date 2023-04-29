part of 'maps_cubit.dart';

abstract class MapsState extends Equatable {
  const MapsState();

  @override
  List<Object> get props => [];
}

class MapsInitial extends MapsState {}

class LoadingCurrentPostionState extends MapsState {}

class SucceededUpdateCameraPositionState extends MapsState {
  final CameraPosition cameraPosition;
  const SucceededUpdateCameraPositionState({required this.cameraPosition});
  @override
  List<Object> get props => [cameraPosition];
}

class ErrorUpdateCameraPositionState extends MapsState {
  final String message;

  const ErrorUpdateCameraPositionState({required this.message});
  @override
  List<Object> get props => [message];
}

class RefreshState extends MapsState {}
