import 'package:flutter/material.dart';
import 'package:weather_app/screens/onboarding_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.light(
          surface: Colors.grey.shade200,
          onSurface: Color.fromRGBO(51, 51, 51, 1),
          primary: Color.fromRGBO(74, 144, 226, 1.0),
          onPrimary: Colors.white,
        )
      ),
      home: const OnboardingScreen()
    );
  }
}


