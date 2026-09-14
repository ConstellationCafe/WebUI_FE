// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'guild_list_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(guildList)
final guildListProvider = GuildListProvider._();

final class GuildListProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Guild>>,
          List<Guild>,
          FutureOr<List<Guild>>
        >
    with $FutureModifier<List<Guild>>, $FutureProvider<List<Guild>> {
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

String _$guildListHash() => r'fba4cf22bd68f37efbe3904fccc1e7106bc8adec';
