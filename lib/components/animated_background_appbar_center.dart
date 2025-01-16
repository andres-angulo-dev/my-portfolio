import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AnimatedBackgroundAppBarCenter extends StatelessWidget {
  const AnimatedBackgroundAppBarCenter({ super.key });
  
  @override
  Widget build(BuildContext context) {
  final screenWidth = MediaQuery.of(context).size.width;
  final web = Image.asset('assets/animation_web.gif');
  final mobile = Image.asset('assets/animation_mobile.gif');

    return Center(
      child: screenWidth < 1620 ? mobile : web,
    );
  }
}
