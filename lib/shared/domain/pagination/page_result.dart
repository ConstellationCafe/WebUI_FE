class PageResult<T> {
  final List<T> items;
  final List<Map<String, dynamic>> metadata;
  final int page;
  final int size;
  final int totalElements;
  final int totalPages;
  final bool hasNext;

  const PageResult({
    required this.items,
    this.metadata = const [],
    required this.page,
    required this.size,
    required this.totalElements,
    required this.totalPages,
    required this.hasNext,
  });
}
