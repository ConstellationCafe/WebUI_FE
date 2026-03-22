import '../Type/LoginType.dart';

enum LoginMethodType implements LoginType {
  discord("discord");

  @override
  final String name;

  const LoginMethodType(this.name);

  @override
  String typeToString() {
    switch (this) {
      case LoginMethodType.discord:
        return "discord";
    }
  }
}