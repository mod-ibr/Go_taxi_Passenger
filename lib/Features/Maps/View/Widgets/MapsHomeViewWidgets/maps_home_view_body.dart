import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:taxi/Core/Widgets/loading_widget.dart';
import 'package:taxi/Features/Maps/View/Widgets/MapsHomeViewWidgets/loc_perm_denied_widget.dart';

import '../../../../../Core/Utils/Constants/color_constants.dart';
import '../../../../../Core/Widgets/custom_text.dart';
import '../../../../../Core/Widgets/divider.dart';
import '../../../ViewModel/MapsCubit/maps_cubit.dart';

int counter = 0;

// ignore: must_be_immutable
class MapsHomeViewBody extends StatelessWidget {
  final double width, height;
  final GlobalKey<ScaffoldState> globalKey;
  MapsHomeViewBody(
      {super.key,
      required this.width,
      required this.height,
      required this.globalKey});

//--------FOR MAPS-------------
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  late GoogleMapController googleMapController;

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );
  // -----------------------------
  @override
  Widget build(BuildContext context) {
    return _mapsHomeViewBody(width: width, height: height);
  }

  Widget _mapsHomeViewBody({required double width, required double height}) {
    return Stack(
      children: [_mapAndBottomSheetWidget(), _drawerButton()],
    );
  }

  Widget _mapAndBottomSheetWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        BlocBuilder<MapsCubit, MapsState>(
          builder: (context, state) {
            if (state is SucceededUpdateCameraPositionState) {
              googleMapController.animateCamera(
                  CameraUpdate.newCameraPosition(state.cameraPosition));
            } else if (state is LoadingCurrentPostionState) {
              return const LoadingWidget();
            } else if (state is ErrorUpdateCameraPositionState) {
              return Expanded(
                child: LocPermDenied(width: width, height: height),
              );
            } else if (state is RefreshState) {}
            return Expanded(
              child: GoogleMap(
                mapType: MapType.normal,
                myLocationButtonEnabled: true,
                myLocationEnabled: true,
                zoomGesturesEnabled: true,
                zoomControlsEnabled: true,
                initialCameraPosition: _kGooglePlex,
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                  googleMapController = controller;

                  BlocProvider.of<MapsCubit>(context).setUpPositionLocator();
                  if (state is SucceededUpdateCameraPositionState) {
                    googleMapController.animateCamera(
                        CameraUpdate.newCameraPosition(state.cameraPosition));
                  }
                },
              ),
            );
          },
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
          height: height * 0.31,
          decoration: const BoxDecoration(
              color: ColorConstants.backGroundColor1,
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 15.0,
                  spreadRadius: 0.5,
                  offset: Offset(0.7, 0.7),
                ),
              ]),
          child: _customeBottomSheetWidget(),
        )
      ],
    );
  }

  Widget _customeBottomSheetWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 5),
        const CustomText(text: 'Text One', fontSize: 10),
        const CustomText(text: 'Text Tow', fontSize: 18),
        const SizedBox(height: 20),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 5.0,
                spreadRadius: 0.5,
                offset: Offset(0.7, 0.7),
              ),
            ],
          ),
          child: Row(
            children: const [
              Icon(
                Icons.search,
                color: ColorConstants.logoColor2,
              ),
              SizedBox(height: 10),
              CustomText(
                text: 'Search Destination',
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        _addTile(
            icon: Icons.home,
            title: 'Add Home',
            description: 'Add Your Home Address'),
        const SizedBox(height: 10),
        const CustomeDivider(),
        const SizedBox(height: 15),
        _addTile(
            icon: Icons.work,
            title: 'Add Work',
            description: 'Add Your Work Address'),
        const SizedBox(height: 5),
      ],
    );
  }

  Widget _addTile(
      {required IconData icon,
      required String title,
      required String description}) {
    return Row(
      children: [
        Icon(
          icon,
          color: ColorConstants.logoColor2,
        ),
        const SizedBox(width: 5),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(text: title),
            const SizedBox(height: 3),
            CustomText(
              text: description,
              fontSize: 11,
              color: ColorConstants.grayText,
            ),
          ],
        ),
      ],
    );
  }

  Widget _drawerButton() {
    return Positioned(
      left: width * 0.05,
      top: width * 0.09,
      child: InkWell(
        onTap: () {
          globalKey.currentState!.openDrawer();
        },
        child: Container(
          decoration: BoxDecoration(
            color: ColorConstants.backGroundColor1,
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [
              BoxShadow(
                color: ColorConstants.grayText,
                blurRadius: 5,
                spreadRadius: 0.5,
                offset: Offset(0.7, 0.7),
              )
            ],
          ),
          child: const CircleAvatar(
            radius: 20,
            backgroundColor: ColorConstants.backGroundColor1,
            child: Icon(
              Icons.menu,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
