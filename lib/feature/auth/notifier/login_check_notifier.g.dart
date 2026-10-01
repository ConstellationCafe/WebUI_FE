// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_check_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(LoginCheckNotifier)
final loginCheckProvider = LoginCheckNotifierProvider._();

final class LoginCheckNotifierProvider
    extends $AsyncNotifierProvider<LoginCheckNotifier, LoginStatus> {
  LoginCheckNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'loginCheckProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$loginCheckNotifierHash();

  @$internal
  @override
  LoginCheckNotifier create() => LoginCheckNotifier();
}

String _$loginCheckNotifierHash() =>
    r'dc46f779d2b17309c3aa40cfcb45146dc96b8f99';

abstract class _$LoginCheckNotifier extends $AsyncNotifier<LoginStatus> {
  FutureOr<LoginStatus> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<LoginStatus>, LoginStatus>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<LoginStatus>, LoginStatus>,
              AsyncValue<LoginStatus>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
