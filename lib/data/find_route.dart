import 'package:watmap/data/model/mid/my_route.dart';

import 'db/database.dart';
import 'model/mid/my_map.dart';

// TODO: here!!!
// TODO: here!!!
// TODO: here!!!
// TODO: here!!!
MyRoute? findRoute(MyMap map, Building start, Building end) {
  // Real start from the main floor of each building
  Location locationA = map.locations.firstWhere(
    (element) => element.id == start.id,
  );
  Location locationB = map.locations.firstWhere(
    (element) => element.id == end.id,
  );

  // here we find path
  // TODO: algorithm to find path
  final path = MyPath(
    id: 0,
    pointAId: locationA.id,
    pointBId: locationB.id,
    pathType: 0,
  );

  // return route
  final route = MyRoute([path], locationA, locationB);
  return route;
}
