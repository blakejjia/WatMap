import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:watmap/backend/model/models.dart';

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
  TextColumn get otherInfo => text().map(const JsonConverter()).nullable()();
}

Building buildingFromJsonWithSnakeCase(Map<String, dynamic> json) {
  return Building(
    id: json['id'] as String,
    name: json['name'] as String,
    fullName: json['full_name'] as String,
    lat: json['lat'] as double,
    lng: json['lng'] as double,
    mainFloor: json['main_floor'] as int,
    description: json['description'] as String?,
    otherInfo: json['other_info'] as Map<String, dynamic>?
  );
}


