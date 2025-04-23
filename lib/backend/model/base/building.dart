import 'package:drift/drift.dart';

@DataClassName('Building')
class Buildings extends Table {
  /// Unique id of the Building
  IntColumn get id => integer().autoIncrement()();

  /// Name of the building
  TextColumn get name => text()();

  /// Main floor of this building
  IntColumn get floor => integer().withDefault(Constant(1))();

  /// Main floor of this building
  IntColumn get mainFloor => integer().withDefault(Constant(1))();

  /// Position of the building
  RealColumn get lat => real()();
  RealColumn get lng => real()();
}
