import 'package:cricket_scorer/core/constants/AppColors.dart';
import 'package:cricket_scorer/screens/splash_screen/splash_screen.dart';
import 'package:flutter/material.dart';

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
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Appcolors.primaryColor,
          brightness: Brightness.light,
        ),
        inputDecorationTheme: InputDecorationTheme(
          isDense: true,
          border: OutlineInputBorder(
            borderSide: BorderSide(width: 2, color: Appcolors.primaryColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 2, color: Appcolors.primaryColor),
          ),
        ),
      ),
      home: SplashScreen(),
    );
  }
}
