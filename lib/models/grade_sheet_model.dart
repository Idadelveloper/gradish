import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class GradeSheet {
  final String courseName;
  final String courseCode;
  final String year;
  final String semester;
  final String? docId;
  final List<Map<String, dynamic>>? data;

  GradeSheet({
    required this.courseName,
    required this.courseCode,
    required this.year,
    required this.semester,
    this.data,
    this.docId,
  });

  ///-------To and From Map Methods--------///
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      "courseName": courseName,
      "courseCode": courseCode,
      "year": year,
      "semester": semester,
      "data": data,
      "docId": docId,
    };
    return map;
  }

  factory GradeSheet.fromMap(Map<String, dynamic> map) {
    return GradeSheet(
      courseName: map["courseName"],
      courseCode: map["courseCode"],
      data: map["data"],
      year: map["year"],
      semester: map["semester"],
      docId: map["docId"],
    );
  }

  ///--------CopyWith-------///

  GradeSheet copyWith({
    String? courseName,
    String? courseCode,
    String? year,
    String? semester,
    String? docId,
    List<Map<String, dynamic>>? data,
  }) {
    return GradeSheet(
      courseName: courseName ?? this.courseName,
      courseCode: courseCode ?? this.courseCode,
      year: year ?? this.year,
      semester: semester ?? this.semester,
      data: data ?? this.data,
      docId: docId ?? this.docId,
    );



  }

  ///-------Save Gradsheet as CSV-----------////

  Future<void> saveGradeSheetAsSCV()async {

    List<String> marksAsStringList = ["Coded Number, Mark\n"];
    for (Map<String, dynamic> grade in this.data!){

      String dataAsString = "${grade["codedNumber"]} , ${grade["mark"]}\n";
      marksAsStringList.add(dataAsString);
    }
    Directory outPutDir= Directory("/storage/emulated/0/Documents");
    if(Platform.isAndroid){
      outPutDir =  Directory("/storage/emulated/0/Documents");
    } else if(Platform.isIOS){
      outPutDir = await getApplicationDocumentsDirectory();
    }

    String filePath = "${outPutDir.path}/${this.courseName}_${this.year}_semester_${this.semester}.csv";

    final File file = File(filePath);

    ///Check permissions

    Permission storagePermission = Permission.storage;

    if(await storagePermission.isGranted){
      print("permissions is granted");
      await file.writeAsString(marksAsStringList.join());
    } else {
      await storagePermission.request().whenComplete(() async {
        print("requesting permissions");
      await file.writeAsString(marksAsStringList.join());

      });
    }





  }
}
