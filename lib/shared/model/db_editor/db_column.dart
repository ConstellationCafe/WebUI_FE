enum Toggle { none, asc, desc }

class DBColumn {
  final int _isPrimary;
  final int _isNullable;

  /// Flutter Entity에서 사용하는 이름
  final String _name;

  /// 실제 DB 컬럼명
  final String _dbName;

  Toggle sortDir = Toggle.none;

  DBColumn({
    required int isPrimary,
    required int isNullable,
    required String name,
    required String dbName,
  }) : _isPrimary = isPrimary,
       _isNullable = isNullable,
       _name = name,
       _dbName = dbName;

  bool isPrimary() => _isPrimary == 1;

  bool isNullable() => _isNullable == 1;

  String get dbName => _dbName;

  bool toggle() {
    if (sortDir == Toggle.none) {
      sortDir = Toggle.asc;
    } else if (sortDir == Toggle.asc) {
      sortDir = Toggle.desc;
    } else {
      sortDir = Toggle.asc;
    }

    return sortDir == Toggle.asc;
  }

  void clearSort() {
    sortDir = Toggle.none;
  }

  @override
  String toString() => _name;
}
