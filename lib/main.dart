import 'package:flutter/material.dart';
import 'package:moviecatalogue/screens/main_screen.dart';

const textColor = Color(0xFFfefefe);

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFF161622),
        brightness: Brightness.dark,
        textTheme: const TextTheme(
          headline1: TextStyle(
            fontSize: 39,
            fontWeight: FontWeight.bold,
            fontFamily: 'RobotoCondensed',
            letterSpacing: 0.2,
            color: textColor,
          ),
          headline2: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            fontFamily: 'RobotoCondensed',
            color: textColor,
          ),
          bodyText1: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            fontFamily: 'RobotoCondensed',
            color: textColor,
          ),
        ),
      ),
      home: const MainScreen(),
    );
  }
}
