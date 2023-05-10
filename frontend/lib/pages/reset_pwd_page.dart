import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:maating/extension/checkInput.dart';
import 'package:maating/services/requestManager.dart';

import '../main.dart';

class ResetPwdPage extends StatefulWidget {
  const ResetPwdPage({super.key});

  @override
  State<ResetPwdPage> createState() => _ResetPwdPageState();
}

class _ResetPwdPageState extends State<ResetPwdPage> {

  final _pwdResetFormKey = GlobalKey<FormState>();
  final _client = http.Client();

  bool isPasswordVisible = true;

  var resetEmailController = TextEditingController();
  var resetPwdController = TextEditingController();
  var resetPwdConfirmController = TextEditingController();

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
                Form(
                  key: _pwdResetFormKey,
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
                            key: const Key('resetEmailInput'),
                            controller: resetEmailController,
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
                          padding: EdgeInsets.only(right: 65),
                          child: Text(
                            'Nouveau Mot de passe',
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
                            key: const Key('resetpasswordInput'),
                            controller: resetPwdController,
                            obscureText: isPasswordVisible,
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            textInputAction: TextInputAction.done,
                            maxLength: 25,
                            decoration: InputDecoration(
                              suffixIcon: Padding(
                                padding: EdgeInsetsDirectional.zero,
                                child: IconButton(
                                  icon: Icon(
                                      isPasswordVisible ?
                                      Icons.visibility_off_outlined : Icons.visibility_outlined,
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
                        const Padding(
                          padding: EdgeInsets.only(right: 55),
                          child: Text(
                            'Confirmer Mot de passe',
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
                            key: const Key('passwordConfirmInput'),
                            controller: resetPwdConfirmController,
                            obscureText: isPasswordVisible,
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            textInputAction: TextInputAction.done,
                            maxLength: 25,
                            decoration: InputDecoration(
                              suffixIcon: Padding(
                                padding: EdgeInsetsDirectional.zero,
                                child: IconButton(
                                  icon: Icon(
                                      isPasswordVisible ?
                                      Icons.visibility_off_outlined : Icons.visibility_outlined,
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
                                return 'Veuillez renseignez un mot de\n passe.';
                              } else if (input != resetPwdController.text) {
                                return "Les mots de passe ne \ncorrespondent pas.";
                              }
                              return null;
                            },
                          ),
                        ),
                        ElevatedButton(
                            onPressed: () async {
                              var email = resetEmailController.text;
                              var password = resetPwdController.text;
                              var pwdConfirm = resetPwdConfirmController.text;
                              var bodyUser;
                              var userId;

                              if(_pwdResetFormKey.currentState!.validate()) {
                                RequestManager(_client).resetUserPwd(
                                    userId,
                                    password,
                                ).then((res) => {
                                  if(res.statusCode == 200) {
                                    bodyUser = jsonDecode(res.body),
                                    userId = bodyUser["_id"],
                                    sp.setString('User', userId),
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(const SnackBar(
                                      content: Text(
                                        "Votre mot de passe a bien été modifié !",
                                        textAlign: TextAlign.center,
                                      ),
                                      backgroundColor: Colors.green,
                                    )),
                                    Navigator.pushNamedAndRemoveUntil(
                                        context,
                                        '/login',
                                            (route) => false),
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                        content: Text(
                                          'Une erreur est survenue.',
                                          textAlign: TextAlign.center,
                                        ),
                                        backgroundColor: Colors.redAccent,
                                        )
                                    )
                                  }
                                });
                              }
                            },
                          style: ElevatedButton.styleFrom(
                            fixedSize: const Size(300, 50),
                            backgroundColor: const Color(0xFF0085FF),
                          ),
                            child: const Text(
                                'Réinitialiser',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                ),
                            ),
                        ),
                      ],
                    ),
                ),
              ],
          ),
        ),
      ),
    );
  }
}
