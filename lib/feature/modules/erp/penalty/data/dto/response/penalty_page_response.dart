class PenaltyPageResponse<T> {
  final List<T> items;
  final int page;
  final int size;
  final int totalElements;
  final int totalPages;
  final bool hasNext;

  const PenaltyPageResponse({
    required this.items,
    required this.page,
    required this.size,
    required this.totalElements,
    required this.totalPages,
    required this.hasNext,
  });

  factory PenaltyPageResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic>) parseItem,
  ) => PenaltyPageResponse(
    items: (json['items'] as List<dynamic>)
        .map((item) => parseItem(item as Map<String, dynamic>))
        .toList(),
    page: (json['page'] as num).toInt(),
    size: (json['size'] as num).toInt(),
    totalElements: (json['totalElements'] as num).toInt(),
    totalPages: (json['totalPages'] as num).toInt(),
    hasNext: json['hasNext'] as bool,
  );
}
