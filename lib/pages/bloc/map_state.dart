part of 'map_bloc.dart';

@immutable
sealed class MapState {}

final class MapInitial extends MapState {}

final class MapIdeal extends MapState{
  final List<Building> buildings;
  final List<Building?> selectedBuildings;
  final MyRoute? route;

  MapIdeal(this.buildings, this.selectedBuildings, this.route);

  copyWith({
    List<Building>? buildings,
    List<Building>? selectedBuildings,
    MyRoute? route,
  }) {
    return MapIdeal(
      buildings ?? this.buildings,
      selectedBuildings ?? this.selectedBuildings,
      route ?? this.route,
    );
  }
}