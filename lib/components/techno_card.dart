import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TechnoCard extends StatelessWidget {
  final String title;
  final Color color;
  final List<Map<String, dynamic>> technologies;

  const TechnoCard({ super.key, required this.title, required this.color, required this.technologies });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10, // Adds a shadow effect to the card.
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12), // Rounded corners for the card.
      ),
      color: color, // Background color of the card.
      margin: const EdgeInsets.fromLTRB(5, 5, 5, 25), // Margin around the card.
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, // Align children to the start horizontally.
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.grey[800], // Background color of the container.
              border: Border.all(color: Colors.white, width: 1), // Border color and width.
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ), // Rounded corners for the top of the container.
            ),
            padding: const EdgeInsets.all(20.0), // Padding inside the container.
            child: Center(
              child: Wrap(
                alignment: WrapAlignment.center, // Center align the wrapped children.
                spacing: 20.0, // Space between the children horizontally.
                runSpacing: 20.0, // Space between the children vertically.
                children: technologies.map((techno) {
                  return Column(
                    children: [
                      FaIcon(techno['icon'], size: 40, color: techno['color']), // Display the technology icon.
                      SizedBox(height: 6), // Space between the icon and the text.
                      Text(
                        techno['label'],
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  );
                }).toList(),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.amber, width: 3), // Border color and width for the bottom container.
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12),
              ), // Rounded corners for the bottom of the container.
            ),
            width: double.infinity, // Full width container.
            height: 30, // Fixed height for the title container.
            alignment: Alignment.center, // Center align the text.
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TechnologiesCard extends StatelessWidget {
  const TechnologiesCard({super.key});

  @override
  Widget build(BuildContext context) {
    final Color backgroundColorTitle = Colors.amber; // Background color for the title sections.
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start, // Align children to the start horizontally.
      children: [
        TechnoCard(
          title: 'FRONTEND',
          color: backgroundColorTitle,
          technologies: [
            {'icon': FontAwesomeIcons.react, 'color': Colors.blue, 'label': 'React'},
            {'icon': FontAwesomeIcons.squareJs, 'color': Colors.yellow, 'label': 'JS'},
            {'icon': FontAwesomeIcons.flutter, 'color': Colors.blue[900], 'label': 'Flutter'},
            {'icon': FontAwesomeIcons.html5, 'color': Colors.orange[900], 'label': 'HTML 5'},
            {'icon': FontAwesomeIcons.css3Alt, 'color': Colors.blue[900], 'label': 'CSS 3'},
          ],
        ),
        TechnoCard(
          title: 'BACKEND',
          color: backgroundColorTitle,
          technologies: [
            {'icon': FontAwesomeIcons.node, 'color': Colors.green, 'label': 'Node'},
            {'icon': FontAwesomeIcons.database, 'color': Colors.white, 'label': 'MongoDB'},
          ],
        ),
        TechnoCard(
          title: 'AUTRES',
          color: backgroundColorTitle,
          technologies: [
            {'icon': FontAwesomeIcons.github, 'color': Colors.black, 'label': 'GitHub'},
          ],
        ),
      ],
    );
  }
}
