import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:gradish/core/failure.dart';
import 'package:gradish/models/upload_image_model.dart';
import 'package:gradish/services/api_service/api_service.dart';

class ApiRepository {
  final APIService apiService;

  ApiRepository(this.apiService);

  Future<Either<Failure, UploadImageResult>> uploadImage(
      Uint8List image) async {
    try {
      final UploadImageResult result = await apiService.uploadImage(image);
      return Right(result);
    } on DioException catch (e) {
      return Left(Failure(errorMessage: e.message));
    } catch (e) {
      return Left(Failure());
    }
  }
}
