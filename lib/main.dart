import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import './screens/splash_screen.dart';
import './screens/contact_screen.dart';

Future<void> main() async {
  try {
    await dotenv.load(fileName: 'local.env'); // Load environment variables from the .env file.
    runApp(const MyPortfolioApp());
  } catch (error) {
    debugPrint('Error loading .env file: $error');
  }
}

class MyPortfolioApp extends StatelessWidget {
  const MyPortfolioApp({ super.key });

  @override
  Widget build(BuildContext context) {
     SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.red, // Status bar color
    ));
    return MaterialApp(
      title: 'Andrés Angulo | Portfolio',
      theme: ThemeData(primarySwatch: Colors.green), 
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) =>  SplashScreen(),
        '/contact': (context) => const ContactScreen(),
      },
    );
  }
}