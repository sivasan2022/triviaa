import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:triviaa/pages/game_page.dart';
import 'package:triviaa/pages/home_page.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Triviaa',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color.fromRGBO(31, 31, 31, 1.0),
        textTheme: GoogleFonts.architectsDaughterTextTheme(),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: HomePage(),
    );
  }
}

