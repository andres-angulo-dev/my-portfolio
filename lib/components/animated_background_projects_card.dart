import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';


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
            "assets/animation_projects_card.json",
            reverse: true,
            width: 600,
            height: 600,
          ),
        ),
      ],
    );
  }
}