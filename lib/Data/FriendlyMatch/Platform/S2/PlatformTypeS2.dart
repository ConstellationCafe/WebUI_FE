import '../Type/PlatformType.dart';

enum FriendlyMatchS2PlatformType implements FriendlyMatchPlatformType {
  bo1("bo1"),
  bo3("bo3"),
  bo5("bo5"),
  two_decks_bo1("two_decks_bo1");

  @override
  final String name;

  const FriendlyMatchS2PlatformType(this.name);

  @override
  String typeToString() {
    switch (this) {
      case FriendlyMatchS2PlatformType.bo1:
        return "bo1";
      case FriendlyMatchS2PlatformType.bo3:
        return "bo3";
      case FriendlyMatchS2PlatformType.bo5:
        return "bo5";
      case FriendlyMatchS2PlatformType.two_decks_bo1:
        return "two_decks_bo1";
    }
  }
}
