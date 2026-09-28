const createCardPath = '/ConstellationAPI/MembershipAPI/create_card';

/// 봇의 create_card 응답. 순서는 MembershipState.fromList와 같다.
Map<String, dynamic> cardPayload() {
  final result = [
    '별',
    '111111111',
    '',
    '운영진',
    '1200',
    '2025 시즌 우승',
    '',
    '은하수',
    '2026-01-01',
  ];
  return {
    'payload': {'result': result},
  };
}

Map<String, dynamic> pointPage() {
  final metadata = [
    {'colName': 'amount', 'isPrimary': 0, 'isNullable': 0},
    {'colName': 'at', 'isPrimary': 0, 'isNullable': 0},
    {'colName': 'description', 'isPrimary': 0, 'isNullable': 1},
  ];
  final entities = [
    {'amount': 500, 'at': '2026-09-28', 'description': '출석 보상'},
  ];
  return {
    'metadata': metadata,
    'entities': entities,
    'page': 1,
    'size': 20,
    'totalElements': 21,
    'totalPages': 2,
    'hasNext': true,
  };
}
