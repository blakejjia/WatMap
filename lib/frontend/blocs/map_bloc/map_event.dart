part of 'map_bloc.dart';

@immutable
sealed class MapEvent {}

final class MapLoad extends MapEvent {}

final class MapSelectBuilding extends MapEvent {
  final Building building;

  MapSelectBuilding(this.building);
}

final class _MapFindRoute extends MapEvent {
  final Building start;
  final Building end;

  _MapFindRoute(this.start, this.end);
}

final class UpdateCameraState extends MapEvent {
  final MapCamera camera;

  UpdateCameraState(this.camera);
}
