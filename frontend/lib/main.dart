import 'package:flutter/material.dart';
import 'package:maating/pages/home_page.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    final textTheme = Theme.of(context).textTheme;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {},
      theme: ThemeData(
          textTheme: GoogleFonts.poppinsTextTheme().copyWith(
            bodyText1: GoogleFonts.poppins(textStyle: textTheme.bodyText1))
      ),
      home: const HomePage(),
    );
  }
}
