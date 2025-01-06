import 'package:flutter/material.dart';
import '../utils/global_colors.dart';
import '../utils/global_others.dart';

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

  final String name = 'WELCOME';

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

    // Letter animations for "WELCOME"
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

    String backgroundImage = screenSize.width < 780 ? AppImages.appbarBackgroundMobile : AppImages.appbarBackgroundWeb;

    return SliverAppBar(
      pinned: true,
      backgroundColor: GlobalColors.primaryBackground,
      expandedHeight: MediaQuery.of(context).size.height,
      iconTheme: IconThemeData(color: GlobalColors.appBarTextColor),
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          children: [
            SlideTransition(
              position: _slideAnimationBackground,
              child: FadeTransition(
                opacity: _fadeAnimationBackground,
                child: Image.asset(
                  backgroundImage,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                ),
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
          left: screenWidth < 768 ? 30 : screenWidth * 0.20,
          top: MediaQuery.of(context).size.height / 2 - 52,
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: SlideTransition(
              position: _offsetAnimationBis,
              child: Text(
                'Bienvenue',
                style: TextStyle(
                  color: GlobalColors.appBarTextColor,
                  fontSize: 20.0,
                ),
              ),
            ),
          ),
        ),
        Positioned(
          left: screenWidth < 768 ? 30 : screenWidth * 0.20,
          top: MediaQuery.of(context).size.height / 2 - 22,
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
                      fontSize: 24,
                    ),
                  ),
                ),
              ); 
            }),
          ),
        ),
        Positioned(
          left: screenWidth < 768 ? 30 : screenWidth * 0.20,
          top: MediaQuery.of(context).size.height / 2 + 12,
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: SlideTransition(
              position: _offsetAnimation,
              child: Text(
                'Bienvenido',
                style: TextStyle(
                  color: GlobalColors.appBarTextColor,
                  fontSize: 20.0,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
  
  Widget _buildAnimatedButton() {
    return Positioned(
      bottom: 90,
      left: MediaQuery.of(context).size.width / 2 - 100,
      child: Stack(
        children: [
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
                        width: 200,
                        height: 25,
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
        ],
      ),           
    );
  }
}
