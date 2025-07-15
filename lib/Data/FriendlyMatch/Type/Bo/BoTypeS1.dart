import 'BoType.dart';

enum FriendlyMatchS1BoType implements FriendlyMatchBoType {
  bo1("bo1"),
  bo3("bo3"),
  bo5("bo5"),
  bo7("bo3 1ban"),
  bo9("bo5 2ban");

  final String _name;

  const FriendlyMatchS1BoType(this._name);

  static String typeToString(FriendlyMatchS1BoType value) {
    switch (value) {
      case FriendlyMatchS1BoType.bo1:
        return "bo1";
      case FriendlyMatchS1BoType.bo3:
        return "bo3";
      case FriendlyMatchS1BoType.bo5:
        return "bo5";
      case FriendlyMatchS1BoType.bo7:
        return "bo3 1ban";
      case FriendlyMatchS1BoType.bo9:
        return "bo5 2ban";
    }
  }

  @override
  String get name => _name;
}
