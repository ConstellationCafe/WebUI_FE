import 'package:constellation_cafe/feature/contents/academy/domain/type/academy_role.dart';

class AcademyPermission {
  final bool admin;
  final List<AcademyPermissionItem> academies;

  const AcademyPermission({
    required this.admin,
    required this.academies,
  });

  factory AcademyPermission.initial() {
    return const AcademyPermission(
      admin: false,
      academies: [],
    );
  }

  factory AcademyPermission.fromJson(
      Map<String, dynamic> json,
      ) {
    return AcademyPermission(
      admin: json['admin'] as bool? ?? false,
      academies: (json['academies'] as List<dynamic>? ?? [])
          .map(
            (item) => AcademyPermissionItem.fromJson(
              item as Map<String, dynamic>,
            ),
          )
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'admin': admin,
      'academies': academies
          .map((item) => item.toJson())
          .toList(),
    };
  }

  bool get isAdmin => admin;

  bool isOwner() {
    if (admin) {
      return true;
    }
    return academies.any(
        (academy) =>
            academy.role == AcademyRole.academyOwner,
    );
  }

  bool isOwnerWithAcademy(int academyId) {
    if (admin) {
      return true;
    }

    return academies.any(
        (academy) =>
          academy.academyId == academyId
          && academy.role == AcademyRole.academyOwner,
    );
  }

  bool isTeacherOrAbove() {
    if (admin) {
      return true;
    }

    return academies.any(
          (academy) =>
      academy.role == AcademyRole.academyOwner ||
          academy.role == AcademyRole.teacher,
    );
  }

  bool isTeacherOrAboveWithAcademy(int academyId) {
    if (admin) {
      return true;
    }
    return academies.any(
          (academy) =>
      academy.academyId == academyId &&
          (
              academy.role == AcademyRole.academyOwner ||
                  academy.role == AcademyRole.teacher
          ),
    );
  }

  bool isTeacherOrAboveWithClass(int academyId, int classId) {
    if (admin) {
      return true;
    }
    if (isOwnerWithAcademy(academyId)) {
      return true;
    }
    return academies.any(
          (academy) =>
            academy.academyId == academyId
            && academy.role == AcademyRole.teacher
            && academy.classIds.contains(classId),
    );
  }
}

class AcademyPermissionItem {
  final int academyId;
  final AcademyRole role;
  final List<int> classIds;

  const AcademyPermissionItem({
    required this.academyId,
    required this.role,
    required this.classIds,
  });

  factory AcademyPermissionItem.fromJson(
      Map<String, dynamic> json,
      ) {
    return AcademyPermissionItem(
      academyId: json['academyId'] as int,
      role: AcademyRole.fromApiValue(
        json['role'] as String,
      ),
      classIds: (json['classIds'] as List<dynamic>? ?? [])
          .map((id) => id as int)
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'academyId': academyId,
      'role': role.apiValue,
      'classIds': classIds,
    };
  }
}