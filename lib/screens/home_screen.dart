// With column only 
import 'package:flutter/material.dart';

import '../components/appbar_component.dart';
import '../components/drawer_component.dart';
import '../components/section_home_page.dart';
import '../components/about_me_card.dart';
import '../components/projects_card.dart';
import '../components/skills_card.dart';
import '../components/techno_card.dart';
import '../components/fab_circular_menu.dart';
import '../components/footer.dart'; // Importez le Footer ici
import '../utils/global_colors.dart';

class HomeScreen extends StatelessWidget {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _aboutKey = GlobalKey();
  final GlobalKey _projectsKey = GlobalKey();
  final GlobalKey _skillsKey = GlobalKey();
  final GlobalKey _technoKey = GlobalKey();

  HomeScreen({ super.key });

  void _scrollToSection(GlobalKey key) {
    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(context, duration: Duration(milliseconds: 500), curve: Curves.linear);
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
      body: Container(
        decoration: BoxDecoration(
          color: GlobalColors.secondaryBackground,
        ),
        child: _buildBody(context),
      ),
      floatingActionButton: FabCircularMenu(),
    );
  }

  Widget _buildBody(BuildContext context) {
    return CustomScrollView(
      controller: _scrollController,
      slivers: <Widget>[
        AppBarComponent(scrollToAboutSection: () => _scrollToSection(_aboutKey)),
        SliverToBoxAdapter(
          child: Column(
            children: <Widget>[
              SectionHomePage(
                sectionKey: _aboutKey,
                title: 'À propos de moi',
                child: AboutMeCard(),
              ),
              SectionHomePage(
                sectionKey: _projectsKey,
                title: 'Mes projets', 
                child: ProjectsCard(),
              ),
              SectionHomePage(
                sectionKey: _skillsKey,
                title: 'Mes compétences', 
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
        ),
      ],
    );
  }
}

//// With ListView more complexe code
// import 'package:flutter/material.dart';

// import '../components/appbar_component.dart';
// import '../components/drawer_component.dart';
// import '../components/section_home_page.dart';
// import '../components/about_me_card.dart';
// import '../components/projects_card.dart';
// import '../components/skills_card.dart';
// import '../components/techno_card.dart';
// import '../components/fab_circular_menu.dart';
// import '../components/footer.dart'; // Importez le Footer ici
// import '../utils/global_colors.dart';

// class HomeScreen extends StatelessWidget {
//   final ScrollController _scrollController = ScrollController();
//   final GlobalKey _aboutKey = GlobalKey();
//   final GlobalKey _projectsKey = GlobalKey();
//   final GlobalKey _skillsKey = GlobalKey();
//   final GlobalKey _technoKey = GlobalKey();

//   HomeScreen({ super.key });

//   void _scrollToSection(GlobalKey key) {
//     final context = key.currentContext;
//     if (context != null) {
//       Scrollable.ensureVisible(context, duration: Duration(milliseconds: 500), curve: Curves.linear);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       drawer: DrawerComponent(
//         scrollToSection: _scrollToSection,
//         aboutKey: _aboutKey,
//         projectsKey: _projectsKey,
//         skillsKey: _skillsKey,
//         technoKey: _technoKey,
//       ),
//       body: Container(
//         decoration: BoxDecoration(
//           color: GlobalColors.secondaryBackground,
//         ),
//         child: _buildBody(context),
//       ),
//       floatingActionButton: FabCircularMenu(),
//     );
//   }

//   Widget _buildBody(BuildContext context) {
//     return CustomScrollView(
//       controller: _scrollController,
//       slivers: <Widget>[
//         AppBarComponent(scrollToAboutSection: () => _scrollToSection(_aboutKey)),
//         SliverToBoxAdapter(
//           child: ListView(
//             controller: _scrollController,
//             cacheExtent: 2000, // Cache extent to improve performance when scrolling.
//             shrinkWrap: true, // Makes the ListView take up only as much space as needed.
//             children: <Widget>[
//               Column(
//                 children: <Widget>[
//                   SectionHomePage(
//                     sectionKey: _aboutKey,
//                     title: 'À propos de moi',
//                     child: AboutMeCard(),
//                   ),
//                   SectionHomePage(
//                     sectionKey: _projectsKey,
//                     title: 'Mes projets', 
//                     child: ProjectsCard(),
//                   ),
//                   SectionHomePage(
//                     sectionKey: _skillsKey,
//                     title: 'Mes compétences', 
//                     child: SkillsCard(),
//                   ),
//                   SectionHomePage(
//                     sectionKey: _technoKey,
//                     title: 'Technologies', 
//                     child: TechnologiesCard(),
//                   ),
//                   Footer(), // Ajoutez le Footer ici
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }

