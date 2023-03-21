import 'package:flutter/material.dart';
import 'package:maating/extension/checkInput.dart';
import 'package:maating/pages/register_page2.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();

  bool isPasswordVisible = true;

  var firstNameController = TextEditingController();
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 15),
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Prénom',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      width: 300,
                      height: 100,
                      child: TextFormField(
                        controller: firstNameController,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        textInputAction: TextInputAction.next,
                        maxLength: 25,
                        decoration: InputDecoration(
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
                            return 'Veuillez renseignez votre prénom';
                          } else if (input!.length < 3) {
                            return 'Votre prénom doit comporter \n au moins 3 caractères.';
                          }
                          return null;
                        },
                      ),
                    ),
                    const Text(
                      'Email',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      width: 300,
                      height: 100,
                      child: TextFormField(
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
                    const Text(
                      'Mot de passe',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      width: 300,
                      height: 120,
                      child: TextFormField(
                        controller: passwordController,
                        obscureText: isPasswordVisible,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        textInputAction: TextInputAction.done,
                        maxLength: 25,
                        decoration: InputDecoration(
                          suffixIcon: Padding(
                            padding: EdgeInsetsDirectional.zero,
                            child: IconButton(
                              icon: const Icon(Icons.remove_red_eye_outlined,
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
                          } else if (input!.length < 6) {
                            return "Le mot de passe doit contenir \n plus de 5 caractères";
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 140),
                      child: ElevatedButton(
                          onPressed: () async {
                            var firstName = firstNameController.text;
                            var email = emailController.text;
                            var password = passwordController.text;

                            if (_formKey.currentState!.validate()) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => RegisterPage2(
                                              userFirstInfo: [
                                                firstName,
                                                email,
                                                password
                                              ])));
                            }
                          },
                          style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.only(left: 25),
                              fixedSize: const Size(150, 50),
                              backgroundColor: Colors.white,
                              side: const BorderSide(
                                  width: 2, color: Colors.white)),
                          child: Row(
                            children: [
                              const Text(
                                'Suivant',
                                style: TextStyle(
                                    fontSize: 17, color: Colors.black),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Image.asset(
                                  'lib/assets/arrow_right.png',
                                  width: 30,
                                  height: 30,
                                ),
                              ),
                            ],
                          )),
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
