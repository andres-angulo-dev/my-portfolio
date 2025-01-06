import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../utils/global_colors.dart';

class SkillsCard extends StatefulWidget {
  const SkillsCard({super.key});

  @override
  SkillsCardState createState() => SkillsCardState();
}

class SkillsCardState extends State<SkillsCard> with SingleTickerProviderStateMixin {
    // List of skills with properties for display.
    List<Map<String, dynamic>> skills = [
      {
        'title': 'Création de sites web sur mesure',
        'color': GlobalColors.skillsCardBorder1,
        'description': 'Conception de sites web personnalisés en utilisant les technologies les plus récentes et les tendances de design actuelles qui offrira aux visiteurs une expérience unique et engageante.',
        'icon': FontAwesomeIcons.computer,
      },
      {
        'title': 'Développement d\'applications mobile',
        'color': GlobalColors.skillsCardBorder2,
        'description': 'Développement d\'applications mobiles interactives performantes et sécurisées en améliorant l\'expérience utilisateur avec des solutions mobiles innovantes et adaptées.',
        'icon': FontAwesomeIcons.mobile,
      },
      {
        'title': 'Optimisation pour les moteurs de recherche (SEO)',
        'color': GlobalColors.skillsCardBorder3,
        'description': 'Amélioration de la performance et de la visibilité du site web grâce à des techniques de référencement naturel et une analyse approfondie des mots-clés qui attire un trafic ciblé pour maximiser la portée en ligne.',
        'icon': FontAwesomeIcons.magnifyingGlass,
      },
      {
        'title': 'Hébergement & Déploiement',
        'color': GlobalColors.skillsCardBorder4,
        'description': 'Déploiement des solutions sur les plateformes adaptées, simplifiant les interactions avec les prestataires de services.',
        'icon': FontAwesomeIcons.powerOff,
      },
    ];

  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
  }

  void _startAnimation() {
    if (!_controller.isAnimating) {
      _controller.forward();
    }
  }

    @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15.0), // Margin at the bottom of the container.
      child: kIsWeb
        ? Wrap(
            spacing: 10.0,
            runSpacing: 10.0,
            alignment: WrapAlignment.center,
            children: skills.asMap().entries.map((entry) {
              int index = entry.key;
              var skill = entry.value;
              return VisibilityDetector(
                key: Key('skills-card-visibility-$index'),
                onVisibilityChanged: (VisibilityInfo info) {
                  if (info.visibleFraction > 0.1 && index == 0) {
                    _startAnimation();
                  }
                },
                child: SlideTransition(
                  position: Tween<Offset>(
                    begin: Offset(index.isEven ? -1 : 1, 0),
                    end: Offset.zero,
                  ).animate(CurvedAnimation(
                    parent: _controller,
                    curve: Interval((1 / skills.length) * index, 1, curve: Curves.ease),
                  )),
                  child: FadeTransition(
                    opacity: _controller.drive(
                      CurveTween(
                        curve: Interval((1 / skills.length) * index, 1, curve: Curves.linear),
                      ),
                    ),
                    child: Card(
                      color: skill['color'], // Card color based on skill's color.
                      elevation: 10, // Shadow effect for the card.
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12), // Rounded corners for the card.
                      ),
                      margin: const EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 25), // Margin around the card.
                      child: Stack(
                        clipBehavior: Clip.none, // Allow elements to extend beyond the bounds of the stack.
                        children: [
                          SizedBox(
                            height: 330.0,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start, // Align children to the start horizontally.
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: skill['color'], // Background color based on skill's color.
                                    border: Border.all(color: skill['color'], width: 1), // Border color and width.
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(12),
                                      topRight: Radius.circular(12),
                                    ), // Rounded corners for the top of the card.
                                  ),
                                  width: double.infinity, // Full width container.
                                  height: 50.0, // Fixed height for the title container.
                                  alignment: Alignment.center, // Center align the text.
                                  child: Text(
                                    skill['title'],
                                    style: const TextStyle(
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
                                      borderRadius: const BorderRadius.only(
                                        bottomLeft: Radius.circular(12),
                                        bottomRight: Radius.circular(12),
                                      ), // Rounded corners for the bottom of the card.
                                    ),
                                    padding: const EdgeInsets.all(20.0), // Padding inside the container.
                                    child: Text(
                                      skill['description'],
                                      style: const TextStyle(
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
                                padding: const EdgeInsets.all(8), // Padding inside the icon container.
                                child: FaIcon(skill['icon'], color: GlobalColors.skillsIconBlack, size: 24), // Display the skill icon.
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ).ifWeb(
                  kIsWeb ? 350.0 : double.infinity,
                ),
              );
            }).toList(),
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start, // Align children to the start horizontally.
            children: skills.asMap().entries.map((entry) {
              int index = entry.key;
              var skill = entry.value;
              return VisibilityDetector(
                key: Key('skills-card-visibility-$index'),
                onVisibilityChanged: (VisibilityInfo info) {
                  if (info.visibleFraction > 0.5 && index == 0) {
                    _startAnimation();
                  }
                },
                child: SlideTransition(
                  position: Tween<Offset>(
                    begin: Offset(index.isEven ? -1 : 1, 0),
                    end: Offset.zero,
                  ).animate(CurvedAnimation(
                    parent: _controller,
                    curve: Interval((1 / skills.length) * index, 1, curve: Curves.easeInOut),
                  )),
                  child: FadeTransition(
                    opacity: _controller.drive(
                      CurveTween(
                        curve: Interval(
                          (1 / skills.length) * index,
                          1,
                          curve: Curves.easeInOut,
                        ),
                      ),
                    ),
                    child: Card(
                      color: skill['color'], // Card color based on skill's color.
                      elevation: 10, // Shadow effect for the card.
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12), // Rounded corners for the card.
                      ),
                      margin: const EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 25), // Margin around the card.
                      child: Stack(
                        clipBehavior: Clip.none, // Allow elements to extend beyond the bounds of the stack.
                        children: [
                          SizedBox(
                            height: 330.0,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start, // Align children to the start horizontally.
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: skill['color'], // Background color based on skill's color.
                                    border: Border.all(color: skill['color'], width: 1), // Border color and width.
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(12),
                                      topRight: Radius.circular(12),
                                    ), // Rounded corners for the top of the card.
                                  ),
                                  width: double.infinity, // Full width container.
                                  height: 50.0, // Fixed height for the title container.
                                  alignment: Alignment.center, // Center align the text.
                                  child: Text(
                                    skill['title'],
                                    style: const TextStyle(
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
                                      borderRadius: const BorderRadius.only(
                                        bottomLeft: Radius.circular(12),
                                        bottomRight: Radius.circular(12),
                                      ), // Rounded corners for the bottom of the card.
                                    ),
                                    padding: const EdgeInsets.all(20.0), // Padding inside the container.
                                    child: Text(
                                      skill['description'],
                                      style: const TextStyle(
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
                                padding: const EdgeInsets.all(8), // Padding inside the icon container.
                                child: FaIcon(skill['icon'], color: GlobalColors.skillsIconBlack, size: 24), // Display the skill icon.
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              );
              }).toList(),
            ),
      );
  }
}

extension on Widget {
  Widget ifWeb(double width) {
    return SizedBox(
      width: width,
      child: this,
    );
  }
}
