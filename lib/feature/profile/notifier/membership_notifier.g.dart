// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'membership_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 회원증은 봇 명령으로 만들어지므로 프로필 화면을 오갈 때마다 다시 만들지 않도록
/// 앱 수명 동안 유지한다.

@ProviderFor(MembershipNotifier)
final membershipProvider = MembershipNotifierProvider._();

/// 회원증은 봇 명령으로 만들어지므로 프로필 화면을 오갈 때마다 다시 만들지 않도록
/// 앱 수명 동안 유지한다.
final class MembershipNotifierProvider
    extends $NotifierProvider<MembershipNotifier, MembershipState> {
  /// 회원증은 봇 명령으로 만들어지므로 프로필 화면을 오갈 때마다 다시 만들지 않도록
  /// 앱 수명 동안 유지한다.
  MembershipNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'membershipProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$membershipNotifierHash();

  @$internal
  @override
  MembershipNotifier create() => MembershipNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(MembershipState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<MembershipState>(value),
    );
  }
}

String _$membershipNotifierHash() =>
    r'1e6387c65cd8accb113c5c4202cc03417d3f67d3';

/// 회원증은 봇 명령으로 만들어지므로 프로필 화면을 오갈 때마다 다시 만들지 않도록
/// 앱 수명 동안 유지한다.

abstract class _$MembershipNotifier extends $Notifier<MembershipState> {
  MembershipState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<MembershipState, MembershipState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<MembershipState, MembershipState>,
              MembershipState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
