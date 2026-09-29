// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_penalty_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 로그인한 회원의 벌점 상세. 페이지별로 조회하고 화면을 벗어나면 요청을 취소한다.

@ProviderFor(myPenalty)
final myPenaltyProvider = MyPenaltyFamily._();

/// 로그인한 회원의 벌점 상세. 페이지별로 조회하고 화면을 벗어나면 요청을 취소한다.

final class MyPenaltyProvider
    extends
        $FunctionalProvider<
          AsyncValue<PenaltyDetail>,
          PenaltyDetail,
          FutureOr<PenaltyDetail>
        >
    with $FutureModifier<PenaltyDetail>, $FutureProvider<PenaltyDetail> {
  /// 로그인한 회원의 벌점 상세. 페이지별로 조회하고 화면을 벗어나면 요청을 취소한다.
  MyPenaltyProvider._({
    required MyPenaltyFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'myPenaltyProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$myPenaltyHash();

  @override
  String toString() {
    return r'myPenaltyProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<PenaltyDetail> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<PenaltyDetail> create(Ref ref) {
    final argument = this.argument as int;
    return myPenalty(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is MyPenaltyProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$myPenaltyHash() => r'44f202785ae2deabbd0388c99d05469c8418f4cf';

/// 로그인한 회원의 벌점 상세. 페이지별로 조회하고 화면을 벗어나면 요청을 취소한다.

final class MyPenaltyFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<PenaltyDetail>, int> {
  MyPenaltyFamily._()
    : super(
        retry: null,
        name: r'myPenaltyProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// 로그인한 회원의 벌점 상세. 페이지별로 조회하고 화면을 벗어나면 요청을 취소한다.

  MyPenaltyProvider call(int page) =>
      MyPenaltyProvider._(argument: page, from: this);

  @override
  String toString() => r'myPenaltyProvider';
}
