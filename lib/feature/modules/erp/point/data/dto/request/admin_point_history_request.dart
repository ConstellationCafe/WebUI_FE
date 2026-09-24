class AdminPointHistoryRequest {
  final int page;
  final int size;

  const AdminPointHistoryRequest({required this.page, required this.size});

  Map<String, dynamic> toJson() => {'page': page, 'size': size};
}
