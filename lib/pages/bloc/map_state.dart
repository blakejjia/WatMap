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

final class MapFoundRoute extends MapIdeal {
  final MyRoute route;

  const MapFoundRoute(List<Building?> selectedBuildings, this.route, MyMap map)
    : super(selectedBuildings, map);
}
