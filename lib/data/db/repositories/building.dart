import '../database.dart';

class BuildingRepository {
  final AppDatabase db;

  BuildingRepository(this.db);

  Future<int> createBuilding(BuildingsCompanion building) {
    return db.into(db.buildings).insert(building);
  }

  Future<int> getIdByName(String name) async {
    final building = await (db.select(db.buildings)
      ..where((tbl) => tbl.name.equals(name))).getSingleOrNull();
    return building?.id ?? -1;
  }

  Future<Building?> readBuilding(int id) {
    return (db.select(db.buildings)
      ..where((tbl) => tbl.id.equals(id))).getSingleOrNull();
  }

  Future<List<Building>> readAllBuildings() {
    return db.select(db.buildings).get();
  }

  Future<bool> updateBuilding(Building building) {
    return db.update(db.buildings).replace(building);
  }

  Future<int> deleteBuilding(int id) {
    return (db.delete(db.buildings)..where((tbl) => tbl.id.equals(id))).go();
  }

  Future<void> destroyAllBuildings() {
    return db.delete(db.buildings).go();
  }

}
