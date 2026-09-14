enum GameVersionType {
  S1,
  S2;

  static GameVersionType stringToType(String value) {
    switch (value) {
      case "s1":
        return S1;
      case "s2":
        return S2;
      default:
        return S2;
    }
  }

  String typeToString() {
    switch (this) {
      case GameVersionType.S1:
        return "s1";
      case GameVersionType.S2:
        return "s2";
    }
  }
}
