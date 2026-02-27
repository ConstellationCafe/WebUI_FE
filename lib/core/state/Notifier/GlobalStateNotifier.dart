

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:constellation_cafe/data/api/auth/Login.dart';
import '../State/GlobalState.dart';


class GlobalStateNotifier extends StateNotifier<GlobalState> {
  final Login loginApi;
  bool _isInitialized = false;

  GlobalStateNotifier(this.loginApi) : super(GlobalState.initial());

  Future<void> initialize() async {
    if (!_isInitialized) {
      final me = await loginApi.me();
      state = GlobalState.fromJson(me.response);
      _isInitialized = true;
    }
  }

  /// 상태 업데이트
  void update({
    String? userId,
    List<String>? roles,
    String? avatarUrl
  }) {
    state = state.copyWith(
      userId: userId ?? state.userId,
      roles: roles ?? state.roles,
      avatarUrl: avatarUrl ?? state.avatarUrl
    );
  }

  void clear() {
    GlobalState.initial();
  }

  /// JSON으로부터 상태 세팅
  void setFromJson(Map<String, dynamic> json) {
    state = GlobalState.fromJson(json);
  }

  /// 상태를 JSON으로 export
  Map<String, dynamic> toJson() {
    return state.toJson();
  }
}