import 'package:flutter/material.dart';

import '../../../../Core/Utils/Constants/color_constants.dart';
import '../widgets/signup_view_widgets/signup_view_body.dart';
 
class SignUpView extends StatelessWidget {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: ColorConstants.backGroundColor1,
      body: SignUpViewBody(height: height, width: width),
    );
  }
}
