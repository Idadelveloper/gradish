import 'dart:convert';
import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class APIService  {
  final url = "https://gradish.nw.r.appspot.com/upload";
  final dio = Dio();

  Future<Either<String, dynamic>> post(data) async {
    final Response response = await dio.post(
      url,
      data: data,
      options: Options(contentType: Headers.jsonContentType)
    );
    final responseData = json.decode(response.data);


    print(responseData["coded number"]);
    return Right(response.data);
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