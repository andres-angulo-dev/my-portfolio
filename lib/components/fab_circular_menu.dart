import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../screens/contact_screen.dart';
import 'package:fab_circular_menu_plus/fab_circular_menu_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class FabCircularMenu extends StatelessWidget {
  const FabCircularMenu({ super.key });

  @override
  Widget build(BuildContext context) {
    return FabCircularMenuPlus(
      ringColor: Color.fromARGB(200, 46, 50, 78), // Ring color with transparency.
      ringDiameter: 200.0, // Diameter of the circular menu.
      ringWidth: 40.0, // Width of the ring.
      fabSize: 54.0, // Size of the Floating Action Button.
      fabElevation: 8.0, // Elevation of the Floating Action Button.
      fabIconBorder: CircleBorder(), // Border shape for the Floating Action Button icon.
      fabColor: Colors.white, // Color of the Floating Action Button.
      fabOpenIcon: FaIcon(
        FontAwesomeIcons.handshake, 
        color: Color.fromARGB(255, 46, 50, 78), // Icon color when the menu is open.
      ),
      fabCloseIcon: Icon(
        Icons.close, 
        color: Color.fromARGB(255, 46, 50, 78), // Icon color when the menu is closed.
      ),
      fabMargin: const EdgeInsets.all(0), // Margin around the Floating Action Button.
      animationCurve: Curves.easeInCirc, // Animation curve for opening/closing the menu.
      animationDuration: Duration(milliseconds: 500), // Duration of the animation.
      children: <Widget>[
        IconButton(
          icon: Icon(Icons.mail, color: Colors.white), // Mail icon button.
          onPressed: () async {
            try {
                Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ContactScreen()), // Navigate to ContactScreen.
              );
            } catch (error) {
              throw 'Could not navigate to ContactScreen, error: $error';
            }
          }, 
        ),
        IconButton(
          icon: FaIcon(FontAwesomeIcons.github, color: Colors.white), // GitHub icon button.
          onPressed: () async {
            final url = 'https://github.com/AFAS75';
            try {
              await launchUrl(Uri.parse(url)); // Launch GitHub URL.
            } catch (error) {
              throw 'Could not launch $url, error: $error'; // Handle URL launch error.
            }
          }, 
        ),
        IconButton(
          icon: FaIcon(FontAwesomeIcons.linkedin, color: Colors.white), // LinkedIn icon button.
          onPressed: () async {
            const url = 'https://www.linkedin.com/in/andrés-angulo';
            try {
              await launchUrl(Uri.parse(url)); // Launch LinkedIn URL.
            } catch (error) {
              throw 'Could not launch $url, error: $error'; // Handle URL launch error.
            }
          }, 
        ),
      ],
    );
  }
}
