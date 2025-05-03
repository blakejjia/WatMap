import 'package:drift/drift.dart';

@DataClassName('Location')
class Locations extends Table {
  /// Unique id of the location
  TextColumn get id => text()();
  TextColumn get name => text()();

  /// Position of the location
  RealColumn get lat => real()();
  RealColumn get lng => real()();
  
  /// which floor
  IntColumn get floor => integer().withDefault(Constant(0))();

  /// If a location is inside a building, here should have its id.
  TextColumn get building_id => text().nullable()();
}
