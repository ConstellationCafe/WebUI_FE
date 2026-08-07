
enum Toggle { none, asc, desc }

class DBColumn {
  final int _isPrimary;
  final int _isNullable;
  final String _name;
  Toggle sortDir = Toggle.none;

  DBColumn({
    required int isPrimary,
    required int isNullable,
    required String name,
  })  : _isPrimary = isPrimary,
        _isNullable = isNullable,
        _name = name;

  bool isPrimary() {
    return _isPrimary==1;
  }

  bool isNullable() {
    return _isNullable==1;
  }
  
  bool toggle() {
    /** isAscending 반환 */
    if (sortDir == Toggle.none) {
      sortDir = Toggle.asc;
    } else if (sortDir == Toggle.asc) {
      sortDir = Toggle.desc;
    } else {
      sortDir = Toggle.asc;
    }
    return sortDir == Toggle.asc;
  }

  @override
  String toString() {
    return _name;
  }
}