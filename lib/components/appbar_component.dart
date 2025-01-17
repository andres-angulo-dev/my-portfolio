import 'package:flutter/material.dart';
import '../utils/global_colors.dart';
import '../components/animated_background_appbar.dart';
import 'animated_background_appbar_center.dart';


class AppBarComponent extends StatefulWidget {
  final VoidCallback scrollToAboutSection;

  const AppBarComponent({ super.key, required this.scrollToAboutSection });

  @override
  AppBarComponentState createState() => AppBarComponentState();
} 

class AppBarComponentState extends State<AppBarComponent> with TickerProviderStateMixin {
  late final AnimationController _controllerButton;
  late final Animation<double> _animationButton;
  late final AnimationController _fadeControllerButton;
  late final Animation<double> _fadeAnimationButton;
  late final AnimationController _textController;
  late final Animation<Offset> _offsetAnimation;
  late final Animation<Offset> _offsetAnimationBis;
  late final Animation<double> _fadeAnimation;
  late final AnimationController _controllerBackground;
  late final Animation<Offset> _slideAnimationBackground;
  late final Animation<double> _fadeAnimationBackground;
  late final List<Animation<double>> _fadeAnimations;
  late final List<AnimationController> _letterControllers;
  late final List<Animation<double>> _letterAnimations;

  final String name = 'BIENVENUE';

  @override
  void initState() {
    _initializeAnimations();
    _startAnimations();
    super.initState();
  }  

  void _initializeAnimations() {
    // Button animation setup
    _controllerButton = AnimationController(
      duration: Duration(milliseconds: 600),
      vsync: this,
    )..repeat(reverse: true);
    _animationButton = CurvedAnimation(
      parent: _controllerButton, 
      curve: Curves.easeInCubic,
    );

    // Fade animation for the button
    _fadeControllerButton = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );
    _fadeAnimationButton = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _fadeControllerButton, 
      curve: Curves.easeInOut,
    ));

    // Text animation setup
    _textController = AnimationController(
      duration: Duration(seconds: 4),
      vsync: this,
    ); 
    _offsetAnimation = Tween<Offset>(
      begin: Offset(0.0, -0.5),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _textController, 
      curve: Curves.easeInOut,
    ));
    _offsetAnimationBis = Tween<Offset>(
      begin: Offset(0.0, 0.5),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _textController, 
      curve: Curves.easeInOut,
    ));
    _fadeAnimation = Tween<double>(
      begin: 0.1,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _textController, 
      curve: Curves.easeInOut,
    ));

    // Letter animations for "BIENVENUE"
    _letterControllers = List.generate(name.length, (index) {
      return AnimationController(
        duration: Duration(milliseconds: 2000 + index * 100),
        vsync: this,
      );
    });
    _letterAnimations = _letterControllers.map((controller) {
      return Tween<double>(begin: 3.0, end: 1.0).animate(CurvedAnimation(
        parent: controller, 
        curve: Curves.easeInOut,
      ));
    }).toList();
    _fadeAnimations = _letterControllers.map((controller) {
      return Tween<double>(begin: 0.1, end: 1.0).animate(CurvedAnimation(
        parent: controller, 
        curve: Curves.easeInOut,
      ));
    }).toList();

    // Background animations
    _controllerBackground = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );
    _slideAnimationBackground = Tween<Offset>(
      begin: Offset(1.0, 0.0),
      end: Offset(0.0, 0.0),
    ).animate(CurvedAnimation(
      parent: _controllerBackground, 
      curve: Curves.easeInOut,
    ));
    _fadeAnimationBackground = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controllerBackground, 
      curve: Curves.easeInOut,
    ));
  }

  void _startAnimations() {
    _fadeControllerButton.forward();
    _textController.forward();
    for (var controller in _letterControllers) {
      controller.forward();
    }
    _controllerBackground.forward();
  }

  @override
  void dispose() {
    // Dispose of animation controllers to free up resources.
    _controllerButton.dispose();
    _fadeControllerButton.dispose();
    _textController.dispose();
    _controllerBackground.dispose();
    for (var controller in _letterControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  Offset _getOffsetForLetter(int index, int totalLetters) {
    // Calculate offset for letter animation based on its position.
    if (index == 0) {
      return Offset(-5.0, 0.0);
    } else if (index == totalLetters - 1) {
      return Offset(5.0, 0.0);
    } else {
      return index % 2 == 0 ? Offset(0.0, -5.0) : Offset(0.0, 5.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return SliverAppBar(
      pinned: true,
      backgroundColor: GlobalColors.primaryBackground,
      expandedHeight: screenSize.height,
      iconTheme: IconThemeData(
        color: GlobalColors.appBarTextColor,
        size: screenSize.width < 768 ? null : 30.0,
      ),
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          children: [
            AnimatedBackgroundAppBarCenter(),
            SlideTransition(
              position: _slideAnimationBackground,
              child: FadeTransition(
                opacity: _fadeAnimationBackground,
                child: AnimatedBackgroundAppbar(),
              ),
           ),
            _buildAnimatedText(),
            _buildAnimatedButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildAnimatedText() {
  final screenWidth = MediaQuery.of(context).size.width;
  
    return Stack(
      children: [
        Positioned(
          left: screenWidth < 768 ? 30 : screenWidth * 0.16,
          top: screenWidth < 768 ? MediaQuery.of(context).size.height / 2 - 82 : MediaQuery.of(context).size.height / 2 - 68,
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: SlideTransition(
              position: _offsetAnimationBis,
              child: Text(
                'Welcome',
                style: TextStyle(
                  color: GlobalColors.appBarTextColor,
                  fontSize: screenWidth < 768 ? 20.0 : 50.0,
                ),
              ),
            ),
          ),
        ),
        Positioned(
          left: screenWidth < 768 ? 30 : screenWidth * 0.16,
          top: screenWidth < 768 ? MediaQuery.of(context).size.height / 2 - 54 : MediaQuery.of(context).size.height / 2 - 21,
          child: Row(
            children: List.generate(name.length, (index) {
              return FadeTransition(
                opacity: _fadeAnimations[index],
                child: SlideTransition(
                  position: Tween<Offset>(
                    begin: _getOffsetForLetter(index, name.length),
                    end: Offset.zero, 
                  ).animate(_letterAnimations[index]),
                  child: Text(
                    name[index],
                    style: TextStyle(
                      color: GlobalColors.appBarTextColor,
                      fontSize: screenWidth < 768 ? 24.0 : 58.0,
                    ),
                  ),
                ),
              ); 
            }),
          ),
        ),
        Positioned(
          left: screenWidth < 768 ? 30 : screenWidth * 0.16,
          top: screenWidth < 768 ? MediaQuery.of(context).size.height / 2 - 22 : MediaQuery.of(context).size.height / 2 + 38,
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: SlideTransition(
              position: _offsetAnimation,
              child: Text(
                'Bienvenido',
                style: TextStyle(
                  color: GlobalColors.appBarTextColor,
                  fontSize: screenWidth < 768 ? 20.0 : 50.0,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
  
  Widget _buildAnimatedButton() {
    double screenWidth = MediaQuery.of(context).size.width;

    return 
      Stack(
        children: [
    Positioned(
      bottom: 90,
      left: screenWidth / 2 - 100,
      child: 
          AnimatedBuilder(
            animation: _animationButton, 
            builder: (context, child) {
              return Transform.translate(
                offset: Offset(0, _animationButton.value * 20),
                child: AnimatedBuilder(
                  animation: _fadeAnimationButton, 
                  builder: (context, child) {
                    return Opacity(
                      opacity: _fadeAnimationButton.value,
                      child: SizedBox(
                        width: screenWidth < 768 ? 200 : 250,
                        height: screenWidth < 768 ? 25 : 31.25,
                        child: MaterialButton(
                          color: GlobalColors.appBarButtonBackground,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          onPressed: widget.scrollToAboutSection,
                          child: Icon(
                            Icons.keyboard_arrow_down, 
                            size: 32,
                            color: GlobalColors.appBarButtonArrow,
                          ),
                        ),
                      ),
                    ); 
                  },
                ),
              );
            }, 
          ),
    ),
        ],
      );          
  }
}
