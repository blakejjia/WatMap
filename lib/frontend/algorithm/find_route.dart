part of 'algorithms.dart';

// TODO: here!!!
// TODO: here!!!
// TODO: here!!!
// TODO: here!!!
Future<MyRoute?> findRoute(MyMap map, Building start, Building end) async {
  // Real start from the main floor of each building
  Location? locationA = await getIt<LocationRepository>().getLocation(
    start.id,
    start.mainFloor,
  );
  Location? locationB = await getIt<LocationRepository>().getLocation(
    end.id,
    end.mainFloor,
  );
  if (locationA == null || locationB == null) {
    return null;
  }

  // here we find path
  List<Location> locations = aStar(locationA, locationB, map);
  List<MyPath> paths = [];
  for (int i = 0; i < locations.length - 1; i++) {
    Location locA = locations[i];
    Location locB = locations[i + 1];
<<<<<<< HEAD
    MyPath? path = map.paths.firstWhere(
      (element) => (element.pointAId == locA.id && element.pointBId == locB.id),
      orElse:
          () => MyPath(
            id: 0,
            pointAId: locA.id,
            pointBId: locB.id,
            pathType: PATH_OUTSIDE,
          ),
    );
    paths.add(path);
=======
    paths.add(createMyPath(locA, locB, map));
>>>>>>> 9654b3d (refactored UI, transvered to A*)
  }

  // Check if the last path is a "STAIR" and remove it if so
  if (paths.isNotEmpty && paths.last.pathType == PATH_STAIRS) {
    paths.removeLast();
  }
  // return route
  final route = MyRoute.auto(paths, locationA, locationB, map);
  return route;
}

List<Location> aStar(Location loc1, Location loc2, MyMap map) {
  Map<Location, double> distTable = {};
  Map<Location, Location?> previous = {};
  for (Location loc in map.locations) {
    distTable[loc] = double.infinity;
    previous[loc] = null;
  }
  distTable[loc1] = 0.0;

  int heuristic(Location a, Location b) {
    // 简单欧几里得距离作为启发函数
    return (a.x - b.x).abs() + (a.y - b.y).abs(); // Manhattan
    // return sqrt(pow(a.x - b.x, 2) + pow(a.y - b.y, 2)); // Euclidean
  }

  PriorityQueue<Location> queue = PriorityQueue<Location>(
<<<<<<< HEAD
    (a, b) => distTable[a]!.compareTo(distTable[b]!),
=======
    (a, b) => (distTable[a]! + heuristic(a, loc2)).compareTo(
      distTable[b]! + heuristic(b, loc2),
    ),
>>>>>>> 9654b3d (refactored UI, transvered to A*)
  );

  queue.add(loc1);

  while (queue.isNotEmpty) {
    Location cur = queue.removeFirst();

    if (cur == loc2) break;

    for (LocationAndDistance next in getAdjacentLocations(cur, map)) {
      double altDist = distTable[cur]! + next.distance;
      if (altDist < distTable[next.location]!) {
        distTable[next.location] = altDist;
        previous[next.location] = cur;

        if (queue.contains(next.location)) {
          queue.remove(next.location);
        }
        queue.add(next.location);
      }
    }
  }

  if (distTable[loc2] == double.infinity) return [];

  List<Location> path = [];
  for (Location? at = loc2; at != null; at = previous[at]) {
    path.add(at);
  }
  return path.reversed.toList();
}

/// Returns a list of adjacent locations along with the cost to reach them.
List<LocationAndDistance> getAdjacentLocations(Location loc, MyMap map) {
  List<LocationAndDistance> adjacents = [];
  for (MyPath path in map.paths) {
    if (path.pointAId == loc.id) {
      Location adjacent = map.locations.firstWhere(
        (element) => element.id == path.pointBId,
      );
      double dist = path.getCost(map);
      adjacents.add(LocationAndDistance(adjacent, dist));
    }
    if (path.pointBId == loc.id) {
      Location adjacent = map.locations.firstWhere(
        (element) => element.id == path.pointAId,
      );
      double dist = path.getCost(map);
      adjacents.add(LocationAndDistance(adjacent, dist));
    }
  }
  return adjacents;
}

/// Wrapper class containing a location and the distance to that location.
class LocationAndDistance {
  final Location location;
  final double distance;

  LocationAndDistance(this.location, this.distance);

  @override
  String toString() {
    return '$distance: $location';
  }
}
