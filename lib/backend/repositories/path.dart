
import '../db/database.dart';

class PathRepository {
  final AppDatabase db;

  PathRepository(this.db);

  Future<int> insertPath(MyPathsCompanion path) {
    return db.into(db.myPaths).insert(path);
  }

  Future<int> insertAllPaths(List<MyPath> paths) {
    return db.batch((batch) {
      for (var path in paths) {
        batch.insert(db.myPaths, path);
      }
    }).then((_) => paths.length);
  }

  Future<MyPath?> readPath(String id) {
    return (db.select(db.myPaths)
      ..where((tbl) => tbl.id.equals(id))).getSingleOrNull();
  }

  Future<List<MyPath>> readAllPaths() {
    return db.select(db.myPaths).get();
  }

  Future<bool> updatePath(MyPath path) {
    return db.update(db.myPaths).replace(path);
  }

  Future<int> deletePath(String id) {
    return (db.delete(db.myPaths)..where((tbl) => tbl.id.equals(id))).go();
  }

  Future<int> destroyAllPaths() {
    return db.delete(db.myPaths).go();
  }
}
