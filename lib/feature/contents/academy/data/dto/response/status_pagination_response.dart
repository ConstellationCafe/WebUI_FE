class StatusPaginationResponse {
  final int currentPage;
  final int pageSize;
  final int totalPages;
  final int totalCount;

  const StatusPaginationResponse({
    required this.currentPage,
    required this.pageSize,
    required this.totalPages,
    required this.totalCount,
  });

  factory StatusPaginationResponse.fromJson(
      Map<String, dynamic> json,
      ) {
    return StatusPaginationResponse(
      currentPage:
      (json['currentPage'] as num?)
          ?.toInt() ??
          1,
      pageSize:
      (json['pageSize'] as num?)
          ?.toInt() ??
          20,
      totalPages:
      (json['totalPages'] as num?)
          ?.toInt() ??
          0,
      totalCount:
      (json['totalCount'] as num?)
          ?.toInt() ??
          0,
    );
  }
}