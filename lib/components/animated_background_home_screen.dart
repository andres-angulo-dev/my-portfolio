import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';


class AnimatedBackgroundHomeScreen extends StatefulWidget {
  const AnimatedBackgroundHomeScreen({ super.key });

  @override
  State<AnimatedBackgroundHomeScreen> createState() => _AnimatedBackgroundHomeScreenState();
}

class _AnimatedBackgroundHomeScreenState extends State<AnimatedBackgroundHomeScreen> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Stack(
      children: [
        screenWidth < 768 ? 
        Positioned(
          child: Lottie.asset(
            "assets/home_mobile.json",
            // width: 3000,
            height: 3600,
            reverse: true,
            fit: BoxFit.cover,
          ),
        )
        :
        Positioned(
          child: Lottie.asset(
            "assets/home_web.json",
            width: 3000,
            height: 3000,
            reverse: true,
          ),
        ),
      ],
    );
  }
}