import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:maating/pages/private_event_code_page.dart';
import 'package:maating/services/requestManager.dart';
import 'package:http/http.dart' as http;
import 'package:maating/main.dart';

class CreateEventPage extends StatefulWidget {
  const CreateEventPage({Key? key}) : super(key: key);

  @override
  State<CreateEventPage> createState() => _CreateEventPageState();
}

class _CreateEventPageState extends State<CreateEventPage> {
  final http.Client _client = http.Client();
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _dateController;
  late TextEditingController _timeController;
  late TextEditingController _durationController;
  late TextEditingController _priceController;
  late TextEditingController _locationController;
  late TextEditingController _descriptionController;
  late TextEditingController _maxNbController;
  late TextEditingController _currentParticipantsController;

  String userId = sp.getString('User') ?? '';

  bool _isPrivate = false;
  int _level = 1;
  late int _selectedSport;
  late int _selectedLocation;

  final List<DropdownMenuItem<int>> _sportDropdownItems = [
    const DropdownMenuItem<int>(
      value: 1,
      child: Text('Futsal'),
    ),
    const DropdownMenuItem<int>(
      value: 2,
      child: Text('Football'),
    ),
    const DropdownMenuItem<int>(
      value: 3,
      child: Text('Kayak'),
    ),
    const DropdownMenuItem<int>(
      value: 4,
      child: Text('Golf'),
    ),
  ];

  final List<DropdownMenuItem<int>> _locationDropdownItems = [
    const DropdownMenuItem<int>(
      value: 1,
      child: Text('Go Park'),
    ),
    const DropdownMenuItem<int>(
      value: 2,
      child: Text('Stade Salif Keita'),
    ),
    const DropdownMenuItem<int>(
      value: 3,
      child: Text('Stade des Maradas'),
    ),
    const DropdownMenuItem<int>(
      value: 4,
      child: Text('Rue des Potiers'),
    ),
  ];

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _dateController = TextEditingController();
    _timeController = TextEditingController();
    _durationController = TextEditingController();
    _priceController = TextEditingController();
    _locationController = TextEditingController();
    _descriptionController = TextEditingController();
    _maxNbController = TextEditingController();
    _currentParticipantsController = TextEditingController(text: '1');
    _selectedSport = 1;
    _selectedLocation = 1;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _dateController.dispose();
    _timeController.dispose();
    _durationController.dispose();
    _priceController.dispose();
    _locationController.dispose();
    _descriptionController.dispose();
    _maxNbController.dispose();
    _currentParticipantsController.dispose();
    super.dispose();
  }

  void _updateSelectedSport(int? value) {
    setState(() {
      _selectedSport = value!;
    });
  }

  void _updateSelectedLocation(int? value) {
    setState(() {
      _selectedLocation = value!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 32),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    const Text(
                      'Créer un événement',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                TextFormField(
                  controller: _nameController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Ce champ est requis';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    labelText: 'Nom',
                  ),
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<int>(
                  value: _selectedSport,
                  onChanged: _updateSelectedSport,
                  decoration: const InputDecoration(
                    labelText: 'Sport',
                  ),
                  validator: (value) {
                    if (value == null) {
                      return 'Ce champ est requis';
                    }
                    return null;
                  },
                  items: _sportDropdownItems,
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Date',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              DatePicker.showDatePicker(
                                context,
                                onConfirm: (date) {
                                  final formattedDate =
                                      DateFormat('yyyy-MM-dd').format(date);
                                  setState(() {
                                    _dateController.text = formattedDate;
                                  });
                                },
                              );
                            },
                            child: Text(_dateController.text),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Heure',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              DatePicker.showTimePicker(
                                context,
                                showSecondsColumn: false,
                                onConfirm: (time) {
                                  final formattedTime =
                                      DateFormat('HH:mm').format(time);
                                  setState(() {
                                    _timeController.text = formattedTime;
                                  });
                                },
                              );
                            },
                            child: Text(_timeController.text),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _durationController,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Ce champ est requis';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          labelText: 'Durée (en minutes)',
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: TextFormField(
                        controller: _priceController,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Ce champ est requis';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          labelText: 'Prix (en euros)',
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<int>(
                  value: _selectedLocation,
                  onChanged: _updateSelectedLocation,
                  decoration: const InputDecoration(
                    labelText: 'Lieu',
                  ),
                  validator: (value) {
                    if (value == null) {
                      return 'Ce champ est requis';
                    }
                    return null;
                  },
                  items: _locationDropdownItems,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _descriptionController,
                  maxLines: 5,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Ce champ est requis';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    labelText: 'Description',
                  ),
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<int>(
                  value: _level,
                  onChanged: (int? value) {
                    setState(() {
                      _level = value!;
                    });
                  },
                  decoration: const InputDecoration(
                    labelText: 'Niveau',
                  ),
                  validator: (value) {
                    if (value == null) {
                      return 'Ce champ est requis';
                    }
                    return null;
                  },
                  items: const [
                    DropdownMenuItem<int>(
                      value: 1,
                      child: Text('Débutant'),
                    ),
                    DropdownMenuItem<int>(
                      value: 2,
                      child: Text('Intermédiaire'),
                    ),
                    DropdownMenuItem<int>(
                      value: 3,
                      child: Text('Avancé'),
                    ),
                    DropdownMenuItem<int>(
                      value: 4,
                      child: Text('Expert'),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _maxNbController,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Ce champ est requis';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          labelText: 'Nb de personnes max',
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: TextFormField(
                        controller: _currentParticipantsController,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Ce champ est requis';
                          } else if (int.tryParse(value) == null ||
                              int.parse(value) < 1) {
                            return 'Le nombre de participants doit être d\'au moins 1';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          labelText: 'Combien êtes-vous',
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _isPrivate = false;
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              _isPrivate ? Colors.grey[300] : Colors.blueAccent,
                        ),
                        child: const Text('Ouvert à tous'),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _isPrivate = true;
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              _isPrivate ? Colors.blueAccent : Colors.grey[300],
                        ),
                        child: const Text('Privé'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      List<String> sports = [
                        '64185277f92f960c8b1217a1', // Futsal
                        '64185272f92f960c8b12179f', // Football
                        '6418527cf92f960c8b1217a3', // Kayak
                        '641874ffbbd41bbf75ab4575', // Golf
                      ];
                      List<String> locations = [
                        '641858a6bbbca97efed7d411', // Go Park
                        '641858e9bbbca97efed7d413', // Stade Salif Keita
                        '6418590fbbbca97efed7d415', // Stade des Maradas
                        '64185922bbbca97efed7d417', // Rue des Potiers
                      ];
                      Map<String, dynamic> event = {
                        'name': _nameController.text,
                        'date':
                            '${_dateController.text} ${_timeController.text}:00',
                        'duration': int.tryParse(_durationController.text) ?? 0,
                        'price': double.tryParse(_priceController.text)! * 100,
                        'description': _descriptionController.text,
                        'sport': sports[_selectedSport - 1],
                        'level': _level,
                        'max_nb': int.tryParse(_maxNbController.text) ?? 0,
                        'organizer': userId,
                        'participants': [userId],
                        'is_private': _isPrivate,
                        'location': locations[_selectedLocation - 1],
                        'additional_places':
                            _currentParticipantsController.text == '1'
                                ? []
                                : [
                                    {
                                      'participantId': userId,
                                      'nbPlaces': int.tryParse(
                                              _currentParticipantsController
                                                  .text)! -
                                          1
                                    }
                                  ]
                      };
                      dynamic res =
                          await RequestManager(_client).postEvent(event);

                      if (_isPrivate) {
                        // ignore: use_build_context_synchronously
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PrivateEventCodePage(
                              privateCode: res['code'],
                            ),
                          ),
                        );
                      } else {
                        // ignore: use_build_context_synchronously
                        Navigator.pop(context);
                      }
                    }
                  },
                  child: const Text('Valider'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
