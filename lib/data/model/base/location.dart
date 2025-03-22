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

  /// which floor
  IntColumn get floor => integer().withDefault(Constant(0))();

  /// If a location is inside a building, here should have its id.
  IntColumn get buildingId => integer().nullable()();
}
// Euclidean distance
// double distanceTo(Location a) {
//   return sqrt(pow(x - a.x, 2) + pow(y - a.y, 2));