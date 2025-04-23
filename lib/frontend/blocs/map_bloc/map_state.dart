part of 'map_bloc.dart';

class MapState {
  final MyMap map;
  final MapCamera camera;

  const MapState(this.map, {required this.camera});

  MapState copyWith({MyMap? map, MapCamera? camera}) {
    return MapState(map ?? this.map, camera: camera ?? this.camera);
  }
}

final class MapInitial extends MapState {
  const MapInitial({map = const MyMap([], [], []), required MapCamera camera})
    : super(map, camera: camera);

  @override
  MapInitial copyWith({MyMap? map, MapCamera? camera}) {
    return MapInitial(map: map ?? this.map, camera: camera ?? this.camera);
  }
}

final class MapIdeal extends MapState {
  final List<Building?> selectedBuildings;

  const MapIdeal(this.selectedBuildings, MyMap map, {required MapCamera camera})
    : super(map, camera: camera);

  @override
  MapIdeal copyWith({
    List<Building?>? selectedBuildings,
    MyMap? map,
    MapCamera? camera,
  }) {
    return MapIdeal(
      selectedBuildings ?? this.selectedBuildings,
      map ?? this.map,
      camera: camera ?? this.camera,
    );
  }
}

/// State where route finding is used
/// CAN BE ROUTE NOT FOUND
final class MapTriedFoundRoute extends MapIdeal {
  final MyRoute route;
  final bool isFound;

  const MapTriedFoundRoute(
    List<Building?> selectedBuildings,
    this.route,
    this.isFound,
    MyMap map, {
    required MapCamera camera,
  }) : super(selectedBuildings, map, camera: camera);

  @override
  MapTriedFoundRoute copyWith({
    List<Building?>? selectedBuildings,
    MyRoute? route,
    bool? isFound,
    MyMap? map,
    MapCamera? camera,
  }) {
    return MapTriedFoundRoute(
      selectedBuildings ?? this.selectedBuildings,
      route ?? this.route,
      isFound ?? this.isFound,
      map ?? this.map,
      camera: camera ?? this.camera,
    );
  }
}
