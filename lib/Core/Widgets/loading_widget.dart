import 'package:flutter/material.dart';
import 'package:taxi/Core/Utils/Constants/color_constants.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      backgroundColor: Colors.transparent,
      child: Container(
        margin: const EdgeInsets.all(16.0),
        padding: const EdgeInsets.all(16.0),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            const SizedBox(
              width: 5,
            ),
            CircularProgressIndicator(
              valueColor:
                  AlwaysStoppedAnimation<Color>(ColorConstants.buttonColor2),
            ),
            const SizedBox(width: 25),
            const Text('Loading')
          ],
        ),
      ),
    );
  }
}
