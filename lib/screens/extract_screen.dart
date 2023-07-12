import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:image_picker/image_picker.dart';

class ExtractScreen extends StatefulWidget {
  const ExtractScreen({Key? key}) : super(key: key);

  @override
  State<ExtractScreen> createState() => _ExtractScreenState();
}

class _ExtractScreenState extends State<ExtractScreen> {
  File? _image;


  final imagePicker = ImagePicker();

  Future getImage() async {


    try {
      final image = await imagePicker.pickImage(source: ImageSource.camera);
      if (image == null) return;
      // setState(() {
      //   _image = dartio.File(image.path);
      // });

      final imageTemporary = File(image.path);
      setState(() {
        _image = imageTemporary;

      });

      Uint8List? imageBytes = await  _image?.readAsBytes();
      // String? encodedImage =  base64Encode(imageBytes!.toList());
      // print(encodedImage);
    } on PlatformException catch (e) {
      print("Failed to pick image: $e");
    }


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _image == null ? const Text("No image Selected") : Image.file(_image!),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.yellow,
        onPressed: getImage,
        child: const Icon(Icons.camera_alt),
      ),
    );
  }
}
