class StudentStatusResponse {
  final List<AcademyOptionResponse> academies;
  final List<ClassOptionResponse> classes;
  final List<StudentOptionResponse> students;
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
      academies: (json['academies'] as List<dynamic>? ?? [])
          .map(
            (e) => AcademyOptionResponse.fromJson(
          e as Map<String, dynamic>,
        ),
      )
          .toList(),
      classes: (json['classes'] as List<dynamic>? ?? [])
          .map(
            (e) => ClassOptionResponse.fromJson(
          e as Map<String, dynamic>,
        ),
      )
          .toList(),
      students: (json['students'] as List<dynamic>? ?? [])
          .map(
            (e) => StudentOptionResponse.fromJson(
          e as Map<String, dynamic>,
        ),
      )
          .toList(),
      subjects: (json['subjects'] as List<dynamic>? ?? [])
          .map(
            (e) => SubjectOptionResponse.fromJson(
          e as Map<String, dynamic>,
        ),
      )
          .toList(),
    );
  }
}

class AcademyOptionResponse {
  final String id;
  final String name;

  const AcademyOptionResponse({
    required this.id,
    required this.name,
  });

  factory AcademyOptionResponse.fromJson(
      Map<String, dynamic> json,
      ) {
    return AcademyOptionResponse(
      id: json['id'].toString(),
      name: json['name'] as String,
    );
  }
}

class ClassOptionResponse {
  final String name;

  const ClassOptionResponse({
    required this.name,
  });

  factory ClassOptionResponse.fromJson(
      Map<String, dynamic> json,
      ) {
    return ClassOptionResponse(
      name: json['name'] as String,
    );
  }
}

class StudentOptionResponse {
  final String id;
  final String name;

  const StudentOptionResponse({
    required this.id,
    required this.name,
  });

  factory StudentOptionResponse.fromJson(
      Map<String, dynamic> json,
      ) {
    return StudentOptionResponse(
      id: json['id'].toString(),
      name: json['name'] as String,
    );
  }
}

class SubjectOptionResponse {
  final String id;
  final String name;

  const SubjectOptionResponse({
    required this.id,
    required this.name,
  });

  factory SubjectOptionResponse.fromJson(
      Map<String, dynamic> json,
      ) {
    return SubjectOptionResponse(
      id: json['id'].toString(),
      name: json['name'] as String,
    );
  }
}