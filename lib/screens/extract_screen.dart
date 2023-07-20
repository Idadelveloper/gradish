import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gradish/models/grade_sheet_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../components/popup.dart';
import '../core/enums.dart';
import '../providers/api_provider.dart';

class ExtractScreen extends StatefulWidget {
  const ExtractScreen({Key? key, required this.gradeSheet}) : super(key: key);
  final GradeSheet gradeSheet;

  @override
  State<ExtractScreen> createState() => _ExtractScreenState();
}

class _ExtractScreenState extends State<ExtractScreen> {
  File? _image;
  //
  final imagePicker = ImagePicker();
  // final dio = Dio();

  // void getHttp() async {
  //   final response = await dio.get('https://dart.dev');
  //   print(response);
  // }

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

      Uint8List? imageBytes = await _image?.readAsBytes();
      // String? encodedImage =  base64Encode(imageBytes!.toList());
      // print(encodedImage);
    } on PlatformException catch (e) {
      print("Failed to pick image: $e");
    }
  }
  // Image.file(_image!)

  @override
  Widget build(BuildContext context) {
    return Consumer<ApiProvider>(
      builder: (context, apiData, child) {
        return Scaffold(
          appBar: AppBar(),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 32,
                  ),
                  if (_image == null) Center(child: const Text("Select an image")) else Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(32),
                              child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(32),
                                  ),
                                  width: double.infinity,
                                  height:
                                      MediaQuery.of(context).size.height * .6,
                                  child: Image.file(
                                    _image!,
                                    fit: BoxFit.cover,
                                  )),
                            ),
                            SizedBox(
                              height: 32,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                    onPressed: () {},
                                    child: const Text("Cancel")),
                                const SizedBox(width: 16),
                                ElevatedButton(
                                    onPressed: () async {
                                      Uint8List? imageBytes =
                                          await _image?.readAsBytes();

                                      if (imageBytes != null) {
                                        await apiData
                                            .uploadImage(imageBytes)
                                            .then((value) async {
                                          if (apiData.state == AppState.error) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                                    content: Text(apiData
                                                            .errorMessage ??
                                                        "An error occurred")));
                                          } else if (apiData.state ==
                                              AppState.success) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(const SnackBar(
                                                    content: Text("Success")));

                                            ///Shows the dialog
                                         showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return ExtractDialog(
                                                    gradeSheet:
                                                        widget.gradeSheet,
                                                    result: apiData
                                                        .uploadedImageResult,
                                                  );
                                                }).whenComplete(() {
                                                  setState(() {
                                                    _image = null;
                                                  });
                                         }
                                         );


                                          }
                                        });
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                                content: Text(
                                                    "Please select an image")));
                                      }

                                      // print(result);
                                    },
                                    child: const Text("Continue"))
                              ],
                            ),
                          ],
                        ),
                ],
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.yellow,
            onPressed: getImage,
            child: const Icon(Icons.camera_alt),
          ),
        );
      },
    );
  }
}
