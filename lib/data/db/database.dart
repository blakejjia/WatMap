import 'package:drift/drift.dart';
import '../model/models.dart';

part 'database.g.dart';

@DriftDatabase(tables: [Buildings, Locations, Paths])
class AppDatabase extends _$AppDatabase {

  AppDatabase(super.e);

  @override
  int get schemaVersion => 2;
}