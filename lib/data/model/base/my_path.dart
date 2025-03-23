// ignore_for_file: constant_identifier_names
import 'package:drift/drift.dart';

const int PATH_OUTSIDE = 1;
const int PATH_INSIDE = 2;
const int PATH_STAIRS = 3;
const int PATH_ELEVATOR = 4;
const int PATH_TUNNEL = 5;
const int PATH_BRIDGE = 6;
const int PATH_BRIEFLY_OUTSIDE = 7;

@DataClassName('MyPath')
class MyPaths extends Table {
  /// Unique id of the Path
  IntColumn get id => integer().autoIncrement()();

  /// Starting and ending points of the path
  IntColumn get pointAId => integer()();
  IntColumn get pointBId => integer()();

  /// Type of the path
  IntColumn get pathType => integer()();
  IntColumn get buildingId => integer().nullable()();
}
