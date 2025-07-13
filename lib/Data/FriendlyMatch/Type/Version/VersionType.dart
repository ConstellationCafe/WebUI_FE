enum FriendlyMatchVersionType {
  S1,
  S2;

  FriendlyMatchVersionType stringtoType(String value) {
    switch (value) {
      case "S1":
        return S1;
      case "S2":
        return S2;
      default:
        return S2;
    }
  }

  String typeToString(FriendlyMatchVersionType type) {
    switch (type) {
      case FriendlyMatchVersionType.S1:
        return "S1";
      case FriendlyMatchVersionType.S2:
        return "S2";
    }
  }
}
