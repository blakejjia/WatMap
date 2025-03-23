part of 'map_bloc.dart';

@immutable
sealed class MapState {}

final class MapInitial extends MapState {
  final MyMap map;

  MapInitial(this.map);
}

final class MapIdeal extends MapState {
  final List<Building?> selectedBuildings;
  final MyRoute? route;
  final MyMap map;

  MapIdeal(this.selectedBuildings, this.route, this.map);

  copyWith({
    List<Building>? selectedBuildings,
    MyRoute? route,
    MyMap? map,
  }) {
    return MapIdeal(
      selectedBuildings ?? this.selectedBuildings,
      route,
      map ?? this.map,
    );
  }
}
