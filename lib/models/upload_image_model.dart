import 'dart:typed_data';

class UploadImageResult {
  final String codedNumber;
  final String mark;
  final Uint8List? image;

  UploadImageResult(
      {required this.codedNumber, required this.mark, this.image});

  factory UploadImageResult.fromJson(Map<String, dynamic> json) {
    return UploadImageResult(
        codedNumber: json["detected"]["coded number"],
        mark: json["detected"]["mark"]);
  }

  static UploadImageResult empty = UploadImageResult(codedNumber: "", mark: "");
  bool get isEmpty => this == UploadImageResult.empty;
  bool get isNotEmpty => this != UploadImageResult.empty;
}
