import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:gradish/models/upload_image_model.dart';

import '.env.dart';

const String uploadEndpoint = "/upload";

class APIService {
  final Dio _dio =
      Dio(BaseOptions(baseUrl: baseUrl, responseType: ResponseType.json));

  Future<UploadImageResult> uploadImage(Uint8List image) async {
    final Response response = await _dio.post(uploadEndpoint,
        data: image, options: Options(contentType: Headers.jsonContentType));
    // final responseData = json.decode(response.data);
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseJson = response.data;

      return UploadImageResult.fromJson(responseJson);
    } else {
      DioException dioException = DioException(
          requestOptions: RequestOptions(path: "$baseUrl$uploadEndpoint"));
      throw dioException;
    }
  }
}

// class APIService<T, U>  {
//   final url = "https://gradish.nw.r.appspot.com/upload";
//   final dio = Dio();
//
//   Future<T?> post(U? data) async {
//     final Response<T> response = await dio.post(
//         url,
//         data: data,
//         options: Options(contentType: Headers.jsonContentType)
//     );
//
//     print(response.data);
//     return response.data;
//   }
//
//
// }

// class APIService {
//   Dio _dio;
//   final baseUrl = "https://gradish.nw.r.appspot.com/upload";
//
//   APIService() {
//     _dio = Dio(BaseOptions(
//       baseUrl: baseUrl,
//     ));
//   }
//
//
// }
