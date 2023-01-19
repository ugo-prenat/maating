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
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      title: const Text('Sélectionnez une image depuis votre galerie ou prenez une photo.'),
      content: Container(
        height: MediaQuery.of(context).size.height / 6,
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                widget.onTakingImage(ImageSource.gallery);
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
                widget.onTakingImage(ImageSource.camera);
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
}
