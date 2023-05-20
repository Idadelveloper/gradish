import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gradish/screens/home_screen.dart';

void main() {
  runApp(const GradishApp());
}

class GradishApp extends StatelessWidget {
  const GradishApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xffffc604)),
          textTheme: GoogleFonts.josefinSansTextTheme(
              Theme.of(context).textTheme
          )
      ),
      home: const HomeScreen(),
    );
  }
}

