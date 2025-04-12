import 'dart:math';

import '../db/database.dart';

class LocationRepository {
  final AppDatabase db;

  LocationRepository(this.db);

  Future<int> createLocation(LocationsCompanion location) {
    return db.into(db.locations).insert(location);
  }

  Future<Location?> getLocation(int building, int floor) async {
    return (db.select(db.locations)
      ..where((tbl) => tbl.buildingId.equals(building))
      ..where((tbl) => tbl.floor.equals(floor))).getSingleOrNull();
  }

  Future<Location?> readLocation(int id) {
    return (db.select(db.locations)
      ..where((tbl) => tbl.id.equals(id))).getSingleOrNull();
  }

  Future<List<Location>> readAllLocations() {
    return db.select(db.locations).get();
  }

  Future<bool> updateLocation(Location location) {
    return db.update(db.locations).replace(location);
  }

  Future<int> deleteLocation(int id) {
    return (db.delete(db.locations)..where((tbl) => tbl.id.equals(id))).go();
  }

  Future<int> destroyAllLocations() {
    return db.delete(db.locations).go();
  }
}

extension LocationExtensions on Location {
  double distanceTo(Location a) {
    return sqrt(pow(x - a.x, 2) + pow(y - a.y, 2));
  }
}