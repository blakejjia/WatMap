import '../db/database.dart';

class LocationRepository {
  final AppDatabase db;

  LocationRepository(this.db);

  Future<int> insertLocation(LocationsCompanion location) {
    return db.into(db.locations).insert(location);
  }

  Future<int> insertAllLocations(List<Location> locations) {
    return db.batch((batch) {
      for (var location in locations) {
        batch.insert(db.locations, location);
      }
    }).then((_) => locations.length);
  }

  Future<Location?> readLocation(String id) {
    return (db.select(db.locations)
      ..where((tbl) => tbl.id.equals(id))).getSingleOrNull();
  }

  Future<List<Location>> readAllLocations() {
    return db.select(db.locations).get();
  }

  Future<bool> updateLocation(Location location) {
    return db.update(db.locations).replace(location);
  }

  Future<int> deleteLocation(String id) {
    return (db.delete(db.locations)..where((tbl) => tbl.id.equals(id))).go();
  }

  Future<int> destroyAllLocations() {
    return db.delete(db.locations).go();
  }
}
