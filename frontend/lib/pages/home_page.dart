import 'package:flutter/material.dart';
import 'package:maating/main.dart';

class HomePage extends StatefulWidget {
    const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF2196F3),
        elevation: 0.0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [Color(0xFF2196F3), Color(0xFF000000)],
          begin: FractionalOffset.topCenter,
          end: FractionalOffset.bottomCenter,
          stops: [0.0, 1.0],
          tileMode: TileMode.clamp
          ),
        ),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              Padding(padding: EdgeInsets.only(top: 50)),
              Text("Wesh")
            ],
          ),
        ),
      ),
    );
  }
}
