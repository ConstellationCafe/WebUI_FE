
class FriendlyMatchState {
  const FriendlyMatchState({
    required this.version,
    required this.mode,
    required this.platform,
    required this.roomNumber,
    required this.message,
    required this.sender,
  });

  final String version;
  final String mode;
  final String platform;
  final String roomNumber;
  final String message;
  final String sender;

  factory FriendlyMatchState.initial() => FriendlyMatchState(
    version: "",
    mode: "",
    platform: "",
    roomNumber: "",
    message: "",
    sender: "",
  );

  /// copyWith 메서드
  FriendlyMatchState copyWith({
    String? version,
    String? mode,
    String? platform,
    String? roomNumber,
    String? message,
    String? sender,
  }) {
    return FriendlyMatchState(
      version: version ?? this.version,
      mode: mode ?? this.mode,
      platform: platform ?? this.platform,
      roomNumber: roomNumber ?? this.roomNumber,
      message: message ?? this.message,
      sender: sender ?? this.sender,
    );
  }

  /// JSON 직렬화
  Map<String, dynamic> toJson() {
    return {
      "version": version,
      "mode": mode,
      "platform": platform,
      "roomNumber": roomNumber,
      "message": message,
      "sender": sender,
    };
  }

  /// JSON 역직렬화
  factory FriendlyMatchState.fromJson(Map<String, dynamic> json) {
    return FriendlyMatchState(
      version: json["version"] as String? ?? "",
      mode: json["mode"] as String? ?? "",
      platform: json["platform"] as String? ?? "",
      roomNumber: json["roomNumber"] as String? ?? "",
      message: json["message"] as String? ?? "",
      sender: json["sender"] as String? ?? "",
    );
  }
}