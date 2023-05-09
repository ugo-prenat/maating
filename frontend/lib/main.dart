import 'package:flutter/material.dart';
import 'package:maating/models/event.dart';
import 'package:maating/models/user.dart';
import 'package:maating/pages/event_page.dart';
import 'package:maating/pages/home_page.dart';
import 'package:maating/pages/register_sports_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:maating/pages/login_page.dart';
import 'package:maating/pages/main_page.dart';
import 'package:maating/pages/register_page.dart';
import 'package:maating/pages/register_page2.dart';
import 'package:maating/pages/reset_pwd_page.dart';
import 'package:maating/pages/sports_selection_register_page.dart';
import 'package:maating/pages/selectAvatar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:maating/pages/user_profil_page.dart';

import 'pages/map_page.dart';

late SharedPreferences sp;

Future<void> main() async {
  runApp(const MyApp());
  sp = await SharedPreferences.getInstance();
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
        '/reset': (context) => const ResetPwdPage(),
        '/register': (context) => const RegisterPage(),
        '/register2': (context) => const RegisterPage2(userFirstInfo: []),
        '/avatar': (context) => const SelectAvatar(
              userFirstInfo: [],
            ),
        '/map': (context) => const MapPage(),
        '/register_sports': (context) => const RegisterSportPage(
              userFirstInfo: [],
              sports: [],
            ),
        '/register_sports_selection': (context) =>
            const SportSelectionRegisterPage(
              sports: [],
            ),
        '/event_page': (context) => EventPage(event: rawEvent),
        '/main_page': (context) => const MainPage(),
      },
      theme: ThemeData(
          textTheme: GoogleFonts.poppinsTextTheme().copyWith(
              bodyText1: GoogleFonts.poppins(textStyle: textTheme.bodyText1))),
      home: const LoginPage(),
    );
  }
}
