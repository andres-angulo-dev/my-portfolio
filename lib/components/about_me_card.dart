import 'package:flutter/material.dart';
import './download_cv_button.dart';
import '../utils/global_colors.dart';
import '../utils/global_others.dart';

class AboutMeCard extends StatelessWidget {
  const AboutMeCard({ super.key });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10, // Adds a shadow effect.
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12), // Rounded corners.
      ),
      color: GlobalColors.cardBackground, // Custom background color.
      margin: const EdgeInsets.fromLTRB(10, 0, 10, 40),
      child: SingleChildScrollView(
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0), // Internal padding.
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center, // Center items horizontally.
              children: [
                Text(
                  'Depuis le début de cette aventure,\n'
                  'j\'explore quotidiennement cet\n'
                  'univers fascinant du développe-\n'
                  'ment et du code. Une passion\n'
                  'grandissante qui me pousse à\n'
                  'affiner mes compétences et à\n'
                  'approfondir ma compréhension de ce domaine riche et complexe. '
                  'Mon parcours en développement web full-stack me permet de transformer des idées innovantes en solutions numériques. Je vous invite à découvrir certains de mes projets.\n\n'
                  '🔍 Vision: Apporter des solutions technologiques qui font la différence.\n\n'
                  '🚀 Motivation: L\'innovation constante, guidée par la curiosité et l\'envie de créer.\n\n'
                  '🌍 Engagement: Collaborer et apprendre pour évoluer dans un monde numérique en perpétuelle évolution.',
                  style: const TextStyle(
                    fontSize: 16,
                    color: GlobalColors.textColor, // Text color for readability.
                  ),
                ),
                const SizedBox(height: 20),
                DownloadCvButton(),
              ],
            ),
          ),
          Positioned(
            top: 10,
            right: 3, // Top-right corner positioning.
            child: CircleAvatar(
              radius: 70, // Size of the avatar.
              backgroundColor: Color(0xFFA3B18A), // Background color.
              child: ClipOval(
                // Fits the image within the circular shape.
                child: Transform.translate(
                  offset: const Offset(25, 5), // Adjust image position.
                  child: Image.asset(
                    AppImages.profile, // Profile image path.
                    height: 180,
                    fit: BoxFit.cover, // Ensures the image covers the avatar area.
                  ),
                ),
              ),
            ),
          ),
        ],
      ),

      ) // External margin.
    );
  }
}
