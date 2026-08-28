import '../../../data/dto/response/option_response.dart';

import 'academy_option_response.dart';
import 'class_option_response.dart';
import 'subject_option_response.dart';

class StudentStatusResponse {
  final List<AcademyOptionResponse> academies;
  final List<ClassOptionResponse> classes;
  final List<OptionResponse> students;
  final List<SubjectOptionResponse> subjects;

  const StudentStatusResponse({
    this.academies = const [],
    this.classes = const [],
    this.students = const [],
    this.subjects = const [],
  });

  factory StudentStatusResponse.fromJson(
      Map<String, dynamic> json,
      ) {
    return StudentStatusResponse(
      academies:
      (json['academies'] as List<dynamic>? ?? [])
          .map(
            (e) => AcademyOptionResponse.fromJson(
          e as Map<String, dynamic>,
        ),
      )
          .toList(),
      classes:
      (json['classes'] as List<dynamic>? ?? [])
          .map(
            (e) => ClassOptionResponse.fromJson(
          e as Map<String, dynamic>,
        ),
      )
          .toList(),
      students:
      (json['students'] as List<dynamic>? ?? [])
          .map(
            (e) => OptionResponse.fromJson(
          e as Map<String, dynamic>,
        ),
      )
          .toList(),
      subjects:
      (json['subjects'] as List<dynamic>? ?? [])
          .map(
            (e) => SubjectOptionResponse.fromJson(
          e as Map<String, dynamic>,
        ),
      )
          .toList(),
    );
  }
}