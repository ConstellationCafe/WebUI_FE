Map<String, dynamic> memberJson(String sk, String name, {String? state}) => {
  'sk': sk,
  'discordID': 'd$sk',
  'name': name,
  'state': state ?? '재적',
  'profileImageUrl': null,
};

Map<String, dynamic> academyJson({int id = 1, String name = '별빛 아카데미'}) => {
  'id': id,
  'name': name,
};

Map<String, dynamic> classJson(int id, {String state = '운영'}) => {
  'id': id,
  'classNumber': '$id',
  'state': state,
};

Map<String, dynamic> subjectJson() => {'id': 5, 'name': '덱 빌딩'};

Map<String, dynamic> studentOptions() {
  return {
    'academies': [academyJson()],
    'classes': [classJson(1)],
    'students': [memberJson('s1', '김별')],
    'subjects': [subjectJson()],
  };
}

Map<String, dynamic> statusItemJson(
  Map<String, dynamic> member,
  String status, {
  String? reason,
}) => {
  'academyMember': member,
  'academy': academyJson(),
  'academyClass': classJson(1),
  'status': status,
  'statusChangedAt': '2026-09-01T03:00:00Z',
  'reason': reason,
};

Map<String, dynamic> studentStatusPage() {
  final items = [
    statusItemJson(memberJson('s1', '김별'), 'GRADUATED', reason: '과정 수료'),
    statusItemJson(memberJson('s2', '이달'), 'ENROLLED'),
  ];
  final summary = {
    'totalCount': 2,
    'enrolledCount': 1,
    'graduationCount': 1,
    'expulsionCount': 0,
    'withdrawalCount': 0,
  };
  final pagination = {
    'currentPage': 1,
    'pageSize': 20,
    'totalPages': 1,
    'totalCount': 2,
  };
  return {'items': items, 'summary': summary, 'pagination': pagination};
}

Map<String, dynamic> teacherStatusPage() {
  final items = [
    statusItemJson(memberJson('t1', '박해'), 'DISCIPLINARY', reason: '지각'),
  ];
  final summary = {
    'totalCount': 1,
    'enrolledCount': 0,
    'retirementCount': 0,
    'disciplinaryCount': 1,
  };
  final pagination = {
    'currentPage': 2,
    'pageSize': 20,
    'totalPages': 3,
    'totalCount': 41,
  };
  return {'items': items, 'summary': summary, 'pagination': pagination};
}

Map<String, dynamic> lessonRecordJson({bool canModify = true}) => {
  'id': 10,
  'academyName': '별빛 아카데미',
  'className': '1',
  'subject': '덱 빌딩',
  'educationDate': '2026-09-27',
  'startTime': '19:00:00',
  'endTime': '20:30:00',
  'educationDuration': 90,
  'mainTeacherName': '박해',
  'description': '',
  'memberCount': 4,
  'canModify': canModify,
};

Map<String, dynamic> permissionJson({
  bool admin = false,
  String role = 'TEACHER',
  List<int> classIds = const [1],
}) {
  final academy = {'academyId': 1, 'role': role, 'classIds': classIds};
  return {
    'admin': admin,
    'academies': [academy],
  };
}
