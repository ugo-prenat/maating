import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:maating/widgets/sourceAvatar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';

class SelectAvatar extends StatefulWidget {
  const SelectAvatar({super.key});

  @override
  State<SelectAvatar> createState() => _SelectAvatarState();
}

class _SelectAvatarState extends State<SelectAvatar> {

  final _formKey = GlobalKey<FormState>();

  var profilImgController = TextEditingController();

  XFile? _image;

  final ImagePicker picker = ImagePicker();

  getImage(ImageSource media) async {
    var img = await picker.pickImage(source: media);
    if(img == null) return;

    XFile? image = XFile(img.path);

    image = await cropImage(imageFile: image);

    setState(() {
      _image = img;
    });
  }

  cropImage({required XFile imageFile}) async {
      CroppedFile? croppedImage = await ImageCropper().cropImage(
          sourcePath: imageFile.path,
          uiSettings: [
            AndroidUiSettings(
              toolbarTitle: 'Modifier l\'image',
              toolbarColor: const Color(0xFF2196F3),
              toolbarWidgetColor: Colors.white,
              activeControlsWidgetColor: const Color(0xFF2196F3),
            ),
            IOSUiSettings(
              title: 'Modifier l\'image'
            )
          ]
      );
      if(croppedImage == null) return null;
      return XFile(croppedImage.path);
  }

  void chooseImageSource() {
    showGeneralDialog(
        context: context,
        pageBuilder: (ctx, a1, a2) {
          return Container();
        },
      transitionBuilder: (ctx, a1, a2, child) {
        var curve = Curves.easeInOut.transform(a1.value);
        return Transform.scale(
          scale: curve,
          child: SourceAvatar(onTakingImage: (ImageSource media) {
            getImage(media);
          })
        );
      },
      transitionDuration: const Duration(milliseconds: 300),
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
                padding: const EdgeInsets.only(bottom: 50),
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
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _image != null
                        ? ClipRRect(
                              borderRadius: BorderRadius.circular(100.0),
                                child: Image.file(
                                  File(_image!.path),
                                  fit: BoxFit.cover,
                                  width: 200,
                                  height: 200,
                                ),
                      ) : TextButton(
                            onPressed: () {
                              chooseImageSource();
                            },
                            style: TextButton.styleFrom(
                            fixedSize: const Size(140, 140),
                            side: const BorderSide(
                              width: 2,
                              color: Colors.blue,
                          ),
                        ),
                          child: const Icon(Icons.add),
                      ),
                    const Padding(
                      padding: EdgeInsets.only(top: 30, bottom: 50),
                      child: Text(
                        'Sélectionnez un avatar',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 140),
                      child: ElevatedButton(
                          onPressed: () async {
                            if(_formKey.currentState!.validate()) {
                              Navigator.pushNamed(context, '/register_sports');
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
