import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import './download_cv_button.dart';
import '../utils/global_colors.dart';
import '../utils/global_others.dart';

class AboutMeCard extends StatelessWidget {
  const AboutMeCard({ super.key });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      margin: const EdgeInsets.only(bottom: 40),
      child: Stack(
        children: [
          // Background with oblique lines
          Positioned.fill(
            child: CustomPaint(
              painter: screenWidth < 968 ? BackgroundPainterMobile() : BackgroundPainterWeb(),
            ),
          ),
          // Main content
          kIsWeb ?
          screenWidth < 379 ?
          Container()
          :
          screenWidth < 968  ?
          Positioned(
            bottom: -65,
            right: -700,
            child: Image.asset(
              AppImages.aboutMeBackground,
              height: 600,
              fit: BoxFit.contain,
            )
          )
          :   
          Positioned(
            top: -340,
            right: -50,
            child: Image.asset(
              AppImages.aboutMeBackground,
              width: 1100,
              height: 1100,
              fit: BoxFit.contain,
            )
          )
          :
          Positioned(
            bottom: -65,
            right: -700,
            child: Image.asset(
              AppImages.aboutMeBackground,
              height: 600,
              fit: BoxFit.contain,
            )
          ),   
          Center(
            child: Padding(
              padding: screenWidth < 968 ? EdgeInsets.all(20.0) : EdgeInsets.all(70.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      screenWidth < 968 ? 
                      'Depuis le début de cette aventure,\n'
                      'j\'explore quotidiennement cet\n'
                      'univers fascinant du développe-\n'
                      'ment et du code. Une passion\n'
                      'grandissante qui me pousse à\n'
                      'affiner mes compétences et à\n'
                      'approfondir ma compréhension de ce domaine riche et complexe. '
                      'Mon parcours en développement web full-stack me permet de transformer des idées innovantes en solutions numériques.\n\n'
                      '🔍 Vision: Exploiter des solutions technologiques qui font la différence.\n\n'
                      '🚀 Motivation: L\'innovation constante, guidée par la curiosité et l\'envie de créer.\n\n'
                      '🌍 Engagement: Collaborer et apprendre pour évoluer dans un monde numérique en perpétuelle évolution.\n\n'
                      'Pour en savoir plus sur mon expérience profesionnelle, je vous invite à télécharger mon CV ci-dessous 👇' 
                      : 
                      'Depuis le début de cette aventure, j\'explore quotidiennement cet univers fascinant du\n'
                      'du développement et du code. Une passion grandissante qui me pousse à affiner mes\n'
                      'compétences et à approfondir ma compréhension de ce domaine riche et complexe.\n'
                      'Mon parcours en développement web full-stack me permet de transformer des idées\n'
                      'innovantes en solutions numériques.\n\n'
                      '🔍 Vision: Exploiter des solutions technologiques qui font la différence.\n\n'
                      '🚀 Motivation: L\'innovation constante, guidée par la curiosité et l\'envie de créer.\n\n'
                      '🌍 Engagement: Collaborer et apprendre pour évoluer dans un monde numérique en perpétuelle évolution.\n\n'
                      'Pour en savoir plus sur mon expérience profesionnelle, je vous invite à télécharger mon CV.',
                      style: const TextStyle(
                        fontSize: 16,
                        color: GlobalColors.textColor, // Text color for readability.
                      ),
                    ),
                    Container(
                      alignment: Alignment(0, 0),
                      width: 250,
                      height: 100,
                      child: Stack(
                        alignment: AlignmentDirectional.center,
                        children: [
                          DownloadCvButton(),
                          Container(
                            alignment: kIsWeb ? Alignment(1.05, -0.7) : Alignment(0.85, -0.5),
                            child: Lottie.asset(
                            AppImages.aboutMeAnimatedButton,
                              width: 50,
                              height: 50, 
                            ),
                          )
                        ],
                      )
                    )
                  ],
                ),
              ),
            ),
          ),
          screenWidth < 968 ?
          Positioned(
            top: 10,
            left: 270, // Top-lefy corner positioning.
            child: CircleAvatar(
              radius: 70, // Size of the avatar.
              backgroundColor: GlobalColors.tertiaryBackground, // Background color.
              child: ClipOval(
                // Fits the image within the circular shape.
                child: Transform.translate(
                  offset: const Offset(0, 0), // Adjust image position.
                  child: Image.asset(
                    AppImages.profile, // Profile image path.
                    height: 180,
                    fit: BoxFit.cover, // Ensures the image covers the avatar area.
                  ),
                ),
              ),
            ),
          ) :
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.fromLTRB(750, 50, 0, 0),
            // height: 220,
            // width: 220,
            child: CircleAvatar(
              radius: 110, // Size of the avatar.
              backgroundColor: GlobalColors.tertiaryBackground, // Background color.
              child: ClipOval(
                // Fits the image within the circular shape.
                child: Transform.translate(
                  offset: const Offset(0, 0), // Adjust image position.
                  child: Image.asset(
                    AppImages.profile, // Profile image path.
                    height: 220,
                    width: 220,
                    fit: BoxFit.cover, // Ensures the image covers the avatar area.
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BackgroundPainterWeb extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Paint for the shadow
    Paint shadowPaint = Paint()
      ..color = const Color.fromARGB(255, 0, 0, 0).withOpacity(0.4) // Shadow color with opacity
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, 10); // Blur effect for the shadow

    // Create the path for the shadow
    Path shadowPath = Path()
      ..moveTo(0, size.height * 0.10) // Corner top-left
      // ..lineTo(size.width, size.height * -0.12) // Corner top-right
      // ..lineTo(size.width, size.height +200) // Corner bottom-left
      ..lineTo(size.width, size.height * 0.9) // Corner bottom-left
      ..lineTo(0, size.height * 0.8) // Corner bottom-left
      ..close();

    canvas.drawPath(shadowPath, shadowPaint); // Draw the shadow

    // Paint for the white background
    Paint paint = Paint()..color = const Color.fromARGB(255, 255, 255, 255);

    // Create a background with oblique lines and larger size
    Path path = Path()
      ..moveTo(0, size.height * 0.05) // Corner top-left
      ..lineTo(size.width, size.height * 0.0) // Corner top-right
      ..lineTo(size.width, size.height * 0.9) // Corner bottom-right
      ..lineTo(0, size.height * 0.8) // Corner bottom-left
      ..close();

    canvas.drawPath(path, paint); // Draw the main path
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}


class BackgroundPainterMobile extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Paint for the shadow
    Paint shadowPaint = Paint()
      ..color = const Color.fromARGB(255, 0, 0, 0).withOpacity(0.4) // Shadow color with opacity
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, 10); // Blur effect for the shadow

    // Create the path for the shadow
    Path shadowPath = Path()
      ..moveTo(0, size.height * 0.10) // Corner top-left
      // ..lineTo(size.width, size.height * 0.0) // Corner top-right
      ..lineTo(size.width, size.height * 0.98) // Corner bottom-right
      ..lineTo(0, size.height * 0.95) // Corner bottom-left
      ..close();

    canvas.drawPath(shadowPath, shadowPaint); // Draw the shadow

    // Paint for the white background
    Paint paint = Paint()..color = const Color.fromARGB(255, 255, 255, 255);

    // Create a background with oblique lines and larger size
    Path path = Path()
      ..moveTo(0, size.height * 0.02) // Corner top-left
      ..lineTo(size.width, size.height * 0.0) // Corner top-right
      ..lineTo(size.width, size.height * 0.98) // Corner bottom-right
      ..lineTo(0, size.height * 0.95) // Corner bottom-left
      ..close();

    canvas.drawPath(path, paint); // Draw the main path
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}