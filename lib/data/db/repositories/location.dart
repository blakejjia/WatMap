import '../database.dart';

class LocationRepository {
  final AppDatabase db;

  LocationRepository(this.db);

  Future<int> createLocation(LocationsCompanion location) {
    return db.into(db.locations).insert(location);
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
}