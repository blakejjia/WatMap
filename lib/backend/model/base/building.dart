import 'package:drift/drift.dart';

@DataClassName('Building')
class Buildings extends Table {
  /// Unique id of the Building
  TextColumn get id => text()();

  /// Name of the building
  TextColumn get name => text()();
  TextColumn get fullName => text()();

  /// Position of the building
  RealColumn get lat => real()();
  RealColumn get lng => real()();

  /// Floor info
  IntColumn get mainFloor => integer()();

  /// other Info
  TextColumn get description => text().nullable()();
  TextColumn get otherInfo => text().nullable()();
}
