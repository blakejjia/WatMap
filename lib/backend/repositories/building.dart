import '../db/database.dart';

class BuildingRepository {
  final AppDatabase db;

  BuildingRepository(this.db);

  Future<int> insertBuilding(Building building) {
    return db.into(db.buildings).insert(building);
  }

  Future<bool> insertAllBuildings(List<Building> buildings) async {
    for (final building in buildings) {
      await db.into(db.buildings).insert(building);
    }
    return true;
  }

  Future<String?> getIdByName(String name) async {
    final building = await (db.select(db.buildings)
      ..where((tbl) => tbl.name.equals(name))).getSingleOrNull();
    return building?.id;
  }

  Future<Building?> readBuilding(String id) {
    return (db.select(db.buildings)
      ..where((tbl) => tbl.id.equals(id))).getSingleOrNull();
  }

  Future<List<Building>> readAllBuildings() {
    return db.select(db.buildings).get();
  }

  Future<bool> updateBuilding(Building building) {
    return db.update(db.buildings).replace(building);
  }

  Future<int> deleteBuilding(String id) {
    return (db.delete(db.buildings)..where((tbl) => tbl.id.equals(id))).go();
  }

  Future<void> destroyAllBuildings() {
    return db.delete(db.buildings).go();
  }

}
