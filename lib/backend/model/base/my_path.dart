// ignore_for_file: constant_identifier_names
import 'package:drift/drift.dart';

const String PATH_OUTSIDE = "OUTSIDE";
const String PATH_INSIDE = "INSIDE";
const String PATH_STAIRS = "STAIRS";
const String PATH_TUNNEL = "TUNNEL";
const String PATH_BRIDGE = "BRIDGE";
const String PATH_BRIEFLY_OUTSIDE = "BRIEFLY_OUTSIDE";

@DataClassName('MyPath')
class MyPaths extends Table {
  /// Unique id of the Path
  TextColumn get id => text()();

  /// Starting and ending points of the path
  TextColumn get pointAId => text()();
  TextColumn get pointBId => text()();

  /// Type of the path
  TextColumn get pathType => text()();
  IntColumn get buildingId => integer().nullable()();

  /// optional if there is a route
  TextColumn get route => text().nullable()();
}
