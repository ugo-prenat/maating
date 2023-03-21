import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class SourceAvatar extends StatefulWidget {
  const SourceAvatar({super.key, required this.onTakingImage});

  final Function(ImageSource) onTakingImage;

  @override
  State<SourceAvatar> createState() => _SourceAvatarState();
}

class _SourceAvatarState extends State<SourceAvatar> {

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      title: const Text(
          'Sélectionnez une image depuis votre galerie ou prenez une photo.',
      ),
      content: SizedBox(
        height: MediaQuery.of(context).size.height / 7,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  widget.onTakingImage(ImageSource.gallery);
                },
                style: ElevatedButton.styleFrom(
                    fixedSize: const Size(150, 50)
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.image),
                    Text('Galerie'),
                  ],
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                widget.onTakingImage(ImageSource.camera);
              },
              style: ElevatedButton.styleFrom(
                fixedSize: const Size(150, 50)
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
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
}
