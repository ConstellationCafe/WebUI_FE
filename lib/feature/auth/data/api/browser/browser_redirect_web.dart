import 'package:web/web.dart' as web;

/// 현재 브라우저 페이지를 [uri]로 바꾼다.
void redirectCurrentPage(Uri uri) {
  web.window.location.href = uri.toString();
}
