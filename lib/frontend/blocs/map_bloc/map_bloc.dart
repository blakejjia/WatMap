// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';

import '../../../backend/db/database.dart';
import '../../../backend/repositories/building.dart';
import '../../../backend/repositories/location.dart';
import '../../../backend/repositories/path.dart';
import '../../../backend/model/mid/my_map.dart';
import '../../../backend/model/mid/my_route.dart';
import '../../../main.dart';
import '../../algorithm/algorithms.dart';

part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  MapBloc() : super(MapInitial(camera: MapCamera.initialCamera(MapOptions()))) {
    on<MapLoad>(_mapLoad);
    on<MapSelectBuilding>(_mapSelectBuilding);
    on<_MapFindRoute>(_mapFindRoute);
    on<UpdateMapCameraState>(_mapChangeZoom);
    add(MapLoad());
  }

  void _mapChangeZoom(UpdateMapCameraState event, Emitter<MapState> emit) {
    emit(state.copyWith(camera: event.camera));
  }

  Future<void> _mapLoad(MapLoad event, Emitter<MapState> emit) async {
    final buildings = await getIt<BuildingRepository>().readAllBuildings();
    final locations = await getIt<LocationRepository>().readAllLocations();
    final paths = await getIt<PathRepository>().readAllPaths();
    emit(
      MapIdeal([], MyMap(buildings, locations, paths), camera: state.camera),
    );
  }

  void _mapSelectBuilding(MapSelectBuilding event, Emitter<MapState> emit) {
    if (state is MapInitial) return;

    final currentState = state as MapIdeal;
    final currentSelection = currentState.selectedBuildings;

    if (currentSelection.contains(event.building)) {
      // Remove the building
      final updated =
          currentSelection.where((b) => b != event.building).toList();

      emit(currentState.copyWith(selectedBuildings: updated));
    } else {
      List<Building> updated;
      if (currentSelection.length == 2) {
        // Clear and start over with new building
        updated = [event.building];
      } else {
        updated = [...currentSelection.whereType<Building>(), event.building];
      }

      emit(currentState.copyWith(selectedBuildings: updated));

      // Only add route if we have exactly 2 now
      if (updated.length == 2) {
        add(_MapFindRoute(updated[0], updated[1]));
      }
    }
  }

  void _mapFindRoute(_MapFindRoute event, Emitter<MapState> emit) async {
    final route = await findRoute(
      (state as MapIdeal).map,
      event.start,
      event.end,
    );
    bool isFound = false;
    if (route == null) return;
    if (route.isNotEmpty) {
      isFound = true;
    }
    emit(
      MapTriedFoundRoute(
        (state as MapIdeal).selectedBuildings,
        route,
        isFound,
        (state as MapIdeal).map,
        camera: state.camera,
      ),
    );
  }
}
