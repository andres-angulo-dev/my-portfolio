import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_portfolio/components/drawer_component.dart';
import 'package:my_portfolio/screens/contact_screen.dart';

void main() {
  testWidgets('Test the Contact button in the Drawer', (WidgetTester tester) async {
    // Build the DrawerComponent directly
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Test Drawer')),
        body: Center(child: Text('Home Screen')),
        drawer: DrawerComponent(
          scrollToSection: (key) {},
          aboutKey: GlobalKey(),
          projectsKey: GlobalKey(),
          skillsKey: GlobalKey(),
          technoKey: GlobalKey(),
        ),
      ),
      routes: {
        '/contact': (context) => ContactScreen(),
      },
    ));

    // Open the Drawer using the navigation menu icon
    await tester.tap(find.byIcon(Icons.menu));
    await tester.pumpAndSettle();
    print('Drawer opened');

    // Find the Contact button and tap on it
    final Finder contactButton = find.text('Contact');
    expect(contactButton, findsOneWidget);
    await tester.tap(contactButton);
    await tester.pumpAndSettle();
    print('Contact button tapped');

    // Verify that the navigation to the Contact screen is performed
    expect(find.byType(ContactScreen), findsOneWidget);
    print('Navigation to Contact screen performed');
  });
}
