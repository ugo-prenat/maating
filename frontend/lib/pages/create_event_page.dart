import 'package:flutter/material.dart';
import 'package:maating/models/event.dart';
import 'package:maating/models/location.dart';
import 'package:maating/models/sport.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:maating/services/requestManager.dart';


class CreateEventPage extends StatefulWidget {
  const CreateEventPage({Key? key}) : super(key: key);

  @override
  State<CreateEventPage> createState() => _CreateEventPageState();
}

class _CreateEventPageState extends State<CreateEventPage> {
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

  bool _isPrivate = false;
  int _level = 0;

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
    _currentParticipantsController = TextEditingController();
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
                const Text(
                  'Créer un événement',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
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
                                  final formattedDate = DateFormat('yyyy-MM-dd')
                                      .format(date);
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
                                  final formattedTime = DateFormat('HH:mm')
                                      .format(time);
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
                TextFormField(
                  controller: _locationController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Ce champ est requis';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    labelText: 'Lieu',
                  ),
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
                      value: 0,
                      child: Text('Débutant'),
                    ),
                    DropdownMenuItem<int>(
                      value: 1,
                      child: Text('Intermédiaire'),
                    ),
                    DropdownMenuItem<int>(
                      value: 2,
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
                          primary:
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
                          primary:
                          _isPrivate ? Colors.blueAccent : Colors.grey[300],
                        ),
                        child: const Text('Privé'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      final event = Event(
                        _nameController.text,
                        '${_dateController.text} ${_timeController.text}:00',
                        int.tryParse(_durationController.text) ?? 0,
                        double.tryParse(_priceController.text) ?? 0.0,
                        _descriptionController.text,
                        Sport('63bda459ce76925f19d55157','Football'),
                        _level,
                        int.tryParse(_maxNbController.text) ?? 0,
                        {'_id': '641852e4f92f960c8b1217a8'},
                        [],
                        _isPrivate,
                        Location('Position Test', _locationController.text, '', LoctSchema('Point', [2.079929589643183,
                          49.045775173520546])
                        ),
                      );
                      print(event.toMap());
                      postEvent(event);
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