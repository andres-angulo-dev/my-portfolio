import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'dart:async';

class TechnoCard extends StatefulWidget {
  final String title;
  final Color color;
  final List<Map<String, dynamic>> technologies;

  const TechnoCard({ super.key, required this.title, required this.color, required this.technologies });

  @override
  TechnoCardState createState() => TechnoCardState();
}

class TechnoCardState extends State<TechnoCard> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation; 
  late final CurvedAnimation curvedAnimation = CurvedAnimation(
    parent: _controller, 
    curve: Curves.easeInOut,
  );
  bool _isAnimating = false; // Boolean to track if the animation is running
  late final Timer? _startDelayTimer; // Timer for the delay before starting the animation

  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(seconds: 5), // Duration for the animation
      vsync: this,
    );
    
    // Define the animation sequence with easing
    _animation = TweenSequence([
      TweenSequenceItem(tween: Tween(begin: 40.0, end: 50.0), weight: 50),
      TweenSequenceItem(tween: Tween(begin: 50.0, end: 30.0), weight: 50),
      TweenSequenceItem(tween: Tween(begin: 30.0, end: 40.0), weight: 50),
    ]).animate(curvedAnimation);

    super.initState();
  }
  
  // Function to handle the animation cycle with delays
  Future<void> _startAnimationCycle() async { 
    while (_isAnimating) { 
      try {
        await _controller.forward(from: 0.0); // Start the animation
        await Future.delayed(const Duration(seconds: 5)); // Pause before the next cycle
      } catch (error) {
        debugPrint("Error during animation cycle: $error");
      }
    } 
  }

  // Function to start the animation after a delay
  void _startAnimation() { 
    if (!_isAnimating) { 
      setState(() { 
        _isAnimating = true; 
      }); 
      _startDelayTimer = Timer(const Duration(seconds: 1), () {
        _startAnimationCycle(); 
      });
    }
  }

  // Function to stop the animation
  void _stopAnimation() { 
    _startDelayTimer?.cancel();
    setState(() { 
      _isAnimating = false; 
    }); 
  }

  @override
  void dispose() {
    _startDelayTimer?.cancel();
    _isAnimating = false;
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10, // Adds a shadow effect to the card.
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12), // Rounded corners for the card.
      ),
      color: widget.color, // Background color of the card.
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
                children: widget.technologies.map((techno) {
                  return Column(
                    children: [
                      VisibilityDetector(
                        key: Key(techno['label']), 
                        onVisibilityChanged: (visibilityInfo) {
                          if (visibilityInfo.visibleFraction > 0.1) {
                            _startAnimation();
                          } else {
                            _stopAnimation();
                          }
                        },
                        child: AnimatedBuilder(
                          animation: _animation, 
                          builder: (context, child) {
                            return SizedBox(
                              width: 50,
                              height: 50,
                              child: Center(
                                child: FaIcon(techno['icon'], size: _animation.value, color: techno['color']), // Display the technology icon.
                              ),
                            );
                          }
                        ),
                      ),
                      const SizedBox(height: 6), // Space between the icon and the text.
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
              widget.title,
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
