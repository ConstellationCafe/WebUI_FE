class PointPage<T> {
  final List<T> items;
  final int page;
  final int size;
  final int totalElements;
  final int totalPages;
  final bool hasNext;

  const PointPage({
    required this.items,
    required this.page,
    required this.size,
    required this.totalElements,
    required this.totalPages,
    required this.hasNext,
  });
}
