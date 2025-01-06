import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../utils/global_colors.dart';
import '../utils/global_others.dart';

class ProjectsCard extends StatelessWidget {
  ProjectsCard({ super.key });

  final List<Map<String, String>> projects = [
    { 
      'name': 'App : Mon Portfolio',
      'image': AppImages.myPortfolioProject, 
      'url': 'https://weather-frontend-sage.vercel.app/',
    },
    {
      'name': 'Site : Your Wather',
      'image': AppImages.yourWeatherProject,
      'url': 'https://weather-frontend-sage.vercel.app/',
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10, // Adds a shadow effect to the card.
      margin: EdgeInsets.only(bottom: 40), // Margin at the bottom of the card.
      shape: LinearBorder(side: BorderSide.none), // Shape of the card with no side border.
      color: GlobalColors.tertiaryBackground.withOpacity(0.4), // Semi-transparent white background color.
      // color: Color(0xFFA3B18A).withOpacity(0.65), // Semi-transparent white background color.
      child: Padding(
        padding: EdgeInsets.all(10), // Padding inside the card.
        child: CarouselSlider(
          options: CarouselOptions(
            height: 400.0, // Height of the carousel.
            autoPlay: true, // Automatically plays the carousel slides.
            enlargeCenterPage: true, // Enlarges the center slide.
          ),
          items: projects.map((project) { 
            return Builder(
              builder: (BuildContext context) {
                return GestureDetector(
                  // On tapping the card, open the project URL.
                  onTap: () async {
                    try {
                      if (!await launchUrl(Uri.parse(project['url']!))) {
                        throw Exception('Could not launch ${project['url']}');
                      }
                    } catch (error) {
                      throw 'Could not launch ${project['url']}, error: $error'; // Handle URL launch error.
                    }
                  },
                  child: Column(
                    children: [
                      Expanded(
                        child: Image.asset(
                          project['image']!.toString(), // Display project image.
                          fit: BoxFit.cover, // Ensure the image covers the entire area.
                        ),
                      ),
                      SizedBox(height: 10), // Space between the image and the text.
                      Text(
                        project['name']!,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: GlobalColors.projectsTitleColor, // Text color for readability.
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

extension on Widget {
  Widget ifWeb(double width) {
    return SizedBox(
      width: width,
      child: this,
    );
  }
}