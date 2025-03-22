part of 'map_bloc.dart';

@immutable
sealed class MapEvent {}

final class MapLoad extends MapEvent{}

final class MapSelectBuilding extends MapEvent{
  final Building building;

  MapSelectBuilding(this.building);
}

