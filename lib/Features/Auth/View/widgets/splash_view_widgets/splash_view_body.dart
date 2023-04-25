import 'package:flutter/material.dart';

import '../../../../../Core/Widgets/go_taxi_logo.dart';

class SplashViewWBody extends StatelessWidget {
  final double width, height;
  final Animation<double> logoAnimation;
  final Animation<double> textAnimation;

  const SplashViewWBody(
      {super.key,
      required this.width,
      required this.height,
      required this.logoAnimation,
      required this.textAnimation});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Animated app logo
          TweenAnimationBuilder(
            duration: const Duration(seconds: 3),
            curve: Curves.easeOut,
            tween: Tween<double>(begin: 1.0, end: 0.0),
            builder: (context, value, child) => Transform.translate(
              offset: Offset(logoAnimation.value * width, width * 0.15),
              child: child,
            ),
            child: Image.asset(
              'assets/images/go_taxi_logo_2.png',
              width: width,
              height: height * 0.4,
              fit: BoxFit.cover,
            ),
          ),

          // Animated text
          TweenAnimationBuilder(
            duration: const Duration(seconds: 3),
            curve: Curves.easeOut,
            tween: Tween<double>(begin: -1.0, end: 0.0),
            builder: (context, value, child) => Transform.translate(
              offset: Offset(0.0, textAnimation.value * 90),
              child: child,
            ),
            child: Column(
              children: [
                GoTaxiLogo(width: width),
                const SizedBox(height: 8),
                const Text(
                  'Taxi services for Making your world easier',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
