import 'package:constellation_cafe/feature/profile/domain/entity/point_entity.dart';
import 'package:constellation_cafe/shared/domain/pagination/page_result.dart';

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

/// 저장소가 화면용 컬럼명으로 바꾼 뒤의 포인트 내역.
PageResult<PointEntity> pointResult() {
  final metadata = [
    {'colName': '변동 금액', 'dbName': 'amount'},
    {'colName': '변동 일자', 'dbName': 'at'},
    {'colName': '변동 내용', 'dbName': 'description'},
  ];
  final json = {'amount': 500, 'at': '2026-09-28', 'description': '출석 보상'};
  return PageResult(
    items: [PointEntity.fromJson(metadata, json)],
    metadata: metadata,
    page: 1,
    size: 20,
    totalElements: 1,
    totalPages: 1,
    hasNext: false,
  );
}
