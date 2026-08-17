class ChatMember {
  final String id;
  final String name;
  final String? profileImageUrl;

  const ChatMember({
    required this.id,
    required this.name,
    this.profileImageUrl,
  });

  factory ChatMember.fromJson(Map<String, dynamic> json) {
    return ChatMember(
      id: json['id'].toString(),
      name: json['name'].toString(),
      profileImageUrl: json['profileImageUrl'].toString(),
    );
  }
}