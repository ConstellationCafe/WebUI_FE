import 'package:flutter_test/flutter_test.dart';

import 'package:constellation_cafe/feature/auth/data/dto/response/auth_check_response.dart';
import 'package:constellation_cafe/feature/auth/data/dto/response/current_user_response.dart';
import 'package:constellation_cafe/shared/data/dto/response/backend/api_response.dart';

import '../../../support/feature/auth/support/fake_auth_service.dart';

void main() {
  group('AuthCheckResponse', () {
    test('로그인·채팅방 선택·갱신 힌트를 bool로 읽는다', () {
      final response = AuthCheckResponse.fromApiResponse(
        checkResponse(isLogin: true, roomSelected: true, refreshHint: true),
      );

      expect(response.success, isTrue);
      expect(response.isLogin, isTrue);
      expect(response.roomSelected, isTrue);
      expect(response.refreshHint, isTrue);
      expect(response.isUnauthorized, isFalse);
    });

    test('401·403 실패는 인증 오류로 구분한다', () {
      expect(
        AuthCheckResponse.fromApiResponse(errorResponse(401)).isUnauthorized,
        isTrue,
      );
      expect(
        AuthCheckResponse.fromApiResponse(errorResponse(403)).isUnauthorized,
        isTrue,
      );
      expect(
        AuthCheckResponse.fromApiResponse(errorResponse(500)).isUnauthorized,
        isFalse,
      );
    });

    test('본문이 없거나 객체가 아니면 로그인하지 않은 것으로 본다', () {
      final response = AuthCheckResponse.fromApiResponse(
        ApiResponse(success: true, response: 'unexpected', error: null),
      );

      expect(response.isLogin, isFalse);
      expect(response.roomSelected, isFalse);
      expect(response.refreshHint, isFalse);
    });
  });

  group('CurrentUserResponse', () {
    test('discordId·avatar를 사용자 상태의 userId·avatarUrl로 옮긴다', () {
      final state = CurrentUserResponse.fromJson(meJson()).toState();

      expect(state.userId, '123');
      expect(state.globalName, '별');
      expect(state.roles, ['ROLE_ADMIN']);
      expect(state.avatarUrl, 'https://cdn.example.invalid/a.png');
    });

    test('필수 필드가 빠지면 계약 위반으로 실패한다', () {
      expect(
        () => CurrentUserResponse.fromJson(const {'discordId': '1'}),
        throwsA(isA<TypeError>()),
      );
    });
  });
}
