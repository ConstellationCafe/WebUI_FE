import '../Type/PlatformType.dart';

enum FriendlyMatchS2PlatformType implements FriendlyMatchPlatformType {
  bo1("Bo1"),
  bo3("Bo3"),
  two_decks_bo1("Bo1/2deck");

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
      case FriendlyMatchS2PlatformType.two_decks_bo1:
        return "Bo1/2deck";
    }
  }
}
