class ChatMember {
  final String id;
  final String name;
  final String? profileImageUrl;

  const ChatMember({
    required this.id,
    required this.name,
    this.profileImageUrl,
  });
}