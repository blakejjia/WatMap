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

  bool isStair() {
    return pathType == PATH_STAIRS;
  }

  List<Segment> getRoute(MyMap map) {
    if (route == null) {
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

  // TODO: customize according to getCost
  double getCost(MyMap map) {
    final a = map.locations.firstWhere((e) => e.id == pointAId);
    final b = map.locations.firstWhere((e) => e.id == pointBId);
    if (pathType == PATH_STAIRS) {
      return (a.floor - b.floor).abs() * 30;
    }
    // Otherwise use the Euclidean distance.
    double cost = a.distanceTo(b);
    // Penalize going outside.
    if (!isInside()) {
      cost *= 1.5;
    }
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
    final route = getRoute(getIt<MapBloc>().state.map);
    double dist = 0;
    for (final seg in route) {
      dist += seg[0].distanceTo(seg[1]);
    }
    double time = dist * 0.15;
    return time;
  }
}

extension MyRouuteExtension on MyRoute {
  double getTime() {
    double time = 0;
    for (final path in paths) {
      time += path.getTime(getIt<MapBloc>().state.map);
    }
    time += 60; // prepare to go
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

  List<Segment> getRoute(MyMap map) {
    List<Segment> route = [];
    for (final p in paths) {
      if (p.pathType == PATH_STAIRS) continue;
      route.addAll(p.getRoute(map));
    }
    return route;
  }
}
