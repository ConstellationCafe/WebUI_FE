Map<String, dynamic> column(String name, {int isPrimary = 0}) => {
  'colName': name,
  'isPrimary': isPrimary,
  'isNullable': 0,
};

/// 추천 저장소 목록 응답. [dbColumn]은 DB 컬럼, [field]는 엔티티 필드다.
Map<String, dynamic> recommendPage(String dbColumn, String field) {
  final metadata = [column(dbColumn, isPrimary: 1), column('recommender')];
  final entities = [
    {field: '추천 값', 'recommender': '900'},
  ];
  return {
    'metadata': metadata,
    'entities': entities,
    'page': 1,
    'size': 20,
    'totalElements': 1,
    'totalPages': 1,
    'hasNext': false,
  };
}

Map<String, dynamic> learningPage() {
  final metadata = [
    column('ln_key', isPrimary: 1),
    column('ln_value'),
    column('teacher'),
  ];
  final entities = [
    {'lnKey': '안녕', 'lnValue': '반가워', 'teacher': '900'},
  ];
  return {
    'metadata': metadata,
    'entities': entities,
    'page': 1,
    'size': 20,
    'totalElements': 30,
    'totalPages': 2,
    'hasNext': true,
  };
}
