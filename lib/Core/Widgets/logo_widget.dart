import 'package:flutter/material.dart';
import 'package:taxi/Core/Utils/Constants/color_constants.dart';

import 'custom_text.dart';

class LogoWidget extends StatelessWidget {
  const LogoWidget({super.key, required this.width, required this.title});
  final String title;
  final double width;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image(
          alignment: Alignment.center,
          fit: BoxFit.contain,
          height: width * 0.5,
          image: const AssetImage(
            'assets/images/go_taxi_logo_1.png',
          ),
        ),
        CustomText(
          text: title,
          alignment: Alignment.center,
          fontFamily: 'Ubuntu-Bold',
          color: ColorConstants.logoColor2,
          fontSize: width * 0.06,
        ),
      ],
    );
  }
}
