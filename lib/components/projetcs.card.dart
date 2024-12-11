import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:url_launcher/url_launcher.dart';

class ProjectsCard extends StatelessWidget {
  ProjectsCard({ super.key });

  final List<Map<String, String>> projects = [
    { 
      'name': 'App : Mon Portfolio',
      'image': 'assets/my_portfolio.png', 
      'url': 'https://weather-frontend-sage.vercel.app/',
    },
    {
      'name': 'Site : Your Wather',
      'image': 'assets/your_weather.png',
      'url': 'https://weather-frontend-sage.vercel.app/',
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10, // Adds a shadow effect to the card.
      margin: EdgeInsets.only(bottom: 40), // Margin at the bottom of the card.
      shape: LinearBorder(side: BorderSide.none), // Shape of the card with no side border.
      color: Color.fromARGB(150, 255, 255, 255), // Semi-transparent white background color.
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
                          color: Colors.white, // Text color for readability.
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          }).toList(),
        ),
      ),
    );
  }
}
