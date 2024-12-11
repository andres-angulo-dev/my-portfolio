import 'package:flutter/material.dart';

class AboutMeCard extends StatelessWidget {
  const AboutMeCard({ super.key });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10, // Adds a shadow effect.
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12), // Rounded corners.
      ),
      color: Color(0xFF2E324E), // Custom background color.
      margin: const EdgeInsets.fromLTRB(10, 0, 10, 40), // External margin.
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0), // Internal padding.
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center, // Center items horizontally.
              children: [
                Text(
                  'Depuis le début de cette aven-\n'
                  'ture, j\'explore quotidienne-\n'
                  'ment '
                  'l\'univers fascinant du\n'
                  'développement et du code.\n'
                  'Cette passion grandissante me\n'
                  'pousse à affiner mes compétences\n'
                  'et à approfondir ma compréhension de ce domaine riche et complexe. '
                  'Mon parcours en développement web full-stack me permet de transformer des idées innovantes en solutions numériques. Je vous invite à découvrir certains de mes projets.\n\n'
                  '🔍 Vision: Apporter des solutions technologiques qui font la différence.\n\n'
                  '🚀 Motivation: L\'innovation constante, guidée par la curiosité et l\'envie de créer.\n\n'
                  '🌍 Engagement: Collaborer et apprendre pour évoluer dans un monde numérique en perpétuelle évolution.',
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white, // Text color for readability.
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 10,
            right: 10, // Top-right corner positioning.
            child: CircleAvatar(
              radius: 70, // Size of the avatar.
              backgroundColor: Colors.white, // Background color.
              child: ClipOval(
                // Fits the image within the circular shape.
                child: Transform.translate(
                  offset: const Offset(25, 2), // Adjust image position.
                  child: Image.asset(
                    'assets/profile.png', // Profile image path.
                    width: 180,
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
