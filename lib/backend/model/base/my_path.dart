// ignore_for_file: constant_identifier_names
import 'dart:convert';

import 'package:drift/drift.dart';

import '../../db/database.dart';

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
  TextColumn get locAId => text()();
  TextColumn get locBId => text()();

  /// Type of the path
  TextColumn get pathType => text()();
  TextColumn get buildingId => text().nullable()();

  /// optional if there is a route
  TextColumn get route => text().map(const JsonConverter()).nullable()();
}

MyPath pathFromJsonWithSnakeCase(Map<String, dynamic> json) {
  return MyPath(
    id: json['id'] as String,
    locAId: json['loc_a_id'] as String,
    locBId: json['loc_b_id'] as String,
    pathType: json['path_type'] as String,
    buildingId: json['building_id'] as String?,
    route: json['route'] as Map<String, dynamic>?,
  );
}

class JsonConverter extends TypeConverter<Map<String, dynamic>, String> {
  const JsonConverter();

  @override
  Map<String, dynamic> fromSql(String fromDb) => jsonDecode(fromDb);

  @override
  String toSql(Map<String, dynamic> value) => jsonEncode(value);
}
