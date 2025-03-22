import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import '../model/models.dart';

part 'database.g.dart';

@DriftDatabase(tables: [Buildings, Locations, Paths])
class AppDatabase extends _$AppDatabase {

  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 2;

  static QueryExecutor _openConnection() {
    return driftDatabase(name: 'WatMap.db');
  }
}