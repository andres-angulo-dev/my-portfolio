import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../utils/global_others.dart';


class AnimatedBackgroundProjectsCard extends StatefulWidget {
  const AnimatedBackgroundProjectsCard({ super.key });

  @override
  State<AnimatedBackgroundProjectsCard> createState() => _AnimatedBackgroundProjectsCardState();
}

class _AnimatedBackgroundProjectsCardState extends State<AnimatedBackgroundProjectsCard> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {

    return Stack(
      children: [
        Positioned(
          child: Lottie.asset(
            AppImages.projectAnimatedDesk,
            reverse: true,
            width: 600,
            height: 600,
          ),
        ),
      ],
    );
  }
}