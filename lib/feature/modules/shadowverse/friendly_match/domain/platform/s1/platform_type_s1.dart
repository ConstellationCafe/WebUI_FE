import '../type/platform_type.dart';

enum FriendlyMatchS1PlatformType implements FriendlyMatchPlatformType {
  bo1("bo1"),
  bo3("bo3"),
  bo5("bo5"),
  bo7("bo3 1ban"),
  bo9("bo5 2ban");

  @override
  final String name;

  const FriendlyMatchS1PlatformType(this.name);

  @override
  String typeToString() {
    switch (this) {
      case FriendlyMatchS1PlatformType.bo1:
        return "bo1";
      case FriendlyMatchS1PlatformType.bo3:
        return "bo3";
      case FriendlyMatchS1PlatformType.bo5:
        return "bo5";
      case FriendlyMatchS1PlatformType.bo7:
        return "bo3 1ban";
      case FriendlyMatchS1PlatformType.bo9:
        return "bo5 2ban";
    }
  }
}
