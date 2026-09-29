// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'guild_list_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 가입한 채팅방 목록. 라우터가 로그인 가드에서 계속 참조하므로 앱 수명 동안 유지한다.

@ProviderFor(guildList)
final guildListProvider = GuildListProvider._();

/// 가입한 채팅방 목록. 라우터가 로그인 가드에서 계속 참조하므로 앱 수명 동안 유지한다.

final class GuildListProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Guild>>,
          List<Guild>,
          FutureOr<List<Guild>>
        >
    with $FutureModifier<List<Guild>>, $FutureProvider<List<Guild>> {
  /// 가입한 채팅방 목록. 라우터가 로그인 가드에서 계속 참조하므로 앱 수명 동안 유지한다.
  GuildListProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'guildListProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$guildListHash();

  @$internal
  @override
  $FutureProviderElement<List<Guild>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<Guild>> create(Ref ref) {
    return guildList(ref);
  }
}

String _$guildListHash() => r'168daeaa9d1b5d66d390ffa4ff0161d7b04cf28a';
