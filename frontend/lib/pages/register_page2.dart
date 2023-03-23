import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:maating/pages/selectAvatar.dart';

class RegisterPage2 extends StatefulWidget {
  const RegisterPage2({super.key, required this.userFirstInfo});

  final List<dynamic> userFirstInfo;
  @override
  State<RegisterPage2> createState() => _RegisterPage2State();
}

class _RegisterPage2State extends State<RegisterPage2> {
  final _formKey = GlobalKey<FormState>();

  bool isPasswordVisible = true;

  var ageController = TextEditingController();
  var cityController = TextEditingController();
  var mobilityController = TextEditingController();

  double _currentSliderValue = 20;

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
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration: InputDecoration(
                          suffixIcon: const Icon(Icons.calendar_today_outlined),
                          hintText: 'jj/MM/yyyy',
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(10)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.blue),
                              borderRadius: BorderRadius.circular(10)),
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 2, horizontal: 15),
                          errorStyle: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        readOnly: true,
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1950),
                            lastDate: DateTime.now(),
                          );
                          if (pickedDate != null) {
                            String formattedDate =
                                DateFormat('dd/MM/yyyy').format(pickedDate);
                            setState(() {
                              ageController.text = formattedDate;
                            });
                          }
                        },
                        validator: (input) {
                          if (input == '') {
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
                      height: 100,
                      child: TextFormField(
                        controller: cityController,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration: InputDecoration(
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 15.0),
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'Paris (75000)',
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
                            return 'Veuillez renseigner une ville.';
                          }
                        },
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(right: 210),
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
                      height: 100,
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
                    Padding(
                      padding: const EdgeInsets.only(left: 140, top: 20),
                      child: ElevatedButton(
                          onPressed: () async {
                            var birthDate = ageController.text;
                            var city = cityController.text;

                            if (_formKey.currentState!.validate()) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SelectAvatar(
                                        userFirstInfo: [
                                          ...widget.userFirstInfo,
                                          birthDate,
                                          city,
                                          _currentSliderValue.round()
                                        ]),
                                  ));
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.only(left: 25),
                            fixedSize: const Size(150, 50),
                            backgroundColor: Colors.white,
                            side: const BorderSide(
                              width: 2,
                              color: Colors.white,
                              strokeAlign: BorderSide.strokeAlignCenter,
                            ),
                          ),
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
