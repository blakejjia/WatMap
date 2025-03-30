import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import '../model/models.dart';

part 'database.g.dart';

@DriftDatabase(tables: [Buildings, Locations, MyPaths])
class AppDatabase extends _$AppDatabase {

  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 3;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onUpgrade: (migrator, from, to) async {
      await migrator.deleteTable('Buildings');
      await migrator.deleteTable('Locations');
      await migrator.deleteTable('MyPaths');
      await migrator.createAll();
    },
  );

  static QueryExecutor _openConnection() {
    return driftDatabase(name: 'WatMap.db');
  }
}