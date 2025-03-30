import 'package:watmap/backend/db/database.dart';

class MyRoute {
  final List<MyPath> paths;
  final Location start;
  final Location end;

  MyRoute(this.paths, this.start, this.end);
}
