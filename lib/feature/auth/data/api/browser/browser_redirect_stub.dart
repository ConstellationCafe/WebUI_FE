/// Web이 아닌 platform에서는 현재 페이지를 바꿀 수 없다. [kIsWeb]일 때만 호출한다.
void redirectCurrentPage(Uri uri) {
  throw UnsupportedError('현재 페이지 이동은 Web에서만 지원합니다.');
}
