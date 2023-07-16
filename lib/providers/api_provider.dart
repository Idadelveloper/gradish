import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:gradish/models/upload_image_model.dart';
import 'package:gradish/repositories/api_repository.dart';
import '../core/enums.dart';
import '../core/failure.dart';

class ApiProvider extends ChangeNotifier {
  final ApiRepository apiRepository;
  AppState state = AppState.initial;
  UploadImageResult uploadedImageResult = UploadImageResult.empty;
  List<UploadImageResult> allUploadedImageResults = [];
  String? errorMessage;

  ApiProvider(this.apiRepository);

  Future<void> uploadImage(Uint8List image) async {
    state = AppState.submitting;
    notifyListeners();

    final Either<Failure, UploadImageResult> response =
        await apiRepository.uploadImage(image);

    response.fold((failure) {
      errorMessage = failure.errorMessage;
      state = AppState.error;
      notifyListeners();
    }, (uploadImageResult) {
      errorMessage = null;
      state = AppState.success;
      uploadedImageResult = uploadImageResult;
      allUploadedImageResults.add(uploadImageResult);
    });
  }
}
