import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../utils/global_colors.dart';
import '../utils/global_others.dart';

class ProjectsCard extends StatelessWidget {
  ProjectsCard({super.key});

  final List<Map<String, dynamic>> projects = [
    {
      'name': 'App : Mon Portfolio',
      'image': AppImages.myPortfolioProject,
      'url': 'https://weather-frontend-sage.vercel.app/',
      'technologies': [
        {'icon': FontAwesomeIcons.flutter, 'color': GlobalColors.technoIconBlueOpt, 'label': 'Flutter'},
      ],
    },
    {
      'name': 'Site : Your Weather',
      'image': AppImages.yourWeatherProject,
      'url': 'https://weather-frontend-sage.vercel.app/',
      'technologies': [
        {'icon': FontAwesomeIcons.squareJs, 'color': GlobalColors.technoIconYellow, 'label': 'JS'},
        {'icon': FontAwesomeIcons.html5, 'color': GlobalColors.technoIconOrangeOpt, 'label': 'HTML 5'},
        {'icon': FontAwesomeIcons.css3Alt, 'color': GlobalColors.technoIconBlueOpt, 'label': 'CSS 3'},
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10, // Adds a shadow effect to the card
      margin: EdgeInsets.only(bottom: 40), // Margin at the bottom of the card
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)), // Rounded corners for a nice look
      color: GlobalColors.tertiaryBackground, // Background color
      child: Padding(
        padding: EdgeInsets.all(0), // Padding inside the card
        child: CarouselSlider(
          options: CarouselOptions(
            height: 400.0, // Height of the carousel
            autoPlay: true, // Automatically plays the carousel slides
            enlargeCenterPage: true, // Enlarges the center slide
          ),
          items: projects.map((project) {
            return Builder(
              builder: (BuildContext context) {
                return GestureDetector(
                  // On tapping the card, open the project URL
                  onTap: () async {
                    try {
                      if (!await launchUrl(Uri.parse(project['url']!))) {
                        throw Exception('Could not launch ${project['url']}');
                      }
                    } catch (error) {
                      throw 'Could not launch ${project['url']}, error: $error';
                    }
                  },
                  child: Column(
                    children: [
                      Expanded(
                        child: Image.asset(
                          project['image']!.toString(), // Display project image
                          fit: BoxFit.cover, // Ensure the image covers the entire area
                        ),
                      ),
                      SizedBox(height: 10), // Space between the image and the text
                      Container(
                        padding: EdgeInsets.all(10), // Padding inside the container
                        width: 500,
                        decoration: BoxDecoration(
                          color: Color(0xFFA3B18A).withOpacity(0.8), // Background color with opacity
                          borderRadius: BorderRadius.circular(10), // Rounded corners for a nicer look
                        ),
                        child: Column(
                          children: [
                            Text(
                              project['name']!,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: GlobalColors.tertiaryBackground, // Text color for readability
                              ),
                            ),
                            Divider( 
                              color: Colors.white, 
                              thickness: 1, // Thickness of the divider 
                              indent: 15, // Indentation from the start of the row 
                              endIndent: 15, // Indentation from the end of the row 
                            ),
                            // SizedBox(height: 10), // Space between project name and icons
                            Wrap(
                              alignment: WrapAlignment.center,
                              spacing: 10, // Space between tech icons
                              children: project['technologies']!.map<Widget>((tech) {
                                return Column(
                                  children: [
                                    FaIcon(
                                      tech['icon'],
                                      color: tech['color'],
                                      size: 30, // Icon size
                                    ),
                                    Text(
                                      tech['label']!,
                                      style: TextStyle(fontSize: 14, color: GlobalColors.tertiaryBackground), // Text style for tech label
                                    ),
                                  ],
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          }).toList(),
        ),
      ).ifWeb(
        kIsWeb ? 750.0 : double.infinity,
      ),
    );
  }
}

// Extension to adapt widget width on web
extension on Widget {
  Widget ifWeb(double width) {
    return SizedBox(
      width: width,
      child: this,
    );
  }
}
