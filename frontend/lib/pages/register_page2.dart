import 'package:flutter/material.dart';
import 'package:maating/extension/checkInput.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

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

  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = const TimeOfDay(hour: 00, minute: 00);

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
    // Select time after select day
    _selectTime(context);
  }
  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null) {
      setState(() {
        selectedDate = DateTime(
            selectedDate.year,
            selectedDate.month,
            selectedDate.day,
        );
      });
    }
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
                      child: TextField(
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
                          contentPadding: const EdgeInsets.symmetric(vertical: 2, horizontal: 15)
                        ),
                        readOnly: true,
                        onTap: () async {
                          DateTime ? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2100),
                          );
                          if(pickedDate != null) {
                            print(pickedDate);
                            String formattedDate = DateFormat('dd/MM/yyyy').format(pickedDate);
                            setState(() {
                              ageController.text = formattedDate;
                            });
                          }
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
                          decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(horizontal: 15.0),
                              filled: true,
                              fillColor: Colors.white,
                              hintText: 'Paris (75000)',
                              border: OutlineInputBorder(
                                  borderSide: const BorderSide(color: Colors.white),
                                  borderRadius: BorderRadius.circular(10)
                              ),
                              focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.blue),
                              ),
                          ),
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