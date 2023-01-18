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
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                child: Image.asset(
                  'lib/assets/logo_maating.png',
                  fit: BoxFit.contain,
                  width: 150,
                  height: 150,
                ),
              ),
              const Text(
                  'Bienvenue sur \n Maating',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                  ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 40, bottom: 50),
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/register');
                    },
                    style: ElevatedButton.styleFrom(
                      fixedSize: const Size(300, 50), backgroundColor: Colors.white,
                    ),
                    child: const Text(
                        'Inscription',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 22,
                      ),
                    )
                ),
              ),
                const Text(
                  'Déjà un compte ?',
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 20,
                  ),
                ),
              Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 20),
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/login');
                    },
                    style: ElevatedButton.styleFrom(
                      fixedSize: const Size(300, 50), backgroundColor: Colors.white,
                    ),
                    child: const Text(
                      'Connexion',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 22,
                      ),
                    ),
                ),
              ),
              ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    fixedSize: const Size(300, 50),
                    backgroundColor: Colors.transparent.withOpacity(0.01),
                    side: const BorderSide(
                      width: 2,
                      color: Colors.blue
                    )
                  ),
                  child: Row(
                    children: [
                      const Text(
                        'Se connecter avec Google',
                        style: TextStyle(
                            fontSize: 17,
                            color: Colors.blue
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Image.asset(
                            'lib/assets/google.png',
                            width: 30,
                            height: 30,
                        ),
                      ),
                    ],
                  )
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/*
ElevatedButton.icon(
                label: const Text(
                'Se connecter avec Google',
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.blue
                ),
              ),
                icon: Image.asset(
                    'lib/assets/google.png',
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '');
                },
                style: ElevatedButton.styleFrom(
                  fixedSize: const Size(300, 50), backgroundColor: Colors.black.withOpacity(0.05),
                ),
              ),
 */