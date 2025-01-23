import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../utils/global_colors.dart';
import '../utils/global_others.dart';

class ProjectsCard extends StatefulWidget {
  const ProjectsCard({super.key});

  @override
  State<ProjectsCard> createState() => _ProjectsCardState();
}

class _ProjectsCardState extends State<ProjectsCard> {
  OverlayEntry? _overlayEntry;
  final List<Map<String, dynamic>> projects = [
    {
      'name': 'Site : Mon Portfolio',
      'imageMobile': AppImages.projectMyPortfolioMobile,
      'imageWeb': AppImages.projectMyPortfolioWeb,
      'url': 'https://weather-frontend-sage.vercel.app/',
      'technologies': [
        {'icon': FontAwesomeIcons.flutter, 'color': GlobalColors.technoIconBlueOpt, 'label': 'Flutter'},
      ],
    },
    {
      'name': 'Site : Your Weather',
      'imageMobile': AppImages.projectYourWeatherMobile,
      'imageWeb': AppImages.projectYourWeatherWeb,
      'url': 'https://weather-frontend-sage.vercel.app/',
      'technologies': [
        {'icon': FontAwesomeIcons.squareJs, 'color': GlobalColors.technoIconYellow, 'label': 'JS'},
        {'icon': FontAwesomeIcons.html5, 'color': GlobalColors.technoIconOrangeOpt, 'label': 'HTML 5'},
        {'icon': FontAwesomeIcons.css3Alt, 'color': GlobalColors.technoIconBlueOpt, 'label': 'CSS 3'},
        {'icon': FontAwesomeIcons.database, 'color': GlobalColors.technoIconBlack, 'label': 'MongoDB'},
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Card(
      elevation: 10, // Adds a shadow effect to the card
      margin: EdgeInsets.only(bottom: 40), // Margin at the bottom of the card
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)), // Rounded corners for a nice look
      color: GlobalColors.tertiaryBackground, // Background color
      child: Padding(
        padding: EdgeInsets.all(10), // Padding inside the card
        child: CarouselSlider(
          options: CarouselOptions(
            height: screenWidth < 768 ? 605 : null, // Remove height constraint from carousel options
            autoPlay: true, // Automatically plays the carousel slides
            enlargeCenterPage: true, // Enlarges the center slide
          ),
          items: projects.map((project) {
            return Builder(
              builder: (BuildContext context) {
                return GestureDetector(
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
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min, // Allow column to take minimal space
                    children: [
                      SizedBox(
                        height: screenWidth < 768 ? 335 : 435, // Fixed height for project image 
                        child: Image.asset(
                          screenWidth < 768 ? project['imageMobile']! : project['imageWeb']!, // Display project image
                          fit: BoxFit.cover, // Ensure the image covers the entire area
                          width: double.infinity,
                        ),
                      ),
                      SizedBox(height: 10), // Space between the image and the text
                      Container(
                        padding: EdgeInsets.all(12), // Padding inside the container
                        decoration: BoxDecoration(
                          color: Color(0xFFA3B18A), // Background color
                          borderRadius: BorderRadius.circular(10), // Rounded corners
                        ),
                        child: Column(
                          children: [
                            Text(
                              project['name']!,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: GlobalColors.tertiaryBackground, // Text color for readability
                              ),
                            ),
                            Divider(
                              color: GlobalColors.tertiaryBackground,
                              thickness: 1, // Thickness of the divider
                              indent: 15, // Indentation from the start of the row
                              endIndent: 15, // Indentation from the end of the row
                            ),
                            OrientationBuilder(
                              builder: (context, orientation) {
                                return Wrap(
                                  alignment: WrapAlignment.center,
                                  spacing: screenWidth < 768 ? 20 : 45, // Space between tech icons
                                  children: project['technologies']!.map<Widget>((tech) {
                                    return Column(
                                      children: [
                                     MouseRegion(
                                          onEnter: kIsWeb ? (event) => _onHover(event, tech, true) : null,
                                          onExit: kIsWeb ? (event) => _onHover(event, tech, false) : null,
                                          child: TweenAnimationBuilder(
                                            duration: Duration(milliseconds: 300), // Animation duration
                                            tween: Tween<double>(begin: 1.2, end: tech['hover'] == true ? 1.8 : 1.2),
                                            builder: (context, double scale, child) {
                                              return Transform.scale(
                                                scale: scale,
                                                child: child,
                                              );
                                            },
                                            child: FaIcon(
                                              tech['icon'],
                                              color: tech['color'],
                                              size: 30, // Default size of the icon
                                            ),
                                          ),
                                        ),
                                        kIsWeb ? SizedBox.shrink() : Text(
                                          tech['label']!,
                                          style: TextStyle(
                                            fontSize: screenWidth < 768 ? 14 : 18, 
                                            color: GlobalColors.tertiaryBackground,
                                            fontWeight: FontWeight.w600,
                                            ),
                                        ),
                                      ],
                                    );
                                  }).toList(),
                                );
                              },
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

  void _onHover(PointerEvent event, Map<String, dynamic> tech, bool isHovering) {
    setState(() {
      tech['hover'] = isHovering;
      if (isHovering) {
        _showTechLabel(event, tech);
      } else {
        _hideTechLabel();
      }
    });
  }

  // Show technology label on hover
  void _showTechLabel(PointerEvent event, Map<String, dynamic> tech) {
    final overlay = Overlay.of(context);
    _overlayEntry = OverlayEntry(
      builder: (context) => Stack(
       children: [
        Positioned(
          left: event.position.dx,
          top: event.position.dy - 40,
          child: Material(
            color: Colors.transparent,
            child: AnimatedOpacity(
              opacity: 1.0,
              duration: Duration(milliseconds: 300), // Fade in duration
              child: Container(
                alignment: Alignment(0, 0),
                width: 200,
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: GlobalColors.tertiaryBackground,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  tech['label']!,
                  style: TextStyle(
                    fontSize: 14,
                    color: GlobalColors.textColor,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ),
        ),
       ]
      )
    );
      overlay.insert(_overlayEntry!);
  }

  // Hide technology label when hover ends
  void _hideTechLabel() {
    _overlayEntry?.remove();
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