import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../utils/global_colors.dart';
import './home_screen.dart';

class SplashScreen extends StatelessWidget{
  const SplashScreen({ super.key });

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Lottie.asset("assets/animation_splash_screen.json"),
      backgroundColor: GlobalColors.primaryBackground,
      nextScreen: const HomeScreen(),
      duration: 2000,
    );
  }
}