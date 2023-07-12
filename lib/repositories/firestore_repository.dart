import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:googleapis/forms/v1.dart';
import 'package:gradish/services/firestore_service/firestore_service.dart';

import '../core/failure.dart';
import '../models/grade_sheet_model.dart';

class FirestoreRepository {
  final FirestoreService _firestoreService;

  FirestoreRepository(this._firestoreService);

  Future<Either<Failure, void>> addBasicUserInfo({required User currentUser, String? name}) async {
    try {
      await _firestoreService.addBasicUserInfo(currentUser: currentUser, userName: name);
      return const Right(null);
    } on FirebaseException catch (e) {
      return Left(Failure(errorMessage: e.message));
    } catch (e) {
      return Left(Failure());
    }
  }

  Future<Either<Failure, void>> getBasicUserInfo(User currentUser) async {
    try {
      await _firestoreService.getBasicUserInfo(currentUser: currentUser);
      return const Right(null);
    } on FirebaseException catch (e) {
      return Left(Failure(errorMessage: e.message));
    } catch (e) {
      return Left(Failure());
    }
  }

  Future<Either<Failure, void>> addGradeSheet(
      {required User currentUser, required GradeSheet gradeSheet}) async {
    try {
      await _firestoreService.addGradeSheet(
          currentUser: currentUser, gradeSheet: gradeSheet);
      return const Right(null);
    } on FirebaseException catch (e) {
      return Left(Failure(errorMessage: e.message));
    } catch (e) {
      return Left(Failure());
    }
  }

  Future<Either<Failure, List<GradeSheet>>> getGradeSheet(
      User currentUser) async {
    List<GradeSheet> gradeSheets = [];
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await _firestoreService.getGradeSheet(currentUser: currentUser);

      List<QueryDocumentSnapshot<Map<String, dynamic>>> snapshotList =
          querySnapshot.docs;

      for (QueryDocumentSnapshot doc in snapshotList) {
        GradeSheet gradeSheet =
            GradeSheet.fromMap(doc.data() as Map<String, dynamic>);
        gradeSheets.add(gradeSheet);
      }

      return Right(gradeSheets);
    } on FirebaseException catch (e) {
      return Left(Failure(errorMessage: e.message));
    } catch (e) {
      return Left(Failure());
    }
  }

  Future<Either<Failure, void>> updateGradeSheet({
    required User currentUser,
    required GradeSheet newGradeSheet,
  }) async {
    try {
      await _firestoreService.updateGradeSheet(
        currentUser: currentUser,
        newGradeSheet: newGradeSheet,
      );
      return const Right(null);
    } on FirebaseException catch (e) {
      return Left(Failure(errorMessage: e.message));
    } catch (e) {
      return Left(Failure());
    }
  }

  Future<Either<Failure, void>> deleteGradeSheet(
      {required User currentUser, required GradeSheet gradeSheet}) async {
    try {
      await _firestoreService.deleteGradeSheet(
          currentUser: currentUser, gradeSheet: gradeSheet);
      return const Right(null);
    } on FirebaseException catch (e) {
      return Left(Failure(errorMessage: e.message));
    } catch (e) {
      return Left(Failure());
    }
  }
}
