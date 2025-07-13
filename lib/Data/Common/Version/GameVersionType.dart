enum GameVersionType {
  S1,
  S2;

  GameVersionType stringToType(String value) {
    switch (value) {
      case "S1":
        return S1;
      case "S2":
        return S2;
      default:
        return S2;
    }
  }

  String typeToString(GameVersionType version) {
    switch (version) {
      case GameVersionType.S1:
        return "S1";
      case GameVersionType.S2:
        return "S2";
    }
  }
}
