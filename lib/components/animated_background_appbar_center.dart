import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../utils/global_others.dart';

class AnimatedBackgroundAppBarCenter extends StatelessWidget {
  const AnimatedBackgroundAppBarCenter({ super.key });
  
  @override
  Widget build(BuildContext context) {
  final screenWidth = MediaQuery.of(context).size.width;
  final web = Image.asset(AppImages.appbarAnimatedMainWeb);
  final mobile = Image.asset(AppImages.appbarAnimatedMainMobile);

    return Center(
      child: screenWidth < 1620 ? mobile : web,
    );
  }
}
