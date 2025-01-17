import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Import this package to access SystemChrome who handle the statusBar
import 'package:rive/rive.dart';
import '../utils/global_colors.dart';
import './home_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // To customize the status bar
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: GlobalColors.primaryBackground, 
      statusBarIconBrightness: Brightness.light, // Light icons for Android
      statusBarBrightness: Brightness.dark, // Dark icons for iOS
    ));
    
    return Container(
      color: GlobalColors.primaryBackground,
      child: Center(
        child: SizedBox(
          width: 300,
          height: 300,
          child: AnimatedSplashScreen(
            // splash: Lottie.asset("assets/animation_splash_screen.json"),
            splash: RiveAnimation.asset(
              "assets/my_logo.riv",
              fit: BoxFit.cover,
            ),
            backgroundColor: GlobalColors.primaryBackground,
            nextScreen: const HomeScreen(),
            duration: 1500,
          ),
        ),
      ) ,    
    );
  }
}
