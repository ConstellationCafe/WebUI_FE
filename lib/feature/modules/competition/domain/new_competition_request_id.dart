import 'dart:math';

/// 게시 요청 ID(UUID v4 형식). 한 번의 게시 시도를 식별해, 결과를 모르는 실패 뒤
/// 다시 보내도 몇 분 안에는 디스코드에 글이 두 번 올라가지 않게 한다.
String newCompetitionRequestId([Random? random]) {
  final source = random ?? Random.secure();
  final bytes = List<int>.generate(16, (_) => source.nextInt(256));
  bytes[6] = (bytes[6] & 0x0f) | 0x40;
  bytes[8] = (bytes[8] & 0x3f) | 0x80;
  final hex = bytes.map((b) => b.toRadixString(16).padLeft(2, '0')).join();
  return '${hex.substring(0, 8)}-${hex.substring(8, 12)}-'
      '${hex.substring(12, 16)}-${hex.substring(16, 20)}-${hex.substring(20)}';
}
