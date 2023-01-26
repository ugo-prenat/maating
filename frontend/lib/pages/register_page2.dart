import 'package:flutter/material.dart';
import 'dart:io';
import 'package:intl/intl.dart';
import 'package:maating/widgets/sourceAvatar.dart';
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
          return SourceAvatar(onTakingImage: (ImageSource media) {
            getImage(media);
          });
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
        automaticallyImplyLeading: false,
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
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(right: 105),
                      child: Text(
                        'Date de Naissance',
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
                        controller: ageController,
                        decoration: InputDecoration(
                          suffixIcon: const Icon(Icons.calendar_today_outlined),
                          hintText: 'jj/MM/yyyy',
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(10)
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.blue),
                              borderRadius: BorderRadius.circular(10)
                          ),
                          contentPadding: const EdgeInsets.symmetric(vertical: 2, horizontal: 15),
                          errorStyle: const TextStyle(
                            fontSize: 16,
                        ),
                        ),
                        readOnly: true,
                        onTap: () async {
                          DateTime ? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(1950),
                              lastDate: DateTime.now(),
                          );
                          if(pickedDate != null) {
                            String formattedDate = DateFormat('dd/MM/yyyy').format(pickedDate);
                            setState(() {
                              ageController.text = formattedDate;
                            });
                          }
                        },
                        validator: (input) {
                          if(input == '') {
                            return 'Veuillez renseignez une date.';
                          }
                          return null;
                        },
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(right: 250),
                      child: Text(
                        'Ville',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                     SizedBox(
                        width: 300,
                        height: 80,
                        child: TextFormField(
                          controller: cityController,
                          decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(horizontal: 15.0),
                              filled: true,
                              fillColor: Colors.white,
                              hintText: 'Paris (75000)',
                              border: OutlineInputBorder(
                                  borderSide: const BorderSide(color: Colors.white),
                                  borderRadius: BorderRadius.circular(10)
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(color: Colors.blue),
                                  borderRadius: BorderRadius.circular(10)
                              ),
                            errorStyle: const TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          validator: (input) {
                            if(input == '') {
                              return 'Veuillez renseigner une ville.';
                            }
                          },
                        ),
                      ),
                    const Padding(
                          padding: EdgeInsets.only(right: 220),
                          child: Text(
                              'Mobilité',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                              ),
                          ),
                        ),
                    SizedBox(
                      width: 350,
                      height: 50,
                      child: SliderTheme(
                          data: const SliderThemeData(
                            valueIndicatorColor: Colors.transparent,
                          ),
                          child: Slider(
                            value: _currentSliderValue,
                            min: 1,
                            max: 100,
                            divisions: 100,
                            label: '${_currentSliderValue.round()} km',
                            onChanged: (double values) {
                              setState(() {
                                _currentSliderValue = values;
                              });
                            },
                          ),
                        ),
                    ),
                    image != null
                    ? SizedBox(
                      width: 300,
                      height: 100,
                      child: ClipRRect(
                          child: Image.file(
                            File(image!.path),
                            fit: BoxFit.contain,
                            width: MediaQuery.of(context).size.width,
                            height: 400,
                          ),
                        ),
                    )
                     : TextButton(
                      onPressed: () {
                        chooseImageSource();
                      },
                        style: TextButton.styleFrom(
                        fixedSize: const Size(120, 120),
                        side: const BorderSide(
                            width: 2,
                            color: Colors.blue,
                        ),
                      ),
                      child: const Icon(Icons.add),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Text(
                          'Sélectionnez un avatar',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 140, top: 40),
                      child: ElevatedButton(
                          onPressed: () async {
                            var birthDate = ageController.text;
                            var city = cityController.text;

                            if(_formKey.currentState!.validate()) {
                              Navigator.pushNamed(context, '/map');
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

Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                            DateFormat('dd/MM/yyyy').format(selectedDate),
                          style: const TextStyle(
                              fontSize: 16,
                              color: Colors.blue,
                              backgroundColor: Colors.white,
                              height: 2.5,
                          ),
                        ),
                        TextButton(
                          onPressed: () => _selectDate(context),
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.white,
                          ),
                          child: const Icon(Icons.calendar_month_outlined),
                        ),
                      ],
                    ),
 */