import 'package:flutter/material.dart';
import 'package:taxi/Core/Utils/Constants/color_constants.dart';

class GoTaxiLogo extends StatelessWidget {
  final double width;
  const GoTaxiLogo({super.key, required this.width});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: const [
            Text(
              'Go',
              style: TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.normal,
                  color: ColorConstants.logoColor1),
            ),
            Text(
              'Taxi',
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
          ],
        ),
        Positioned(
          bottom: 0,
          left: width * 0.38,
          right: width * 0.315,
          child: Container(
            height: 2,
            decoration: BoxDecoration(
              color: ColorConstants.logoColor1,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        )
      ],
    );
  }
}
