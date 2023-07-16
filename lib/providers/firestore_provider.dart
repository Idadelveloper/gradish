import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:gradish/repositories/firestore_repository.dart';

import '../core/enums.dart';
import '../core/failure.dart';
import '../models/grade_sheet_model.dart';

class FirestoreProvider extends ChangeNotifier {
  final FirestoreRepository _firestoreRepository;

  AppState state = AppState.initial;
  String? errorMessage;
  List<GradeSheet> gradeSheets = [];

  FirestoreProvider(this._firestoreRepository);

  Future<void> addBasicUserInfo(
      {required User currentUser, String? name}) async {
    state = AppState.submitting;
    notifyListeners();

    Either<Failure, void> response = await _firestoreRepository
        .addBasicUserInfo(currentUser: currentUser, name: name);
    response.fold((failure) {
      errorMessage = failure.errorMessage;
      state = AppState.error;
      notifyListeners();
    }, (success) {
      errorMessage = null;
      state = AppState.success;
      notifyListeners();
    });
  }

  Future<void> getBasicUserInfo(User currentUser) async {
    state = AppState.submitting;
    notifyListeners();

    Either<Failure, void> response =
        await _firestoreRepository.getBasicUserInfo(currentUser);
    response.fold((failure) {
      errorMessage = failure.errorMessage;
      state = AppState.error;
      notifyListeners();
    }, (success) {
      errorMessage = null;
      state = AppState.success;

      notifyListeners();
    });
  }

  Future<void> addGradeSheet(
      {required User currentUser, required GradeSheet gradeSheet}) async {
    state = AppState.submitting;
    notifyListeners();

    Either<Failure, String> response = await _firestoreRepository.addGradeSheet(
        currentUser: currentUser, gradeSheet: gradeSheet);
    response.fold((failure) {
      errorMessage = failure.errorMessage;
      state = AppState.error;
      notifyListeners();
    }, (docId) {
      errorMessage = null;
      state = AppState.success;
      gradeSheets.add(gradeSheet.copyWith(docId: docId));
      notifyListeners();
    });
  }

  Future<void> getGradeSheets(User currentUser) async {
    state = AppState.submitting;
    notifyListeners();

    Either<Failure, List<GradeSheet>> response =
        await _firestoreRepository.getGradeSheet(currentUser);
    response.fold((failure) {
      errorMessage = failure.errorMessage;
      state = AppState.error;
      notifyListeners();
    }, (gottenGradeSheets) {
      errorMessage = null;
      state = AppState.success;
      gradeSheets = gottenGradeSheets;
      notifyListeners();
    });
  }

  Future<void> updateGradeSheet(
      {required User currentUser, required GradeSheet newGradeSheet}) async {
    state = AppState.submitting;
    notifyListeners();

    Either<Failure, void> response =
        await _firestoreRepository.updateGradeSheet(
            currentUser: currentUser, newGradeSheet: newGradeSheet);
    response.fold((failure) {
      errorMessage = failure.errorMessage;
      state = AppState.error;
      notifyListeners();
    }, (success) {
      errorMessage = null;
      state = AppState.success;
      notifyListeners();
    });
  }

  Future<void> deleteGradeSheet(
      {required User currentUser, required GradeSheet gradeSheet}) async {
    state = AppState.submitting;
    notifyListeners();

    Either<Failure, void> response = await _firestoreRepository
        .deleteGradeSheet(currentUser: currentUser, gradeSheet: gradeSheet);
    response.fold((failure) {
      errorMessage = failure.errorMessage;
      state = AppState.error;
      notifyListeners();
    }, (success) {
      errorMessage = null;
      state = AppState.success;
      notifyListeners();
    });
  }
}
