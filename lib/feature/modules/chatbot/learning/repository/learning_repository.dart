import 'package:constellation_cafe/shared/domain/repository/repository_interface.dart';
import '../../../../../shared/domain/pagination/page_result.dart';
import '../domain/entity/learning_entity.dart';
import 'package:dio/dio.dart';

class LearningRepository
    implements RepositoryInterface<LearningEntity> {
  static String apiPath = "/api/repository/learning";

  final Dio dio;

  LearningRepository({
    required this.dio,
  });

  @override
  Future<PageResult<LearningEntity>> findPage({
    required int page,
    required int size,
    String? searchColumn,
    String? searchValue,
    String? sortColumn,
    String? sortDirection,
  }) async {
    /*
     * DBEditor에서는 discordId라는 이름을 사용하지만
     * BE에서는 teacher라는 컬럼명을 사용한다.
     *
     * 검색/정렬 요청 시 변환한다.
     */
    final apiSearchColumn =
    _toApiColumnName(searchColumn);

    final apiSortColumn =
    _toApiColumnName(sortColumn);

    final response = await dio.get(
      "$apiPath/list",
      queryParameters: {
        'page': page,
        'size': size,

        if (apiSearchColumn != null &&
            apiSearchColumn.isNotEmpty)
          'searchColumn': apiSearchColumn,

        if (searchValue != null &&
            searchValue.isNotEmpty)
          'searchValue': searchValue,

        if (apiSortColumn != null &&
            apiSortColumn.isNotEmpty)
          'sortColumn': apiSortColumn,

        if (sortDirection != null &&
            sortDirection.isNotEmpty)
          'sortDirection': sortDirection,
      },
    );

    final res = response.data;

    if (res['success'] != true) {
      final err = res['error'];

      final msg = (err is Map<String, dynamic>)
          ? (err['message']?.toString() ?? 'unknown')
          : 'unknown';

      throw Exception('API error: $msg');
    }

    final body = res['response'];

    /*
     * BE metadata:
     *
     * ln_key
     * ln_value
     * teacher
     *
     * ↓
     *
     * DBEditor metadata:
     *
     * lnKey
     * lnValue
     * discordId
     *
     * dbName에는 BE에서 사용하는 이름을 보존한다.
     */
    final List rawMeta =
        (body['metadata'] as List?)?.toList() ??
            const [];

    final List<Map<String, dynamic>> metadata =
    rawMeta
        .map(
          (e) =>
      Map<String, dynamic>.from(
        e as Map,
      ),
    )
        .map((m) {
      final dbName =
      m['colName'].toString();

      // BE/DB 실제 컬럼명 보존
      m['dbName'] = dbName;

      if (dbName == 'ln_key') {
        m['colName'] = 'lnKey';
      } else if (dbName == 'ln_value') {
        m['colName'] = 'lnValue';
      } else if (dbName == 'teacher') {
        m['colName'] = 'discordId';
      }

      return m;
    })
        .toList();

    /*
     * BE entity:
     *
     * {
     *   lnKey: ...,
     *   lnValue: ...,
     *   teacher: Discord ID
     * }
     *
     * LearningEntity.fromJson에서
     *
     * teacher -> discordId
     *
     * 로 변환한다.
     */
    final List rawEntities =
        (body['entities'] as List?)?.toList() ??
            const [];

    final List<LearningEntity> entities =
    rawEntities
        .map(
          (e) => LearningEntity.fromJson(
        metadata,
        Map<String, dynamic>.from(
          e as Map,
        ),
      ),
    )
        .toList();

    return PageResult<LearningEntity>(
      items: entities,
      metadata: metadata,

      page: (body['page'] as num?)
          ?.toInt() ??
          page,

      size: (body['size'] as num?)
          ?.toInt() ??
          size,

      totalElements:
      (body['totalElements'] as num?)
          ?.toInt() ??
          0,

      totalPages:
      (body['totalPages'] as num?)
          ?.toInt() ??
          0,

      hasNext: body['hasNext'] == true,
    );
  }

  @override
  Future<dynamic> save(
      LearningEntity entity,
      ) async {
    /*
     * entity.toJson()에서
     *
     * discordId -> teacher
     *
     * 변환됨
     */
    final res = await dio.post(
      "$apiPath/save",
      data: [
        entity.toJson(),
      ],
    );

    return res.data;
  }

  @override
  Future<dynamic> saveAll(
      List<Map<String, String>> model,
      ) async {
    /*
     * DBEditor:
     *
     * discordId
     *
     * ↓
     *
     * BE:
     *
     * teacher
     */
    final data =
    model.map(_toApiJson).toList();

    final res = await dio.post(
      "$apiPath/save_all",
      data: data,
    );

    return res.data;
  }

  @override
  Future<dynamic> deleteAll(
      List<Map<String, String>> model,
      ) async {
    /*
     * delete도 동일하게
     *
     * discordId -> teacher
     */
    final data =
    model.map(_toApiJson).toList();

    final res = await dio.post(
      "$apiPath/delete_all",
      data: data,
    );

    return res.data;
  }

  /*
   * DBEditor row -> BE DTO
   */
  Map<String, String> _toApiJson(
      Map<String, String> row,
      ) {
    return {
      'lnKey': row['lnKey'] ?? '',
      'lnValue': row['lnValue'] ?? '',
      'teacher': row['discordId'] ?? '',
    };
  }

  /*
   * DBEditor 컬럼명 -> BE 컬럼명
   *
   * discordId 검색/정렬 시
   * BE에서는 teacher로 받아야 한다.
   */
  String? _toApiColumnName(
      String? column,
      ) {
    if (column == null) {
      return null;
    }

    if (column == 'discordId') {
      return 'teacher';
    }

    return column;
  }
}