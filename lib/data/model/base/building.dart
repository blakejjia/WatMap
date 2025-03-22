import 'package:watmap/data/model/models.dart';

import 'package:drift/drift.dart';

@DataClassName('Building')
class Buildings extends Table {
  /// Unique id of the Building
  IntColumn get id => integer().autoIncrement()();

  /// Name of the building
  TextColumn get name => text()();

  /// Floors of a building
  TextColumn get floorIds => text().map(const IntListConverter())();

  /// Stairs in a building
  TextColumn get pathIds => text().map(const IntListConverter())();

  /// Main floor of this building
  IntColumn get mainFloorId => integer()();

  @override
  Set<Column> get primaryKey => {name};
}

class IntListConverter extends TypeConverter<List<int>, String> {
  const IntListConverter();

  @override
  List<int> fromSql(String fromDb) {
    return fromDb.split(',').map((e) => int.parse(e)).toList();
  }

  @override
  String toSql(List<int> value) {
    return value.join(',');
  }
}