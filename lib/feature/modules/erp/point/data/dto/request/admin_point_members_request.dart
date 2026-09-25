class AdminPointMembersRequest {
  final int page;
  final int size;
  final String? discordId;

  const AdminPointMembersRequest({
    required this.page,
    required this.size,
    this.discordId,
  });

  Map<String, dynamic> toJson() {
    final search = discordId?.trim();
    return {
      'page': page,
      'size': size,
      if (search != null && search.isNotEmpty) 'discordId': search,
    };
  }
}
