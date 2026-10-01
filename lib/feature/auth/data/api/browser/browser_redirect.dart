// flutter.md: platform별 구현은 conditional import로 격리한다.
// 공유 코드는 이 파일만 import하고 package:web을 직접 import하지 않는다.
export 'browser_redirect_stub.dart'
    if (dart.library.js_interop) 'browser_redirect_web.dart';
