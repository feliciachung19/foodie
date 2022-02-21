import 'package:flutter/material.dart';

import 'package:foodie/ui/screens/welcome_screen.dart';

class FoodieApp extends StatelessWidget {
  const FoodieApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Eat.Sleep.Repeat.',
      initialRoute: '/welcomeScreen',
      routes: {
        '/welcomeScreen': (context) => const WelcomeScreen(),
      },
    );
  }
}