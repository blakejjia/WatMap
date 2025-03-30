import 'package:watmap/backend/repositories/location.dart';

import '../model/base/my_path.dart';
import '../db/database.dart';

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

extension MyPathExtensions on MyPath {
  bool isInside() {
    switch (pathType) {
      case PATH_INSIDE:
      case PATH_STAIRS:
      case PATH_ELEVATOR:
      case PATH_TUNNEL:
      case PATH_BRIDGE:
        return true;
      default:
        return false;
    }
  }

  double getCost(Location pointA, Location pointB) {
    if (pathType == PATH_STAIRS) {
      return (pointA.floor - pointB.floor).abs() * 30;
    }
    // Otherwise use the Euclidean distance.
    double cost = pointA.distanceTo(pointB);
    // Penalize going outside.
    if (!isInside()) {
      cost *= 1.5;
    }
    return cost;
  }
}
