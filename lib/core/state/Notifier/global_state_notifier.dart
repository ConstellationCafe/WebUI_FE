import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:constellation_cafe/data/api/auth/Login.dart';
import '../State/global_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:constellation_cafe/core/di/ApiProvider.dart'; // 기존 경로 유지

part 'global_state_notifier.g.dart';

@riverpod
class GlobalStateNotifier extends _$GlobalStateNotifier {
  bool _isInitialized = false;

  @override
  GlobalState build() {
    return GlobalState.initial();
  }

  /// 초기화: 로그인 이후 명시적으로 호출
  Future<void> initialize() async {
    if (!_isInitialized) {
      final loginApi = ref.read(loginApiProvider);
      final me = await loginApi.me();

      if (me.response != null) {
        state = GlobalState.fromJson(me.response!);
        _isInitialized = true;
      }
    }
  }

  /// 상태 업데이트
  void update({
    String? userId,
    String? globalName,
    List<String>? roles,
    String? avatarUrl,
  }) {
    state = state.copyWith(
      userId: userId ?? state.userId,
      globalName: globalName ?? state.globalName,
      roles: roles ?? state.roles,
      avatarUrl: avatarUrl ?? state.avatarUrl,
    );
  }

  /// JSON으로부터 직접 세팅
  void setFromJson(Map<String, dynamic> json) {
    state = GlobalState.fromJson(json);
    _isInitialized = true;
  }

  /// 상태를 JSON으로 변환
  Map<String, dynamic> toJson() => state.toJson();

  /// 초기화
  void clear() {
    state = GlobalState.initial();
    _isInitialized = false;
  }
}