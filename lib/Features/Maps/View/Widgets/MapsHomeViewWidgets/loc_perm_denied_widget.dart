import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taxi/Core/Utils/Constants/color_constants.dart';
import 'package:taxi/Core/Widgets/custom_text.dart';
import 'package:taxi/Features/Maps/ViewModel/MapsCubit/maps_cubit.dart';

class LocPermDenied extends StatelessWidget {
  final double width, height;
  const LocPermDenied({super.key, required this.width, required this.height});

  @override
  Widget build(BuildContext context) {
    return _locationPermissionDenied(context);
  }

  Widget _locationPermissionDenied(context) {
    return SizedBox(
      width: width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: width * 0.25),
          Icon(
            Icons.location_off_outlined,
            color: Colors.red,
            size: width * 0.3,
          ),
          SizedBox(height: width * 0.09),
          CustomText(
            alignment: Alignment.center,
            text: "Location permission denied ",
            color: Colors.red,
            fontSize: width * 0.07,
          ),
          SizedBox(height: width * 0.04),
          CustomText(
            alignment: Alignment.center,
            text: "User denied permissions to access",
            fontSize: width * 0.05,
          ),
          CustomText(
            alignment: Alignment.center,
            text: " the device's location, Please..",
            fontSize: width * 0.05,
          ),
          const SizedBox(height: 4),
          TextButton(
            onPressed: () {
              BlocProvider.of<MapsCubit>(context).refreshTheState();
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomText(
                  color: ColorConstants.buttonColor2,
                  alignment: Alignment.center,
                  text: "Tap to accept the permissions",
                  fontSize: width * 0.05,
                ),
                Icon(
                  Icons.refresh,
                  color: ColorConstants.buttonColor2,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
