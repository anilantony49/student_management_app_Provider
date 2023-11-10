import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:database_student/ui/screens/home_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: const CircleAvatar(
        radius: 70,
        backgroundColor: Colors.blue,
        child: CircleAvatar(
        backgroundImage: AssetImage('assets/images/student image.jpg',
        ),
        radius: 40,
        
        
      ),
    ),
    nextScreen: const HomeScreen(),
    splashTransition: SplashTransition.rotationTransition,
    backgroundColor: Colors.black,);
  }
}