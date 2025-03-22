import 'package:drift/drift.dart';
import '../model/models.dart';

part 'database.g.dart';

@DriftDatabase(tables: [Buildings, Locations, Paths])
class Database extends _$Database {

  Database(QueryExecutor e) : super(e);

  @override
  int get schemaVersion => 2;
}