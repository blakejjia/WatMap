part of 'map_bloc.dart';

@immutable
sealed class MapState {
  final MyMap map;

  const MapState(this.map);
}

final class MapInitial extends MapState {
  MapInitial(MyMap map) : super(map);
}

final class MapIdeal extends MapState {
  final List<Building?> selectedBuildings;

  MapIdeal(this.selectedBuildings, MyMap map) : super(map);
}

final class MapFoundRoute extends MapIdeal {
  final MyRoute route;

  MapFoundRoute(List<Building?> selectedBuildings, this.route, MyMap map)
    : super(selectedBuildings, map);
}
