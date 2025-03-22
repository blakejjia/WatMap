import 'package:drift/drift.dart';

@DataClassName('Location')
class Locations extends Table {
  /// Unique id of the location
  IntColumn get id => integer().autoIncrement()();

  /// Name of the location
  TextColumn get name => text()();

  /// Position of the location
  IntColumn get x => integer()();
  IntColumn get y => integer()();

  /// Floor of the location
  IntColumn get floor => integer().withDefault(Constant(0))();

  /// If a location has building = false means it's not a building
  BoolColumn get isBuilding => boolean()();

  IntColumn get buildingId => integer().nullable()();

  @override
  Set<Column> get primaryKey => {name};
}
// Euclidean distance
// double distanceTo(Location a) {
//   return sqrt(pow(x - a.x, 2) + pow(y - a.y, 2));