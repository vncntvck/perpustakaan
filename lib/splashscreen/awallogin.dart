import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:perpustakaan/login/sigin.dart';

class awallogin extends StatelessWidget {
  const awallogin({super.key});

  get splash => null;

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(splash:
    Column(
      children: [
        Center(
          child: LottieBuilder.asset("lottie/Animation - 1717042803910.json"),
        )
      ],
    ), nextScreen: Sigin(),
    splashIconSize: 200,
    backgroundColor: Colors.blue,);
  }
}