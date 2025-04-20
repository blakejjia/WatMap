import 'dart:convert';
import 'package:vector_math/vector_math.dart';
import 'package:watmap/backend/model/base/my_path.dart';
import 'package:watmap/frontend/blocs/settings_bloc/settings_bloc.dart';
import '../../backend/db/database.dart';
import '../../backend/model/mid/my_map.dart';

import 'package:collection/collection.dart';
import 'package:watmap/backend/model/mid/my_route.dart';
import '../../main.dart';
import '../../backend/repositories/location.dart';
import '../blocs/map_bloc/map_bloc.dart';

part 'clean_route.dart';
part 'find_route.dart';
part 'format_route_path.dart';

typedef Point = Vector2;
typedef Segment = List<Point>;

// constants for clean routes
const double EPS = 0.1;
const double PT_EPS = 1;

double STAIRS_COST = 30; // depends on usr settings, typically ~30
double OUTSIDE_COST_MULTIPLIER = 4; // if sunny, 1; if snow, this number
double WALK_SPEED = 4; // on map, needs more investigation.

<<<<<<< HEAD
=======

MyPath createMyPath(Location locA, Location locB, MyMap map) {
  return map.paths.firstWhere(
        (element) => (element.pointAId == locA.id && element.pointBId == locB.id),
    orElse: () => MyPath(
      id: 0,
      pointAId: locA.id,
      pointBId: locB.id,
      pathType: PATH_OUTSIDE,
    ),
  );
}

>>>>>>> 9654b3d (refactored UI, transvered to A*)
extension AlgorPath on MyPath {
  double typeMultiplier() {
    if (getIt<SettingsBloc>().state.weather == Weather.sunny) {
      return 1;
    }
    switch (pathType) {
      case PATH_INSIDE:
      case PATH_ELEVATOR:
      case PATH_TUNNEL:
      case PATH_BRIDGE:
        return 1;
      case PATH_BRIEFLY_OUTSIDE:
        return 1 + (OUTSIDE_COST_MULTIPLIER - 1) * 0.5;
      default:
        return OUTSIDE_COST_MULTIPLIER;
    }
  }

  bool isStair() {
    return pathType == PATH_STAIRS;
  }

  bool isBridgeOrTunnel() {
    return pathType == PATH_BRIDGE || pathType == PATH_TUNNEL;
  }

  List<Segment> getRoute(MyMap map) {
    if (pathType == PATH_STAIRS) {
      return [];
    }
    if (route == null || route == "null") {
      final a = map.locations.firstWhere((e) => e.id == pointAId);
      final b = map.locations.firstWhere((e) => e.id == pointBId);
      return [
        [
          Point(a.x.toDouble(), a.y.toDouble()),
          Point(b.x.toDouble(), b.y.toDouble()),
        ],
      ];
    }
    return (jsonDecode(route!) as List)
        .map<Segment>(
          (seg) =>
              (seg as List)
                  .map<Point>((q) => Point(q[0].toDouble(), q[1].toDouble()))
                  .toList(),
        )
        .where((seg) => (seg[0] - seg[1]).length > PT_EPS)
        .toList();
  }

  double getCost(MyMap map) {
    final a = map.locations.firstWhere((e) => e.id == pointAId);
    final b = map.locations.firstWhere((e) => e.id == pointBId);
    if (pathType == PATH_STAIRS) {
      return (a.floor - b.floor).abs() * 30;
    }
    // Otherwise use the Euclidean distance.
    double cost = a.distanceTo(b); // on need to use real, cause low speed
    // Penalize going outside.
    cost *= typeMultiplier();
    return cost;
  }

  double getTime(MyMap map) {
    final a = map.locations.firstWhere((e) => e.id == pointAId);
    final b = map.locations.firstWhere((e) => e.id == pointBId);
    if (pathType == PATH_STAIRS) {
      int floorDifference = (a.floor - b.floor).abs();
      return 50 + (floorDifference - 1) * 30;
    }
    // Otherwise use the Euclidean distance.
    final route = getRoute(map);
    double dist = 0;
    for (final seg in route) {
      dist += seg[0].distanceTo(seg[1]);
    }
    double time = dist / WALK_SPEED;
    return time;
  }
}

extension AlgorRoute on MyRoute {
  List<Segment> getRoute(MyMap map) {
    List<Segment> route = [];
    for (final p in paths) {
      if (p.pathType == PATH_STAIRS) continue;
      route.addAll(p.getRoute(map));
    }
    return route;
  }

  double getTime(MyMap map) {
    double time = 0;
    for (final path in paths) {
      time += path.getTime(map);
    }
    return time;
  }

  int getStairsCount() {
    int stairsCount = 0;
    for (final path in paths) {
      if (path.pathType == PATH_STAIRS) {
        stairsCount++;
      }
    }
    return stairsCount;
  }

  int getBridgeOrTunnelCount() {
    int bridgeOrTunnel = 0;
    for (final path in paths) {
      if (path.isBridgeOrTunnel()) {
        bridgeOrTunnel++;
      }
    }
    return bridgeOrTunnel;
  }
}
