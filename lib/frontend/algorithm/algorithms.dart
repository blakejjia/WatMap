import 'package:latlong2/latlong.dart';
import 'package:uuid/uuid.dart';
import 'package:watmap/backend/model/base/my_path.dart';
import 'package:watmap/frontend/blocs/settings_bloc/settings_bloc.dart';
import '../../backend/db/database.dart';
import '../../backend/model/mid/my_map.dart';

// ignore: depend_on_referenced_packages
import 'package:collection/collection.dart';
import 'package:watmap/backend/model/mid/my_route.dart';
import '../../main.dart';
import '../app_strings.dart';
import '../blocs/map_bloc/map_bloc.dart';

part 'find_route.dart';
part 'format_route_path.dart';

MyPath createMyPath(Location locA, Location locB, MyMap map) {
  for (final element in map.paths) {
    // 正向匹配
    if (element.locAId == locA.id && element.locBId == locB.id) {
      return element;
    }

    // 反向匹配
    if (element.locAId == locB.id && element.locBId == locA.id) {
      List<dynamic> originalRoute = element.route?["route"] ?? [];
      List<dynamic> reversedRoute = List.from(originalRoute.reversed);

      return MyPath(
        id: const Uuid().v4(),
        locAId: locA.id,
        locBId: locB.id,
        buildingId: element.buildingId,
        pathType: element.pathType,
        route: {"route": reversedRoute},
      );
    }
  }

  throw Exception("No path found between ${locA.id} and ${locB.id}");
}

extension AlgorPath on MyPath {
  double typeMultiplier() {
    if (getIt<SettingsBloc>().state.weather == Weather.sunny) {
      return 1;
    }
    switch (pathType) {
      case PATH_INSIDE:
      case PATH_TUNNEL:
      case PATH_BRIDGE:
        return 1;
      case PATH_BRIEFLY_OUTSIDE:
        return 1 + (AppStrings.outsideCostMultiplier - 1) * 0.2;
      default:
        return AppStrings.outsideCostMultiplier;
    }
  }

  bool isStair() {
    return pathType == PATH_STAIRS;
  }

  bool isBridgeOrTunnel() {
    return pathType == PATH_BRIDGE || pathType == PATH_TUNNEL;
  }

  List<LatLng> getRoute(MyMap map) {
    if (pathType == PATH_STAIRS) {
      return [];
    }
    if (route == null || route!["route"] == null || route!["route"].isEmpty) {
      final a = map.locations.firstWhere((e) => e.id == locAId);
      final b = map.locations.firstWhere((e) => e.id == locBId);
      return [LatLng(a.lat, a.lng), LatLng(b.lat, b.lng)];
    }
    return (route!["route"] as List)
        .map<LatLng>((p) => LatLng(p[0], p[1]))
        .toList();
  }

  double getCost(MyMap map) {
    final a = map.locations.firstWhere((e) => e.id == locAId);
    final b = map.locations.firstWhere((e) => e.id == locBId);
    if (pathType == PATH_STAIRS) {
      return (a.floor - b.floor).abs() * 30;
    }
    // Otherwise use the Euclidean distance.
    double cost = Distance().as(
      LengthUnit.Meter,
      LatLng(a.lat, a.lng),
      LatLng(b.lat, b.lng),
    );
    // Penalize going outside.
    cost *= typeMultiplier();
    return cost;
  }

  double getTime(MyMap map) {
    final a = map.locations.firstWhere((e) => e.id == locAId);
    final b = map.locations.firstWhere((e) => e.id == locBId);
    if (pathType == PATH_STAIRS) {
      int floorDifference = (a.floor - b.floor).abs();
      return 50 + (floorDifference - 1) * 30;
    }
    // Otherwise use the Euclidean distance.
    final route = getRoute(map);
    double dist = 0;
    for (int i = 0; i < route.length - 1; i++) {
      dist += Distance().as(
        LengthUnit.Meter,
        route[i],
        route[i+1],
      );
    }
    double time = dist / AppStrings.walkSpeed;
    return time;
  }
}

extension AlgorRoute on MyRoute {
  List<LatLng> getRoute(MyMap map) {
    List<LatLng> route = [];
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
