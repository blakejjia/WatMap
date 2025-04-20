import 'dart:convert';
import 'package:vector_math/vector_math.dart';
import 'package:watmap/backend/model/base/my_path.dart';
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
double OUTSIDE_COST_MULTIPLIER = 1.5; // if sunny, 1; if rain or snow, 1.5~2
double WALK_SPEED = 3; // on map, needs more investigation.

extension MyPathExtensions on MyPath {
  // TODO: customize according to getCost
  double typeMultiplier() {
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
    if(pathType == PATH_STAIRS) {return [];}
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

extension MyRouuteExtension on MyRoute {
  double getTime() {
    double time = 0;
    for (final path in paths) {
      time += path.getTime(getIt<MapBloc>().state.map);
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

  List<Segment> getRoute(MyMap map) {
    List<Segment> route = [];
    for (final p in paths) {
      if (p.pathType == PATH_STAIRS) continue;
      route.addAll(p.getRoute(map));
    }
    return route;
  }
}
