import 'package:flutter/material.dart';
import 'package:gradish/core/enums.dart';
import 'package:gradish/models/grade_sheet_model.dart';
import 'package:gradish/providers/api_provider.dart';
import 'package:gradish/providers/firestore_provider.dart';
import 'package:gradish/screens/home_screen.dart';
import 'package:provider/provider.dart';

import '../models/upload_image_model.dart';
import '../providers/auth_provider.dart';

class ExtractDialog extends StatelessWidget {
  const ExtractDialog({
    Key? key,
    required this.result,
    required this.gradeSheet,
  }) : super(key: key);

  final UploadImageResult result;
  final GradeSheet gradeSheet;

  @override
  Widget build(BuildContext context) {
    var dialog = context.widget as ExtractDialog;
    return Consumer3<AuthProvider, FirestoreProvider, ApiProvider>(
        builder: (context, authData, firestoreData, apiData, child) {
      return AlertDialog(
        title: const Text("Text Found"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Coded Number: ${result.codedNumber}"),
            const SizedBox(
              height: 16,
            ),
            Text("Mark: ${result.mark}"),
            const SizedBox(
              height: 16,
            ),
            ElevatedButton(
                onPressed: () async {
                  List<Map<String, dynamic>> gradeSheetData = [];
                  for (UploadImageResult imageResult
                      in apiData.allUploadedImageResults) {
                    Map<String, dynamic> dataEntry = {
                      "codedNumber": imageResult.codedNumber,
                      "mark": imageResult.mark
                    };
                    gradeSheetData.add(dataEntry);
                  }

                  GradeSheet newGradeSheet =
                      gradeSheet.copyWith(data: gradeSheetData);

                  await firestoreData
                      .updateGradeSheet(
                          currentUser: authData.currentUser!,
                          newGradeSheet: newGradeSheet)
                      .whenComplete(() {
                    if (firestoreData.state == AppState.success) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text("Added mark to gradesheet")));
                      Navigator.pop(context, true);
                    } else if (firestoreData.state == AppState.error) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text("Failed to add mark to gradesheet")));
                    }
                  });
                },
                child: const Text("Save")),
            ElevatedButton(
                onPressed: () async {
                  List<Map<String, dynamic>> gradeSheetData = [];
                  for (UploadImageResult imageResult
                      in apiData.allUploadedImageResults) {
                    Map<String, dynamic> dataEntry = {
                      "codedNumber": imageResult.codedNumber,
                      "mark": imageResult.mark
                    };
                    gradeSheetData.add(dataEntry);
                  }

                  GradeSheet newGradeSheet =
                      gradeSheet.copyWith(data: gradeSheetData);

                  await firestoreData
                      .updateGradeSheet(
                          currentUser: authData.currentUser!,
                          newGradeSheet: newGradeSheet)
                      .whenComplete(() {
                    if (firestoreData.state == AppState.success) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text("Added mark to gradesheet")));
                      Navigator.pop(context);
                      showDialog(
                          context: context,
                          builder: (context) {
                            Navigator.popUntil(context, (route) => true);
                            return EndingDialog(
                              gradeSheet: newGradeSheet,
                            );
                          });
                    } else if (firestoreData.state == AppState.error) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text("Failed to add mark to gradesheet")));
                    }
                  });
                },
                child: const Text("Save and Exit"))
          ],
        ),
      );
    });
  }
}

class EndingDialog extends StatelessWidget {
  const EndingDialog(
      {Key? key, required this.gradeSheet})
      : super(key: key);
 // final VoidCallback onPressed;
  final GradeSheet gradeSheet;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Download Gradesheet"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ElevatedButton(
              onPressed: () async {
                await gradeSheet.saveGradeSheetAsSCV().whenComplete(() {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Saved Gradsheet to Documents")));
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => const HomeScreen()),
                          (route) => false);
                });
              },
              child: const Center(
                  child: Text(
                "Download Gradesheet as CSV",
                textAlign: TextAlign.center,
              ))),
          ElevatedButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const HomeScreen()),
                    (route) => false);
              },
              child: const Center(
                  child: Text(
                "Cancel",
                textAlign: TextAlign.center,
              ))),
        ],
      ),
    );
  }
}
