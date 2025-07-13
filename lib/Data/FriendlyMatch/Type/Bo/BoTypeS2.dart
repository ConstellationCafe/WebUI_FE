import 'BoType.dart';

enum FriendlyMatchS2BoType implements FriendlyMatchBoType {
  bo1("bo1"),
  bo3("bo3"),
  bo5("bo5"),
  two_decks_bo1("two_decks_bo1");


  final String _name;

  const FriendlyMatchS2BoType(this._name);

  @override
  String get name => _name;
}
