/// 벌점 이력 정렬 기준. 값은 Backend API의 `sort` query 계약과 같다.
class PenaltyHistorySort {
  static const newest = 'OCCURRED_AT_DESC';
  static const oldest = 'OCCURRED_AT_ASC';
}
