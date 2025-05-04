import 'package:watmap/backend/db/database.dart';
import 'package:watmap/frontend/algorithm/algorithms.dart';

import 'my_map.dart';

class MyRoute {
  final List<MyPath> paths;
  final List<Location> locations;
  final Location start;
  final Location end;

  MyRoute(this.paths, this.locations, this.start, this.end);

  bool get isNotEmpty => paths.isNotEmpty;
}
