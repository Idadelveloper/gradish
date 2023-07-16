import 'package:flutter/material.dart';
import 'package:gradish/models/grade_sheet_model.dart';
import 'package:gradish/providers/api_provider.dart';
import 'package:gradish/providers/firestore_provider.dart';
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
        title: Text("Text Found"),
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

                  await firestoreData.updateGradeSheet(
                      currentUser: authData.currentUser!,
                      newGradeSheet: newGradeSheet);
                },
                child: const Text("Save"))
          ],
        ),
      );
    });
  }
}
