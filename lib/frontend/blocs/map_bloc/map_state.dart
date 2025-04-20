part of 'map_bloc.dart';

@immutable
sealed class MapState {
  final MyMap map;

  const MapState(this.map);
}

final class MapInitial extends MapState {
  const MapInitial(super.map);
}

final class MapIdeal extends MapState {
  final List<Building?> selectedBuildings;

  const MapIdeal(this.selectedBuildings, MyMap map) : super(map);
}

/// State where route finding is used
/// CAN BE ROUTE NOT FOUND
final class MapTriedFoundRoute extends MapIdeal {
  final MyRoute route;
  final bool isFound;

  const MapTriedFoundRoute(List<Building?> selectedBuildings, this.route, this.isFound, MyMap map)
    : super(selectedBuildings, map);
}
