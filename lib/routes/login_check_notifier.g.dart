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
    extends $AsyncNotifierProvider<LoginCheckNotifier, bool> {
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
    r'e644dd9d4ee354123edd1149072920a6fe693b3d';

abstract class _$LoginCheckNotifier extends $AsyncNotifier<bool> {
  FutureOr<bool> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<bool>, bool>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<AsyncValue<bool>, bool>,
        AsyncValue<bool>,
        Object?,
        Object?>;
    element.handleCreate(ref, build);
  }
}
