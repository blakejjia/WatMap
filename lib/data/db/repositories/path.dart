import '../database.dart';

class PathRepository {
  final AppDatabase db;

  PathRepository(this.db);

  Future<int> createPath(PathsCompanion path) {
    return db.into(db.paths).insert(path);
  }

  Future<Path?> readPath(int id) {
    return (db.select(db.paths)
      ..where((tbl) => tbl.id.equals(id))).getSingleOrNull();
  }

  Future<List<Path>> readAllPaths() {
    return db.select(db.paths).get();
  }

  Future<bool> updatePath(Path path) {
    return db.update(db.paths).replace(path);
  }

  Future<int> deletePath(int id) {
    return (db.delete(db.paths)..where((tbl) => tbl.id.equals(id))).go();
  }
}