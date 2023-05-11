import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:maating/extension/checkInput.dart';
import 'package:maating/services/requestManager.dart';
import 'package:maating/main.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _client = http.Client();
  final _formKey = GlobalKey<FormState>();

  bool isPasswordVisible = true;

  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  showPwd() {
    setState(() {
      isPasswordVisible = !isPasswordVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: const Color(0xFF2196F3),
        elevation: 0.0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              colors: [Color(0xFF2196F3), Color(0xFF000000)],
              begin: FractionalOffset.topCenter,
              end: FractionalOffset.bottomCenter,
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp),
        ),
        child: Center(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              child: Image.asset(
                'lib/assets/logo_maating.png',
                fit: BoxFit.contain,
                width: 150,
                height: 150,
              ),
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(right: 240),
                    child: Text(
                      'Email',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 300,
                    height: 100,
                    child: TextFormField(
                      key: const Key('emailInput'),
                      controller: emailController,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      textInputAction: TextInputAction.next,
                      maxLength: 40,
                      decoration: InputDecoration(
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 15.0),
                        filled: true,
                        fillColor: Colors.white,
                        hintText: 'john.doe@mail.com',
                        counterText: '',
                        border: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(10)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.blue),
                            borderRadius: BorderRadius.circular(10)),
                        errorStyle: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      validator: (input) {
                        if (input == '') {
                          return 'Veuillez renseignez un email.';
                        } else if (!input!.isValidEmail()) {
                          return 'Mauvais format d\'email.';
                        }
                        return null;
                      },
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(right: 160),
                    child: Text(
                      'Mot de passe',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 300,
                    height: 120,
                    child: TextFormField(
                      key: const Key('passwordInput'),
                      controller: passwordController,
                      obscureText: isPasswordVisible,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      textInputAction: TextInputAction.done,
                      maxLength: 25,
                      decoration: InputDecoration(
                        suffixIcon: Padding(
                          padding: EdgeInsetsDirectional.zero,
                          child: IconButton(
                            icon: Icon(
                                isPasswordVisible
                                    ? Icons.visibility_off_outlined
                                    : Icons.visibility_outlined,
                                color: Colors.black),
                            onPressed: () {
                              showPwd();
                            },
                          ),
                        ),
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 15.0),
                        filled: true,
                        fillColor: Colors.white,
                        counterText: '',
                        border: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(10)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.blue),
                            borderRadius: BorderRadius.circular(10)),
                        errorStyle: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      validator: (input) {
                        if (input == '') {
                          return 'Veuillez renseignez un mot de\npasse.';
                        } else if (input!.length < 6) {
                          return "Le mot de passe doit contenir \nplus de 5 caractères";
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: ElevatedButton(
                      key: const Key('loginButton'),
                      onPressed: () async {
                        var email = emailController.text;
                        var password = passwordController.text;
                        var bodyUser;
                        var userId;

                        if (_formKey.currentState!.validate()) {
                          RequestManager(_client)
                              .loginUser(email, password)
                              .then((res) => {
                                    if (res.statusCode == 200)
                                      {
                                        bodyUser = jsonDecode(res.body),
                                        userId = bodyUser["_id"],
                                        sp.setString('User', userId),
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                          content: Text(
                                            "Vous êtes connecté(e). Bienvenue !",
                                            textAlign: TextAlign.center,
                                          ),
                                          backgroundColor: Colors.green,
                                        )),
                                        Navigator.pushNamedAndRemoveUntil(
                                            context,
                                            '/main_page',
                                            (route) => false),
                                      }
                                    else
                                      {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                          content: Text(
                                            "Une erreur est survenue.",
                                            textAlign: TextAlign.center,
                                          ),
                                          backgroundColor: Colors.redAccent,
                                        ))
                                      }
                                  });
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        fixedSize: const Size(300, 50),
                        backgroundColor: const Color(0xFF0085FF),
                      ),
                      child: const Text(
                        'Se Connecter',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Mot de passe oublié ?',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/reset');
                          },
                          child: const Text(
                            'Modifier',
                            style: TextStyle(
                              fontSize: 18,
                              color: Color(0xFF0085FF),
                            ),
                          ))
                    ],
                  )
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
