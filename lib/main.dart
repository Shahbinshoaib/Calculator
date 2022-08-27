import 'package:calculator/calculator.dart';
import 'package:flutter/material.dart';

import 'config.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {


  final MaterialColor white = const MaterialColor(
    0xFFf2f2f2,
    const <int, Color>{
      50: const Color(0xFFf2f2f2),
      100: const Color(0xFFf2f2f2),
      200: const Color(0xFFf2f2f2),
      300: const Color(0xFFf2f2f2),
      400: const Color(0xFFf2f2f2),
      500: const Color(0xFFf2f2f2),
      600: const Color(0xFFf2f2f2),
      700: const Color(0xFFf2f2f2),
      800: const Color(0xFFf2f2f2),
      900: const Color(0xFFf2f2f2),
    },
  );

  final MaterialColor black = const MaterialColor(
    0xFF000000,
    const <int, Color>{
      50: const Color(0xFFf2f2f2),
      100: const Color(0xFFf2f2f2),
      200: const Color(0xFFf2f2f2),
      300: const Color(0xFFf2f2f2),
      400: const Color(0xFFf2f2f2),
      500: const Color(0xFFf2f2f2),
      600: const Color(0xFFf2f2f2),
      700: const Color(0xFFf2f2f2),
      800: const Color(0xFFf2f2f2),
      900: const Color(0xFFf2f2f2),
    },
  );

  @override
  void initState(){
    super.initState();
    currentTheme.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ELECTROMATES Calculator',
      theme: ThemeData(
        accentColor: Colors.white,
        splashColor: Colors.grey,
        primarySwatch: white,
        primaryColor: Colors.white,
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        buttonColor: Colors.white,
        scaffoldBackgroundColor: Colors.white,
        cardColor: Colors.white,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: black,
        splashColor: Colors.grey,

      ),
      themeMode: currentTheme.currentTheme(),
      home: Calculator(),
    );
  }
}

