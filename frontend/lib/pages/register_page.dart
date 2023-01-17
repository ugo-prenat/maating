import 'package:flutter/material.dart';
import 'package:maating/extension/checkInput.dart';

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
                padding: const EdgeInsets.only(top: 10, bottom: 40),
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
                          Padding(
                            padding: const EdgeInsets.only(bottom: 50),
                            child: SizedBox(
                              width: 300,
                              child: TextFormField(
                                    controller: firstNameController,
                                    decoration: InputDecoration(
                                      contentPadding: const EdgeInsets.symmetric(horizontal: 15.0),
                                      filled: true,
                                      fillColor: Colors.white,
                                      labelText: 'Prénom',
                                      labelStyle: const TextStyle(
                                        fontSize: 25,
                                        color: Colors.blue,
                                      ),
                                      border: OutlineInputBorder(
                                        borderSide: const BorderSide(color: Colors.white),
                                        borderRadius: BorderRadius.circular(10)
                                      ),
                                      focusedBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.blue),
                                      )
                                    ),
                                validator: (input) {
                                        if(input == '') return 'Veuillez renseignez ce champ.';
                                        else if(input!.length < 2) return 'Votre prénom doit comporter au moins 3 caractères';
                                      },
                                  ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 50),
                            child: SizedBox(
                              width: 300,
                              child: TextFormField(
                                controller: emailController,
                                decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.symmetric(horizontal: 15.0),
                                    filled: true,
                                    fillColor: Colors.white,
                                    labelText: 'Email',
                                    hintText: 'john.doe@mail.com',
                                    labelStyle: const TextStyle(
                                      fontSize: 25,
                                      color: Colors.blue,
                                    ),
                                    border: OutlineInputBorder(
                                        borderSide: const BorderSide(color: Colors.white),
                                        borderRadius: BorderRadius.circular(10)
                                    ),
                                    focusedBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.blue),
                                    )
                                ),
                                validator: (input) {
                                  if (input == '') return 'Ce champs est obligatoire';
                                  else if (!input!.isValidEmail()) return 'Mauvais format d\'email';
                                },
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 70),
                            child: SizedBox(
                              width: 300,
                              child: TextFormField(
                                controller: passwordController,
                                obscureText: isPasswordVisible,
                                decoration: InputDecoration(
                                    suffixIcon:
                                    Padding(
                                      padding: EdgeInsetsDirectional.zero,
                                      child: IconButton(
                                        icon: const Icon(Icons.remove_red_eye_outlined, color: Colors.black),
                                        onPressed: () {
                                          showPwd();
                                        },
                                      ),
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(horizontal: 15.0),
                                    filled: true,
                                    fillColor: Colors.white,
                                    labelText: 'Mot de Passe',
                                    labelStyle: const TextStyle(
                                      fontSize: 25,
                                      color: Colors.blue,
                                    ),
                                    border: OutlineInputBorder(
                                        borderSide: const BorderSide(color: Colors.white),
                                        borderRadius: BorderRadius.circular(10)
                                    ),
                                    focusedBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.blue),
                                    )
                                ),
                                validator: (input) {
                                  if (input == '') return 'Ce champs est obligatoire';
                                  else if (input!.length < 6) return "Le mot de passe doit contenir plus de 5 charactères";
                                },
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 140),
                            child: ElevatedButton(
                                onPressed: () async {
                                  var firstName = firstNameController.text;
                                  var email = emailController.text;
                                  var password = passwordController.text;

                                  if(_formKey.currentState!.validate()) {
                                    Navigator.pushNamed(context, '/register2');
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.only(left: 25),
                                    fixedSize: const Size(150, 50),
                                    backgroundColor: Colors.white,
                                    side: const BorderSide(
                                        width: 2,
                                        color: Colors.white
                                    )
                                ),
                                child: Row(
                                  children: [
                                    const Text(
                                      'Suivant',
                                      style: TextStyle(
                                          fontSize: 17,
                                          color: Colors.black
                                      ),
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
                                )
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
