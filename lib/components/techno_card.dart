// With fade animation
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../utils/global_colors.dart';
import '../utils/global_others.dart';

class TechnoCard extends StatefulWidget {
  final String title;
  final Color color;
  final List<Map<String, dynamic>> technologies;
  final bool isLastCard;

  const TechnoCard({ super.key, required this.title, required this.color, required this.technologies, this.isLastCard = false});

  @override
  TechnoCardState createState() => TechnoCardState();
}

class TechnoCardState extends State<TechnoCard> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation; 
  bool _hasAnimated = false; // Boolean to track if the animation has already run

  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500), // Duration for the fade animation
      vsync: this,
    );

    // Define the fade animation
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: widget.isLastCard 
        ? const EdgeInsets.only(bottom: 40.0)
        : EdgeInsets.zero,
      child: Card(
        elevation: 10, // Adds a shadow effect to the card.
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12), // Rounded corners for the card.
        ),
        color: GlobalColors.technoCardBorder, // Background color of the card.
        margin: const EdgeInsets.fromLTRB(5, 5, 5, 25), // Margin around the card.
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // Align children to the start horizontally.
          children: [
            Container(
              decoration: BoxDecoration(
                color: GlobalColors.cardBackground, // Background color of the container.
                border: Border.all(color: GlobalColors.technoCardBorder, width: 1), // Border color and width.
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
                  children: widget.technologies.map((techno) {
                    return Column(
                      children: [
                        VisibilityDetector(
                          key: Key(techno['label']), 
                          onVisibilityChanged: (visibilityInfo) {
                            if (visibilityInfo.visibleFraction > 0.1 && !_hasAnimated) {
                              _controller.forward(); // Start the animation once
                              setState(() {
                                _hasAnimated = true; // Mark the animation as done
                              });
                            }
                          },
                          child: Column(
                            children: [
                              FadeTransition(
                                opacity: _animation, 
                                child: SizedBox(
                                  width: 50,
                                  height: 50,
                                  child: Center( // Display the technology icon.
                                    child: techno['icon'] != null
                                    ? FaIcon(techno['icon'], size: 40.0, color: techno['color'])
                                    : Image.asset(techno['image'], height: 40, width: 40), 
                                  ),
                                ),
                              ),
                              const SizedBox(height: 6), // Space between the icon and the text.
                              FadeTransition(
                                opacity: _animation,
                                child: Text(
                                  techno['label'],
                                  style: TextStyle(color: GlobalColors.textColor),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: GlobalColors.technoCardBorder, width: 3), // Border color and width for the bottom container.
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(12),
                  bottomRight: Radius.circular(12),
                ), // Rounded corners for the bottom of the container.
              ),
              width: double.infinity, // Full width container.
              height: 30, // Fixed height for the title container.
              alignment: Alignment.center, // Center align the text.
              child: FadeTransition(
                opacity: _animation,
                child: Text(
                  widget.title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: GlobalColors.technoTitleColor, //title container
                  ),
                ),
              ),
            ),
          ],
        ),
      ).ifWeb(
        kIsWeb ? 475.0 : double.infinity,
      ),
    );
  }
}

class TechnologiesCard extends StatelessWidget {
  const TechnologiesCard({super.key});

  @override
  Widget build(BuildContext context) {
    final Color backgroundColorTitle = Colors.red; // Background color for the title sections.
    return kIsWeb  
      ? Wrap(
        spacing: 10.0,
        runSpacing: 10.0,
        alignment: WrapAlignment.center,
        children: [
          TechnoCard(
            title: 'FRONTEND',
            color: backgroundColorTitle,
            technologies: [
              {'icon': FontAwesomeIcons.react, 'color': GlobalColors.technoIconBlue, 'label': 'React'},
              {'icon': FontAwesomeIcons.squareJs, 'color': GlobalColors.technoIconYellow, 'label': 'JS'},
              {'icon': FontAwesomeIcons.flutter, 'color': GlobalColors.technoIconBlueOpt, 'label': 'Flutter'},
              {'icon': FontAwesomeIcons.html5, 'color': GlobalColors.technoIconOrangeOpt, 'label': 'HTML 5'},
              {'icon': FontAwesomeIcons.css3Alt, 'color': GlobalColors.technoIconBlueOpt, 'label': 'CSS 3'},
            ], 
          ),
          TechnoCard(
            title: 'BACKEND',
            color: backgroundColorTitle,
            technologies: [
              {'icon': FontAwesomeIcons.node, 'color': GlobalColors.technoIconGreen, 'label': 'Node'},
              {'icon': FontAwesomeIcons.database, 'color': GlobalColors.technoIconBlack, 'label': 'MongoDB'},
            ],
          ),
          TechnoCard(
            title: 'AUTRES',
            color: backgroundColorTitle,
            technologies: [
              {'icon': FontAwesomeIcons.github, 'color': GlobalColors.technoIconBlack, 'label': 'GitHub'},
            ],
          isLastCard: true,
          ),
        ],
      )
      : Column(
        crossAxisAlignment: CrossAxisAlignment.start, // Align children to the start horizontally.
        children: [
          TechnoCard(
            title: 'FRONTEND',
            color: backgroundColorTitle,
            technologies: [
              {'icon': FontAwesomeIcons.react, 'color': GlobalColors.technoIconBlue, 'label': 'React'},
              {'icon': FontAwesomeIcons.squareJs, 'color': GlobalColors.technoIconYellow, 'label': 'JS'},
              {'icon': FontAwesomeIcons.flutter, 'color': GlobalColors.technoIconBlueOpt, 'label': 'Flutter'},
              {'icon': FontAwesomeIcons.html5, 'color': GlobalColors.technoIconOrangeOpt, 'label': 'HTML 5'},
              {'icon': FontAwesomeIcons.css3Alt, 'color': GlobalColors.technoIconBlueOpt, 'label': 'CSS 3'},
            ],
          ),
          TechnoCard(
            title: 'BACKEND',
            color: backgroundColorTitle,
            technologies: [
              {'icon': FontAwesomeIcons.node, 'color': GlobalColors.technoIconGreen, 'label': 'Node'},
              {'icon': FontAwesomeIcons.database, 'color': GlobalColors.technoIconBlack, 'label': 'MongoDB'},
            ],
          ),
          TechnoCard(
            title: 'AUTRES',
            color: backgroundColorTitle,
            technologies: [
              {'icon': FontAwesomeIcons.github, 'color': GlobalColors.technoIconBlack, 'label': 'GitHub'},
              {'icon': null, 'color': null, 'label': 'Firebase', 'image': AppImages.technoIconFirebase },
              {'icon': null, 'color': null, 'label': 'Vercel', 'image': AppImages.technoIconVercel },
              {'icon': null, 'color': null, 'label': 'Expo Go', 'image': AppImages.technoIconExpoGo },
            ],
            isLastCard: true,
          ),
        ],
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


//// With enlargement/contraction animation
// import 'package:flutter/material.dart';
// import 'package:flutter/foundation.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:visibility_detector/visibility_detector.dart';
// import 'dart:async';
// import '../utils/global_colors.dart';

// class TechnoCard extends StatefulWidget {
//   final String title;
//   final Color color;
//   final List<Map<String, dynamic>> technologies;

//   const TechnoCard({ super.key, required this.title, required this.color, required this.technologies });

//   @override
//   TechnoCardState createState() => TechnoCardState();
// }

// class TechnoCardState extends State<TechnoCard> with SingleTickerProviderStateMixin {
//   late final AnimationController _controller;
//   late final Animation<double> _animation; 
//   late final CurvedAnimation curvedAnimation = CurvedAnimation(
//     parent: _controller, 
//     curve: Curves.easeInOut,
//   );
//   bool _isAnimating = false; // Boolean to track if the animation is running
//   late final Timer? _startDelayTimer; // Timer for the delay before starting the animation

//   @override
//   void initState() {
//     _controller = AnimationController(
//       duration: const Duration(seconds: 5), // Duration for the animation
//       vsync: this,
//     );
    
//     // Define the animation sequence with easing
//     _animation = TweenSequence([
//       TweenSequenceItem(tween: Tween(begin: 40.0, end: 50.0), weight: 50),
//       TweenSequenceItem(tween: Tween(begin: 50.0, end: 30.0), weight: 50),
//       TweenSequenceItem(tween: Tween(begin: 30.0, end: 40.0), weight: 50),
//     ]).animate(curvedAnimation);

//     super.initState();
//   }
  
//   // Function to handle the animation cycle with delays
//   Future<void> _startAnimationCycle() async { 
//     while (_isAnimating) { 
//       try {
//         await _controller.forward(from: 0.0); // Start the animation
//         await Future.delayed(const Duration(seconds: 5)); // Pause before the next cycle
//       } catch (error) {
//         debugPrint("Error during animation cycle: $error");
//       }
//     } 
//   }

//   // Function to start the animation after a delay
//   void _startAnimation() { 
//     if (!_isAnimating) { 
//       setState(() { 
//         _isAnimating = true; 
//       }); 
//       _startDelayTimer = Timer(const Duration(seconds: 1), () {
//         _startAnimationCycle(); 
//       });
//     }
//   }

//   // Function to stop the animation
//   void _stopAnimation() { 
//     _startDelayTimer?.cancel();
//     setState(() { 
//       _isAnimating = false; 
//     }); 
//   }

//   @override
//   void dispose() {
//     _startDelayTimer?.cancel();
//     _isAnimating = false;
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       elevation: 10, // Adds a shadow effect to the card.
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(12), // Rounded corners for the card.
//       ),
//       color: GlobalColors.technoCardBorder, // Background color of the card.
//       margin: const EdgeInsets.fromLTRB(5, 5, 5, 25), // Margin around the card.
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start, // Align children to the start horizontally.
//         children: [
//           Container(
//             decoration: BoxDecoration(
//               color: GlobalColors.cardBackground, // Background color of the container.
//               border: Border.all(color: GlobalColors.technoCardBorder, width: 1), // Border color and width.
//               borderRadius: const BorderRadius.only(
//                 topLeft: Radius.circular(12),
//                 topRight: Radius.circular(12),
//               ), // Rounded corners for the top of the container.
//             ),
//             padding: const EdgeInsets.all(20.0), // Padding inside the container.
//             child: Center(
//               child: Wrap(
//                 alignment: WrapAlignment.center, // Center align the wrapped children.
//                 spacing: 20.0, // Space between the children horizontally.
//                 runSpacing: 20.0, // Space between the children vertically.
//                 children: widget.technologies.map((techno) {
//                   return Column(
//                     children: [
//                       VisibilityDetector(
//                         key: Key(techno['label']), 
//                         onVisibilityChanged: (visibilityInfo) {
//                           if (visibilityInfo.visibleFraction > 0.1) {
//                             _startAnimation();
//                           } else {
//                             _stopAnimation();
//                           }
//                         },
//                         child: AnimatedBuilder(
//                           animation: _animation, 
//                           builder: (context, child) {
//                             return SizedBox(
//                               width: 50,
//                               height: 50,
//                               child: Center(
//                                 child: FaIcon(techno['icon'], size: _animation.value, color: techno['color']), // Display the technology icon.
//                               ),
//                             );
//                           }
//                         ),
//                       ),
//                       const SizedBox(height: 6), // Space between the icon and the text.
//                       Text(
//                         techno['label'],
//                         style: TextStyle(color: GlobalColors.textColor),
//                       ),
//                     ],
//                   );
//                 }).toList(),
//               ),
//             ),
//           ),
//           Container(
//             decoration: BoxDecoration(
//               border: Border.all(color: GlobalColors.technoCardBorder, width: 3), // Border color and width for the bottom container.
//               borderRadius: BorderRadius.only(
//                 bottomLeft: Radius.circular(12),
//                 bottomRight: Radius.circular(12),
//               ), // Rounded corners for the bottom of the container.
//             ),
//             width: double.infinity, // Full width container.
//             height: 30, // Fixed height for the title container.
//             alignment: Alignment.center, // Center align the text.
//             child: Text(
//               widget.title,
//               style: const TextStyle(
//                 fontSize: 14,
//                 fontWeight: FontWeight.bold,
//                 color: GlobalColors.technoTitleColor, //title container
//               ),
//             ),
//           ),
//         ],
//       ),
//     ).ifWeb(
//       kIsWeb ? 475.0 : double.infinity,
//     );
//   }
// }

// class TechnologiesCard extends StatelessWidget {
//   const TechnologiesCard({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final Color backgroundColorTitle = Colors.red; // Background color for the title sections.
//     return kIsWeb  
//       ? Wrap(
//         spacing: 10.0,
//         runSpacing: 10.0,
//         alignment: WrapAlignment.center,
//         children: [
//           TechnoCard(
//             title: 'FRONTEND',
//             color: backgroundColorTitle,
//             technologies: [
//               {'icon': FontAwesomeIcons.react, 'color': GlobalColors.technoIconBlue, 'label': 'React'},
//               {'icon': FontAwesomeIcons.squareJs, 'color': GlobalColors.technoIconYellow, 'label': 'JS'},
//               {'icon': FontAwesomeIcons.flutter, 'color': GlobalColors.technoIconBlueOpt, 'label': 'Flutter'},
//               {'icon': FontAwesomeIcons.html5, 'color': GlobalColors.technoIconOrangeOpt, 'label': 'HTML 5'},
//               {'icon': FontAwesomeIcons.css3Alt, 'color': GlobalColors.technoIconBlueOpt, 'label': 'CSS 3'},
//             ],
//           ),
//           TechnoCard(
//             title: 'BACKEND',
//             color: backgroundColorTitle,
//             technologies: [
//               {'icon': FontAwesomeIcons.node, 'color': GlobalColors.technoIconGreen, 'label': 'Node'},
//               {'icon': FontAwesomeIcons.database, 'color': GlobalColors.technoIconBlack, 'label': 'MongoDB'},
//             ],
//           ),
//           TechnoCard(
//             title: 'AUTRES',
//             color: backgroundColorTitle,
//             technologies: [
//               {'icon': FontAwesomeIcons.github, 'color': GlobalColors.technoIconBlack, 'label': 'GitHub'},
//             ],
//           ),
//         ],
//       )
//       : Column(
//         crossAxisAlignment: CrossAxisAlignment.start, // Align children to the start horizontally.
//         children: [
//           TechnoCard(
//             title: 'FRONTEND',
//             color: backgroundColorTitle,
//             technologies: [
//               {'icon': FontAwesomeIcons.react, 'color': GlobalColors.technoIconBlue, 'label': 'React'},
//               {'icon': FontAwesomeIcons.squareJs, 'color': GlobalColors.technoIconYellow, 'label': 'JS'},
//               {'icon': FontAwesomeIcons.flutter, 'color': GlobalColors.technoIconBlueOpt, 'label': 'Flutter'},
//               {'icon': FontAwesomeIcons.html5, 'color': GlobalColors.technoIconOrangeOpt, 'label': 'HTML 5'},
//               {'icon': FontAwesomeIcons.css3Alt, 'color': GlobalColors.technoIconBlueOpt, 'label': 'CSS 3'},
//             ],
//           ),
//           TechnoCard(
//             title: 'BACKEND',
//             color: backgroundColorTitle,
//             technologies: [
//               {'icon': FontAwesomeIcons.node, 'color': GlobalColors.technoIconGreen, 'label': 'Node'},
//               {'icon': FontAwesomeIcons.database, 'color': GlobalColors.technoIconBlack, 'label': 'MongoDB'},
//             ],
//           ),
//           TechnoCard(
//             title: 'AUTRES',
//             color: backgroundColorTitle,
//             technologies: [
//               {'icon': FontAwesomeIcons.github, 'color': GlobalColors.technoIconBlack, 'label': 'GitHub'},
//             ],
//           ),
//         ],
//       );
//   }
// }

// extension on Widget {
//   Widget ifWeb(double width) {
//     return SizedBox(
//       width: width,
//       child: this,
//     );
//   }
// }

