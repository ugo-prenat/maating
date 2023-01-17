import 'package:flutter/material.dart';
import 'package:maating/extension/checkInput.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class RegisterPage2 extends StatefulWidget {
  const RegisterPage2({super.key});

  @override
  State<RegisterPage2> createState() => _RegisterPage2State();
}

class _RegisterPage2State extends State<RegisterPage2> {

  final _formKey = GlobalKey<FormState>();

  bool isPasswordVisible = true;

  var ageController = TextEditingController();
  var cityController = TextEditingController();
  var mobilityController = TextEditingController();
  var profilImgController = TextEditingController();

  double _currentSliderValue = 20;

  XFile? image;

  final ImagePicker picker = ImagePicker();

  Future getImage(ImageSource media) async {
    var img = await picker.pickImage(source: media);

    setState(() {
      image = img;
    });
  }

  void chooseImageSource() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              title: const Text('Sélectionnez une image depuis votre galerie ou prenez une photo.'),
            content: Container(
              height: MediaQuery.of(context).size.height / 6,
              child: Column(
                children: [
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        getImage(ImageSource.gallery);
                      },
                      child: Row(
                        children: const [
                          Icon(Icons.image),
                          Text('Galerie'),
                        ],
                      ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      getImage(ImageSource.camera);
                    },
                    child: Row(
                      children: const [
                        Icon(Icons.camera),
                        Text('Caméra'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }
    );
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
                          controller: ageController,
                          decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(horizontal: 15.0),
                              filled: true,
                              fillColor: Colors.white,
                              labelText: 'Âge',
                              hintText: 'jj/mm/AAAA',
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
                          controller: cityController,
                          decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(horizontal: 15.0),
                              filled: true,
                              fillColor: Colors.white,
                              labelText: 'Ville',
                              hintText: 'Paris (75000)',
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
                      padding: const EdgeInsets.only(bottom: 30),
                      child: Slider(
                        value: _currentSliderValue,
                        max: 100,
                        divisions: 20,
                        label: _currentSliderValue.round().toString(),
                        onChanged: (double values) {
                          setState(() {
                            _currentSliderValue = values;
                          });
                        },
                      ),
                    ),
                    image != null
                    ? Padding(
                      padding: const EdgeInsets.all(0),
                      child: ClipRRect(
                        child: Image.file(
                          File(image!.path),
                          fit: BoxFit.contain,
                          width: MediaQuery.of(context).size.width,
                          height: 300,
                        ),
                      ),
                    ) : TextButton(
                      onPressed: () {
                        chooseImageSource();
                        },
                        style: TextButton.styleFrom(
                        fixedSize: const Size(150, 150),
                        side: const BorderSide(
                            width: 2,
                            color: Colors.blue,
                        ),
                      ),
                      child: const Icon(Icons.add),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 140, top: 40),
                      child: ElevatedButton(
                          onPressed: () async {
                            if(_formKey.currentState!.validate()) {
                              Navigator.pushNamed(context, '');
                            }
                          },
                          style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.only(left: 25),
                              fixedSize: const Size(150, 50),
                              backgroundColor: Colors.white,
                              side: const BorderSide(
                                  width: 2,
                                  color: Colors.white,
                                strokeAlign: StrokeAlign.center
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

/*

TextButton(
                        onPressed: () {
                          chooseImageSource();
                        },
                      style: TextButton.styleFrom(
                          fixedSize: const Size(150, 150),
                          side: const BorderSide(
                            width: 2,
                            color: Colors.blue,
                          ),
                      ),
                        child: const Icon(Icons.add),
                    ),
 */