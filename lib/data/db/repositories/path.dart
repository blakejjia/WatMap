import '../database.dart';

class PathRepository {
  final AppDatabase db;

  PathRepository(this.db);

  Future<int> createPath(MyPathsCompanion path) {
    return db.into(db.myPaths).insert(path);
  }

  Future<MyPath?> readPath(int id) {
    return (db.select(db.myPaths)
      ..where((tbl) => tbl.id.equals(id))).getSingleOrNull();
  }

  Future<List<MyPath>> readAllPaths() {
    return db.select(db.myPaths).get();
  }

  Future<bool> updatePath(MyPath path) {
    return db.update(db.myPaths).replace(path);
  }

  Future<int> deletePath(int id) {
    return (db.delete(db.myPaths)..where((tbl) => tbl.id.equals(id))).go();
  }

  Future<int> destroyAllPaths() {
    return db.delete(db.myPaths).go();
  }
}