import 'dart:io';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gradish/components/popup.dart';
import 'package:gradish/services/api_service/api_service.dart';
import 'package:path/path.dart';

class SelectedImage extends StatefulWidget {
  const SelectedImage({Key? key, required this.image}) : super(key: key);

  final File image;

  @override
  State<SelectedImage> createState() => _SelectedImageState();
}

class _SelectedImageState extends State<SelectedImage> {
  final APIService apiService = APIService();




  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
          children: [
            Container(
              child: Image.file(widget.image),
            ),
            Row(
              children: [
                ElevatedButton(onPressed: () {}, child: const Text("Cancel")),
                ElevatedButton(onPressed: () async {
                  var results = await apiService.post(widget.image.readAsBytesSync());
                  results.fold((l) => {

                  }, (right) => {
                    showDialog(context: context, builder: (context) {
                      return ExtractDialog(
                          codedNumber: right["detected"]["coded number"],
                          mark: right["detected"]["mark"]
                      );
                    })
                  });


                  
                  // print(result);

                }, child: const Text("Continue"))
              ],
            )
          ],
        ),
    );
  }
}
