import 'package:flutter/material.dart';
import 'package:taxi/Core/Utils/Constants/color_constants.dart';

class CustomeDivider extends StatelessWidget {
  final double height = 1;
  const CustomeDivider({super.key, hight});

  @override
  Widget build(BuildContext context) {
    return Divider(
      height: height,
      color: ColorConstants.grayText,
    );
  }
}
