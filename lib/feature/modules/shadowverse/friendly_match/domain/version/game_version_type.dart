enum GameVersionType {
  s1,
  s2;

  static GameVersionType stringToType(String value) {
    switch (value) {
      case "s1":
        return s1;
      case "s2":
        return s2;
      default:
        return s2;
    }
  }

  String typeToString() {
    switch (this) {
      case GameVersionType.s1:
        return "s1";
      case GameVersionType.s2:
        return "s2";
    }
  }
}
