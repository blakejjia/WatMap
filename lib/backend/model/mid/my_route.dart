import 'package:watmap/backend/db/database.dart';
import 'package:watmap/frontend/algorithm/algorithms.dart';

import 'my_map.dart';

class MyRoute {
  final List<MyPath> paths;
  final Location start;
  final Location end;
  double? time;
  int? stairsCount;
  int? bridgeOrTunnelCount;

  MyRoute(this.paths, this.start, this.end);

  factory MyRoute.auto(List<MyPath> paths, Location start, Location end, MyMap map) {
    final route = MyRoute(paths, start, end);
    route.time = route.getTime(map);
    route.stairsCount = route.getStairsCount();
    route.bridgeOrTunnelCount = route.getBridgeOrTunnelCount();
    return route;
  }

  bool get isNotEmpty => paths.isNotEmpty;
}
