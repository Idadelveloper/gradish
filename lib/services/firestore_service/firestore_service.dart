import 'dart:js_interop';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gradish/models/grade_sheet_model.dart';

import '../../models/class_list_model.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addBasicUserInfo(
      {required User currentUser, String? userName}) async {
    ///Adds user Id, name, bucket Id (will be the userID)

    Map<String, dynamic> data = {
      "name": currentUser.displayName ?? userName,
      "userId": currentUser.uid,
    };
    await _firestore.collection("users").doc(currentUser.uid).set(data);
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getBasicUserInfo(
      {required User currentUser}) async {
    ///Adds user Id, name, bucket Id (will be the userID)

    DocumentSnapshot<Map<String, dynamic>> result =
        await _firestore.collection("users").doc(currentUser.uid).get();
    return result;
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getGradeSheet(
      {required User currentUser}) async {
    return await _firestore
        .collection("users")
        .doc(currentUser.uid)
        .collection("gradeSheet")
        .get();
  }

  Future<void> addGradeSheet(
      {required User currentUser, required GradeSheet gradeSheet}) async {
    await _firestore
        .collection("users")
        .doc(currentUser.uid)
        .collection("gradeSheet")
        .doc()
        .set(gradeSheet.toMap());
  }

  Future<void> updateGradeSheet({
    required User currentUser,
    required GradeSheet newGradeSheet,
  }) async {
    await _firestore
        .collection("users")
        .doc(currentUser.uid)
        .collection("gradeSheet")
        .doc(newGradeSheet.docId)
        .update(newGradeSheet.toMap());
  }

  Future<void> deleteGradeSheet(
      {required User currentUser, required GradeSheet gradeSheet}) async {
    await _firestore
        .collection("users")
        .doc(currentUser.uid)
        .collection("gradeSheet")
        .doc(gradeSheet.docId)
        .delete();
  }

  ///Todo: implement class List addition and updating
}
