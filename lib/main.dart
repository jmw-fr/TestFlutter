import 'package:flutter/material.dart';
import 'package:testflutter/screens/bmi_screen.dart';
import 'package:testflutter/screens/intro_screen.dart';
import 'package:testflutter/screens/weather_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(primarySwatch: Colors.blueGrey),
        initialRoute: '/',
        routes: {
          '/': (context) => const IntroScreen(),
          '/calculator': (context) => const BmiScreen(),
          '/weather': (context) => const WeatherScreen(),
        });
  }
}
