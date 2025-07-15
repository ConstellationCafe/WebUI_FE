import 'BoType.dart';

enum FriendlyMatchS2BoType implements FriendlyMatchBoType {
  bo1("bo1"),
  bo3("bo3"),
  bo5("bo5"),
  two_decks_bo1("two_decks_bo1");

  @override
  final String name;

  const FriendlyMatchS2BoType(this.name);

  static String typeToString(FriendlyMatchS2BoType value) {
    switch (value) {
      case FriendlyMatchS2BoType.bo1:
        return "bo1";
      case FriendlyMatchS2BoType.bo3:
        return "bo3";
      case FriendlyMatchS2BoType.bo5:
        return "bo5";
      case FriendlyMatchS2BoType.two_decks_bo1:
        return "two_decks_bo1";
    }
  }
}
