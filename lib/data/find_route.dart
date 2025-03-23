import 'dart:math';
import 'package:collection/collection.dart';

import 'package:watmap/data/model/mid/my_route.dart';

import '../main.dart';
import 'db/database.dart';
import 'db/repositories/location.dart';
import 'model/base/my_path.dart';
import 'model/mid/my_map.dart';

// TODO: here!!!
// TODO: here!!!
// TODO: here!!!
// TODO: here!!!
Future<MyRoute?> findRoute(MyMap map, Building start, Building end) async {
  print(start);
  print(end);
  // Real start from the main floor of each building
  Location locationA = await getIt<LocationRepository>().getLocation(
    start.id,
    start.mainFloor,
  );
  Location locationB = await getIt<LocationRepository>().getLocation(
    end.id,
    end.mainFloor,
  );

  // here we find path
  // TODO: algorithm to find path
  List<Location> locations = dijkstra(locationA, locationB, map);
  print(locations);
  List<MyPath> paths = [];
  for (int i = 0; i < locations.length - 1; i++) {
    Location locA = locations[i];
    Location locB = locations[i + 1];
    MyPath? path = map.paths.firstWhere(
      (element) =>
          (element.pointAId == locA.id && element.pointBId == locB.id) ||
          (element.pointAId == locB.id && element.pointBId == locA.id),
      orElse:
          () => MyPath(
            id: 0,
            pointAId: locations[i].id,
            pointBId: locations[i + 1].id,
            pathType: PATH_OUTSIDE,
          ),
    );
    paths.add(path);
  }

  // return route
  final route = MyRoute(paths, locationA, locationB);
  return route;
}

List<Location> dijkstra(Location loc1, Location loc2, MyMap map) {
  // Initialize distance and previous maps
  Map<Location, double> distTable = {};
  Map<Location, Location?> previous = {};
  for (Location loc in map.locations) {
    distTable[loc] = double.infinity;
    previous[loc] = null;
  }
  distTable[loc1] = 0.0;

  // Priority queue to efficiently get the next node with smallest distance
  PriorityQueue<Location> queue = PriorityQueue<Location>(
    (a, b) => distTable[a]!.compareTo(distTable[b]!),
  );
  queue.add(loc1);

  while (queue.isNotEmpty) {
    Location cur = queue.removeFirst();

    // Early exit if we've reached the destination.
    if (cur == loc2) break;

    for (LocationAndDistance next in getAdjacentLocations(cur, map)) {
      double altDist = distTable[cur]! + next.distance;
      if (altDist < distTable[next.location]!) {
        distTable[next.location] = altDist;
        previous[next.location] = cur;
        // Update priority queue by removing and re-adding if the node exists
        if (queue.contains(next.location)) {
          queue.remove(next.location);
        }
        queue.add(next.location);
      }
    }
  }

  // If the destination is unreachable, return an empty list
  if (distTable[loc2] == double.infinity) return [];

  // Reconstruct the path from loc2 back to loc1 using the previous map.
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
      double dist = path.getCost(loc, adjacent);
      adjacents.add(LocationAndDistance(adjacent, dist));
    }
    if (path.pointBId == loc.id) {
      Location adjacent = map.locations.firstWhere(
        (element) => element.id == path.pointAId,
      );
      double dist = path.getCost(loc, adjacent);
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

extension MyPathExtensions on MyPath {
  bool isInside() {
    switch (pathType) {
      case PATH_INSIDE:
      case PATH_STAIRS:
      case PATH_ELEVATOR:
      case PATH_TUNNEL:
      case PATH_BRIDGE:
        return true;
      default:
        return false;
    }
  }

  double getCost(Location pointA, Location pointB) {
    if (pathType == PATH_STAIRS) {
      return (pointA.floor - pointB.floor).abs() * 30;
    }
    // Otherwise use the Euclidean distance.
    double cost = pointA.distanceTo(pointB);
    // Penalize going outside.
    if (!isInside()) {
      cost *= 1.5;
    }
    return cost;
  }
}

extension LocationExtensions on Location {
  double distanceTo(Location a) {
    return sqrt(pow(x - a.x, 2) + pow(y - a.y, 2));
  }
}
