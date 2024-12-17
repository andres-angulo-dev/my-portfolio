import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../utils/global_colors.dart';

class SkillsCard extends StatelessWidget {
  const SkillsCard({super.key});

  @override
  Widget build(BuildContext context) {
    // List of skills with properties for display.
    List<Map<String, dynamic>> skills = [
      {
        'title': 'Création de sites web sur mesure',
        'color': GlobalColors.skillsCardBorder1,
        'description': 'Conception de sites web personnalisés, en tenant compte des dernières technologies et tendances de design.',
        'icon': FontAwesomeIcons.computer,
      },
      {
        'title': 'Développement d\'applications web',
        'color': GlobalColors.skillsCardBorder2,
        'description': 'Création d\'applications web interactives, performantes et sécruriséss, tout en améliorant l\'expérience utilisateur.',
        'icon': FontAwesomeIcons.mobile,
      },
      {
        'title': 'Optimisation pour les moteurs de recherche (SEO)',
        'color': GlobalColors.skillsCardBorder3,
        'description': 'Amélioration de la visibilité en ligne par l\'optimisation du site web pour les moteurs de recherche.',
        'icon': FontAwesomeIcons.magnifyingGlass,
      },
      {
        'title': 'Hébergement & Déploiement',
        'color': GlobalColors.skillsCardBorder4,
        'description': 'Déploiement des solutions sur les plateformes adaptées, simplifiant les interactions avec les prestataires de services.',
        'icon': FontAwesomeIcons.powerOff,
      },
    ];

    return Container(
      margin: EdgeInsets.only(bottom: 15), // Margin at the bottom of the container.
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, // Align children to the start horizontally.
        children: skills.map((skill) {
          return Card(
            color: skill['color'], // Card color based on skill's color.
            elevation: 10, // Shadow effect for the card.
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12), // Rounded corners for the card.
            ),
            margin: EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 25), // Margin around the card.
            child: Stack(
              clipBehavior: Clip.none, // Allow elements to extend beyond the bounds of the stack.
              children: [
                SizedBox(
                  height: 230,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start, // Align children to the start horizontally.
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: skill['color'], // Background color based on skill's color.
                          border: Border.all(color: skill['color'], width: 1), // Border color and width.
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(12),
                            topRight: Radius.circular(12),
                          ), // Rounded corners for the top of the card.
                        ),
                        width: double.infinity, // Full width container.
                        height: 50, // Fixed height for the title container.
                        alignment: Alignment.center, // Center align the text.
                        child: Text(
                          skill['title'],
                          style: TextStyle(
                            fontSize: 14,
                            color: GlobalColors.textColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: GlobalColors.cardBackground, // Background color for the description container.
                            border: Border.all(color: skill['color'], width: 3), // Border color and width.
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(12),
                              bottomRight: Radius.circular(12),
                            ), // Rounded corners for the bottom of the card.
                          ),
                          padding: const EdgeInsets.all(20.0), // Padding inside the container.
                          child: Text(
                            skill['description'],
                            style: TextStyle(
                              fontSize: 14,
                              color: GlobalColors.textColor,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: -20, // Position the icon outside the bottom of the card.
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Container(
                      decoration: BoxDecoration(
                        color: skill['color'], // Background color based on skill's color.
                        shape: BoxShape.circle, // Circular shape for the icon container.
                        border: Border.all(color: skill['color'], width: 2), // Border color and width.
                      ),
                      padding: EdgeInsets.all(8), // Padding inside the icon container.
                      child: FaIcon(skill['icon'], color: GlobalColors.skillsIconBlack, size: 24), // Display the skill icon.
                    ),
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
