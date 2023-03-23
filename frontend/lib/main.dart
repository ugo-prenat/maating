import 'package:flutter/material.dart';
import 'package:maating/models/event.dart';
import 'package:maating/pages/create_event_page.dart';
import 'package:maating/pages/event_page.dart';
import 'package:maating/pages/register_sports_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:maating/pages/login_page.dart';
import 'package:maating/pages/main_page.dart';
import 'package:maating/pages/register_page.dart';
import 'package:maating/pages/register_page2.dart';
import 'package:maating/pages/sports_selection_register_page.dart';

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
      routes: {
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RegisterPage(),
        '/register2': (context) => const RegisterPage2(),
        '/map': (context) => const MainPage(),
        '/register_sports': (context) => const RegisterSportPage(
              sports: [],
            ),
        '/register_sports_selection': (context) =>
            const SportSelectionRegisterPage(
              sports: [],
            ),
        '/event_page': (context) => EventPage(event: rawEvent),
        '/create_event': (context) => const CreateEventPage(),
      },
      theme: ThemeData(
          textTheme: GoogleFonts.poppinsTextTheme().copyWith(
              bodyText1: GoogleFonts.poppins(textStyle: textTheme.bodyText1))),
      home: const MainPage(),
    );
  }
}
