
import 'package:concentric_transition/page_view.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/screens/home_screen.dart';

import 'widgets/widget.dart';





class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final data = [
  ItemData(
  title: 'Bienvenidos a Weather APP.', 
  subtitle: 'Tu nuevo compañero para conocer el clima, estés donde estés.', 
  image: const AssetImage('assets/weather_onboarding.png'), 
  backgroundColor: const Color.fromRGBO(74, 144, 226, 1.0).withAlpha(60), 
  titleColor: Color.fromRGBO(51, 51, 51, 1), 
  subtitleColor: Color.fromRGBO(51, 51, 51, 1),
  background: Lottie.network('https://assets2.lottiefiles.com/packages/lf20_bq485nmñ.json'),
  ),
  ItemData(
  title: 'Siempre informado, sin sorpresas', 
  subtitle: 'Consulta el pronóstico en tiempo real, recibe alertas y planifica tu día con confianza', 
  image: const AssetImage('assets/weather_1.webp'), 
  backgroundColor: Colors.grey.shade200, 
  titleColor: Color.fromRGBO(51, 51, 51, 1), 
  subtitleColor: Color.fromRGBO(51, 51, 51, 1),
  background: Lottie.network('https://assets2.lottiefiles.com/packages/lf20_bq485nmñ.json'),
  ),
];

  int _currentIndex = 0;

 @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: [
          ConcentricPageView(
            colors: data.map((e) => e.backgroundColor).toList(),
            itemCount: data.length,
            onChange: (index) {
              setState(() {
                _currentIndex = index;  
              }); 
            },
            itemBuilder: (index) => ItemWidget(data: data[index]),
            nextButtonBuilder: (context) {
              if (_currentIndex == data.length - 1) {
                return IconButton(
                  onPressed: () {
                    Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => const HomeScreen()));
                  }, 
                  icon: Icon(
                    Icons.navigate_next,
                    color: Colors.grey.shade200,
                    size: screenWidth * 0.08,
                  )
                );
              } else {
                return Container();   
              }
            },
          ),
        ]
      ),
    );
  }
}
