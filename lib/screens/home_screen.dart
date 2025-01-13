import 'package:andres_angulo_portfolio/components/skills_card.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../components/appbar_component.dart';
import '../components/drawer_component.dart';
import '../components/section_home_page.dart';
import '../components/about_me_card.dart';
import '../components/projects_card.dart';
import '../components/techno_card.dart';
import '../components/fab_circular_menu.dart';
import '../components/footer.dart';
import '../components/animated_background_projects_card.dart';
import '../components/animated_background_home_screen.dart';
import '../utils/global_colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _aboutKey = GlobalKey();
  final GlobalKey _projectsKey = GlobalKey();
  final GlobalKey _skillsKey = GlobalKey();
  final GlobalKey _technoKey = GlobalKey();

  // Variable to control the opacity of the animation
  double _animationOpacity = 0.0;
  bool _hasAnimated = false;

  // Variable to control the transition of the animation
  late final AnimationController _controller;
  late final Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _controller = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );

    _slideAnimation = Tween<Offset>(
      begin: Offset(0.3, 0.10), // Starts from outside the right side of the screen
      end: Offset(-1.2, 0.10), // Final position centered horizontally
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut, // Smooth transition curve
    ));

    // Start the controller and opacity animation
    WidgetsBinding.instance.addPostFrameCallback((_) { 
      setState(() { 
        _animationOpacity; 
      });
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _controller.dispose();
    super.dispose();
  }

  // Function to detect scrolling
  void _onScroll() {
    final scrollPosition = _scrollController.position.pixels;
    if (scrollPosition > 850 && !_hasAnimated) { // Adjust this value according to your needs
      setState(() {
        _animationOpacity = 1.0; // Make the animation visible
        _controller.forward(); // Start the transition animation
        _hasAnimated = true; // Mark the animation as triggered
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerComponent(
        scrollToSection: _scrollToSection,
        aboutKey: _aboutKey,
        projectsKey: _projectsKey,
        skillsKey: _skillsKey,
        technoKey: _technoKey,
      ),
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: GlobalColors.secondaryBackground,
            ),
          ),
          _buildBody(context),
        ],
      ),
      floatingActionButton: FabCircularMenu(),
    );
  }

  void _scrollToSection(GlobalKey key) {
    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(context, duration: Duration(milliseconds: 500), curve: Curves.linear);
    }
  }

  Widget _buildBody(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return CustomScrollView(
      controller: _scrollController,
      slivers: <Widget>[
        AppBarComponent(scrollToAboutSection: () => _scrollToSection(_aboutKey)),
        SliverToBoxAdapter(
          child: Stack(
            children: [
              // Widget to display animation for small screens
              screenWidth < 768 ?
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Positioned(
                    child: AnimatedOpacity(
                      opacity: _animationOpacity,
                      duration: Duration(seconds: 5),
                      child: AnimatedBackgroundHomeScreen(),
                    ),
                  ), 
                  Positioned(
                    child: AnimatedOpacity(
                      opacity: _animationOpacity,
                      duration: Duration(seconds:5),
                      child: AnimatedBackgroundHomeScreen(),
                    ),
                  ), 
                  Positioned(
                    child: AnimatedOpacity(
                      opacity: _animationOpacity,
                      duration: Duration(seconds: 5),
                      child: AnimatedBackgroundHomeScreen(),
                    ),
                  ), 
                ],
              )
              :
              // Widget to display animation for larger screens
              Positioned(
                top: -280,
                child: AnimatedOpacity(
                  opacity: _animationOpacity,
                  duration: Duration(seconds: 1),
                  child: AnimatedBackgroundHomeScreen(),
                ),
              ),
              Column(
                children: <Widget>[
                  SectionHomePage(
                    sectionKey: _aboutKey,
                    title: 'À propos de moi',
                    child: AboutMeCard(),
                  ),
                  kIsWeb ?
                  Stack(
                    children: [
                      Container(
                        alignment: Alignment(0, 0), // Center alignment
                        child: SlideTransition(
                          position: _slideAnimation,
                          child: AnimatedOpacity(
                            opacity: _animationOpacity,
                            duration: Duration(seconds: 2),
                            child: AnimatedBackgroundProjectsCard(),
                          ),
                        )
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                          margin: EdgeInsets.only(top: 100),
                          width: 900,
                          height: 430,
                          decoration: BoxDecoration(
                            color: GlobalColors.primaryBackground,
                          ),
                        ),
                      ),
                      SectionHomePage(
                        sectionKey: _projectsKey,
                        title: 'Mes projets',
                        child: AnimatedOpacity(
                          opacity: _animationOpacity,
                          duration: Duration(seconds: 2),
                          child: SizedBox(
                            width: 900,
                            height: 600,
                            child: ProjectsCard(),
                          ),
                        ),
                      ),
                    ]
                  )
                  : 
                  SectionHomePage(
                    sectionKey: _projectsKey,
                    title: 'Mes projets',
                    child: AnimatedOpacity(
                      opacity: _animationOpacity, 
                      duration: Duration(seconds: 2),
                      child: SizedBox(
                        height: 582,
                        child: ProjectsCard(),
                      ),
                    ),
                  ),
                  SectionHomePage(
                    sectionKey: _skillsKey,
                    title: 'Compétences',
                    child: SkillsCard(),
                  ),
                  SectionHomePage(
                    sectionKey: _technoKey,
                    title: 'Technologies',
                    child: TechnologiesCard(),
                  ),
                  Footer(),
                ],
              ),
            ],
          )
        ),
      ],
    );
  }
}



