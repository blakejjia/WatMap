part of '../map.dart';

List<Polyline> _paths(MapTriedFoundRoute state, BuildContext context) {
  if (state.route.paths.isEmpty) return [];
  List<LatLng> points = state.route.paths
      .expand((e) => e.getRoute(state.map))
      .toList();
  points.insert(0, LatLng(state.route.start.lat, state.route.start.lng));
  points.add(LatLng(state.route.end.lat, state.route.end.lng));
  return [
    Polyline(
      points: points,
      strokeWidth: 4.0,
      color: Colors.blue,
    ),
  ];
}


