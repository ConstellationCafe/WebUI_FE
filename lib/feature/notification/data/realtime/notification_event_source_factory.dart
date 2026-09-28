// flutter.md: platform별 구현은 conditional import로 격리한다.
// 공유 코드는 이 파일만 import하고 package:web을 직접 import하지 않는다.
export 'notification_event_source.dart';
export 'notification_event_source_stub.dart'
    if (dart.library.js_interop) 'notification_event_source_web.dart';
