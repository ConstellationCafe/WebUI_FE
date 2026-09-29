/// 임시 연동 키 발급 화면(개발 중)의 사용자 노출 문자열.
abstract final class LinkKeyStrings {
  static const topBarTitle = '임시 연동 키 발급';
  static const linkStatusLoginRequired = '연동 상태: 로그인 필요';
  static const kakaoLogin = '카카오로 로그인';
  static const title = '1분 유효한 임시 연동 키';
  static const description = '웹에서 키를 발급하고 카카오톡에서 입력하면 봇이 연결됩니다.';
  static const keyLabel = '연동 키';
  static const copy = '복사';
  static const copied = '연동 키를 복사했어요.';
  static const issue = '키 발급';
  static const reissueOverwrite = '새 키 발급(덮어쓰기)';
  static const reissue = '재발급';
  static const securityNotice = '보안 안내: 키는 1분 후 만료되며, 1회만 연결에 사용됩니다.';
  static const untilExpiry = '만료까지';
  static const emptyTimer = '--:--';
  static const emptyCode = '— — — — — —';
  static const qrTitle = 'QR로 입력하기(선택)';
  static const qrPlaceholder = 'QR 영역';
  static const kakaoInputTitle = '카카오톡에서 이렇게 입력';
  static const kakaoInputGuide =
      '봇 채팅방에서\n/link 123456\n처럼 입력하면 연결됩니다.\n연결 완료 시 상태가 “연동됨”으로 바뀝니다.';
  static const step1Title = '카카오 로그인';
  static const step1Description = '본인 계정으로 로그인해요.';
  static const step2Title = '키 발급';
  static const step2Description = '버튼을 눌러 1분짜리 키를 생성해요.';
  static const step3Title = '카카오톡에 입력';
  static const step3Description = '봇 대화창에 /link 6자리코드를 입력해요.';

  static String reissueAfter(String remaining) => '재발급($remaining 후)';
}
