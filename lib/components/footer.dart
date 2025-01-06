import 'package:andres_angulo_portfolio/utils/global_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class Footer extends StatelessWidget {
  const Footer({ super.key });

  @override
  Widget build(BuildContext context) {
    // Get the screen width
    final screenWidth = MediaQuery.of(context).size.width;
    // Set padding value as a percentage of screen width
    final paddingValue = screenWidth * 0.125; // 20% of screen width

    return Column(
      children: [
        Padding(
          padding: kIsWeb ? EdgeInsets.symmetric(horizontal: paddingValue) : EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
          child: Container(
            margin: EdgeInsets.only(bottom: 15.0),
            height: 1.0,
            color: GlobalColors.titleColor,
          ),
        ),
        Container(
          margin: EdgeInsets.only(bottom: 15),
          child: Text(
            '© 2024 | By Andrés Angulo',
            style: TextStyle(
              color: GlobalColors.titleColor,
            ),
          ),
        ),
      ],
    ); 
  }
}
