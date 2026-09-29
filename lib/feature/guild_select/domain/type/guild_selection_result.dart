/// 채팅방 선택 결과.
enum GuildSelectionResult {
  /// 서버가 선택을 받아들였고 로그인 재확인까지 끝났다.
  selected,

  /// 등록되지 않았거나 멤버가 아닌 방이라 선택할 수 없다.
  rejected,

  /// 선택은 됐지만 로그인 재확인에서 채팅방 선택 상태를 확인하지 못했다.
  checkFailed,
}
