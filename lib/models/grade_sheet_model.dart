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
    );
  }
}
