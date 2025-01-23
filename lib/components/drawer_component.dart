import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../utils/global_colors.dart';
import '../utils/global_others.dart';

class DrawerComponent extends StatelessWidget {
  final Function(GlobalKey) scrollToSection;
  final GlobalKey aboutKey;
  final GlobalKey projectsKey;
  final GlobalKey skillsKey;
  final GlobalKey technoKey;

  const DrawerComponent({
    super.key, 
    required this.scrollToSection,
    required this.aboutKey,
    required this.projectsKey,
    required this.skillsKey,
    required this.technoKey,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            // User's name and email displayed with offset for alignment
            accountName: Transform.translate(
              offset: Offset(-10, 0),
              child: Text(
                'Andrés Angulo',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: GlobalColors.drawerTitleColor,
                ),
              ), 
            ),
            accountEmail: Transform.translate(
              offset: Offset(-10, 0),
              child: Text(
                textAlign: TextAlign.justify,
                'Développeur Web & Mobile',
                style: TextStyle(
                  fontSize: 16,
                  color: GlobalColors.drawerTitleColor,
                ),
              ),
            ),
            decoration: BoxDecoration(
              color: GlobalColors.drawerBackground,
              image: DecorationImage(
                image: AssetImage(kIsWeb ? AppImages.drawerBackgroundWeb : AppImages.drawerBackgroundMobile), 
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Drawer items for navigation
          _createDrawerItem(
            icon: Icons.info,
            text: 'À propos',
            onTap: () => _onDrawerItemTap(context, aboutKey),
          ),
          _createDrawerItem(
            icon: Icons.folder_open,
            text: 'Projets',
            onTap: () => _onDrawerItemTap(context, projectsKey),
          ),
          _createDrawerItem(
            icon: Icons.build_circle,
            text: 'Compétences',
            onTap: () => _onDrawerItemTap(context, skillsKey),
          ),
          _createDrawerItem(
            icon: Icons.memory,
            text: 'Technologies',
            onTap: () => _onDrawerItemTap(context, technoKey),
          ),
          _createDrawerItem(
            icon: Icons.contact_mail,
            text: 'Contact',
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/contact');
            },
          ),
        ],
      ),
    );
  }

  // Helper function to create a Drawer item
  Widget _createDrawerItem({required IconData icon, required String text, required GestureTapCallback onTap}) {
    return Padding( 
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: ListTile(
          leading: Icon(icon),
          title: Text(text),
          onTap: onTap,
        ),
      ),
    );
  }

  // Handle drawer item tap, close drawer and scroll to section
  void _onDrawerItemTap(BuildContext context, GlobalKey key) {
    Navigator.pop(context);
    scrollToSection(key);
  }
}
