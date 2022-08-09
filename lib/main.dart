import 'package:flutter/material.dart';
import 'package:moviecatalogue/screens/main_screen.dart';
import 'package:moviecatalogue/theme/colors.dart';

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
        primarySwatch: Colors.pink,
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: CustomColors.primaryColor,
        ),
        scaffoldBackgroundColor: CustomColors.backgroundColor,
        brightness: Brightness.dark,
        fontFamily: 'Roboto',
        textTheme: TextTheme(
          headline1: TextStyle(
            fontSize: 39,
            fontWeight: FontWeight.bold,
            fontFamily: 'RobotoCondensed',
            letterSpacing: 0.2,
            color: CustomColors.textColor,
          ),
          headline2: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            fontFamily: 'RobotoCondensed',
            color: CustomColors.textColor,
          ),
          bodyText1: TextStyle(
            fontSize: 16,
            color: CustomColors.textColor,
            height: 1.35,
          ),
        ),
      ),
      home: const MainScreen(),
    );
  }
}
