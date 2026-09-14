import '../../../data/dto/response/option_response.dart';

import 'academy_option_response.dart';
import 'class_option_response.dart';
import 'subject_option_response.dart';

class TeacherStatusResponse {
  final List<AcademyOptionResponse> academies;
  final List<ClassOptionResponse> classes;
  final List<OptionResponse> teachers;

  const TeacherStatusResponse({
    this.academies = const [],
    this.classes = const [],
    this.teachers = const [],
  });

  factory TeacherStatusResponse.fromJson(
      Map<String, dynamic> json,
      ) {
    return TeacherStatusResponse(
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
      teachers:
        (json['teachers'] as List<dynamic>? ?? [])
        .map(
          (e) => OptionResponse.fromJson(
            e as Map<String, dynamic>,
          ),
        )
        .toList(),
    );
  }
}