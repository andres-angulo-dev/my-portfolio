import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:andres_angulo_portfolio/main.dart' as app;
import 'dart:developer' as developer;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('test d\'intégration simple', (WidgetTester tester) async {
    developer.log('App démarrée');
    app.main(); // Lancez l'application

    await tester.pumpAndSettle(); // Attendez que l'application se stabilise
    developer.log('App stabilisée');

    // Vérifiez que l'écran d'accueil est affiché
    expect(find.text('Accueil'), findsOneWidget);
    developer.log('Écran d\'accueil trouvé');

    // Appuyez sur le bouton "Télécharger CV"
    final Finder boutonCv = find.text('Télécharger mon CV');
    await tester.tap(boutonCv);
    await tester.pumpAndSettle(); // Attendez que l'interface se stabilise après l'action
    developer.log('Bouton "Télécharger mon CV" tapé');

    // Ouvrez le menu de navigation et naviguez vers l'écran de contact
    await tester.tap(find.byIcon(Icons.contact_mail));
    await tester.pumpAndSettle();
    expect(find.text('Contact'), findsOneWidget);
    developer.log('Écran de contact trouvé');
  });
}