import 'package:drift/drift.dart';
import 'package:drift/web.dart';
import 'package:drift_flutter/drift_flutter.dart';
import '../model/models.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

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
    if (kIsWeb) {
      return driftDatabase(
        name: 'watMap.db',
        web: DriftWebOptions(
          sqlite3Wasm: Uri.parse('sqlite3.wasm'),
          driftWorker: Uri.parse('drift_worker.dart.js'),
        ),
      );
    }
    return driftDatabase(name: 'watMap.db');
  }
}
