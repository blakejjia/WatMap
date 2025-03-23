import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../../data/db/database.dart';
import '../../data/db/repositories/building.dart';
import '../../data/db/repositories/location.dart';
import '../../data/db/repositories/path.dart';
import '../../data/find_route.dart';
import '../../data/model/mid/my_map.dart';
import '../../data/model/mid/my_route.dart';
import '../../main.dart';

part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  MapBloc() : super(MapInitial(MyMap([], [], []))) {
    on<MapLoad>(_mapLoad);
    on<MapSelectBuilding>(_mapSelectBuilding);
    on<_MapFindRoute>(_mapFindRoute);
    add(MapLoad());
  }

  void _mapLoad(MapLoad event, Emitter<MapState> emit) async {
    final buildings = await getIt<BuildingRepository>().readAllBuildings();
    final locations = await getIt<LocationRepository>().readAllLocations();
    final paths = await getIt<PathRepository>().readAllPaths();
    emit(MapIdeal([], MyMap(buildings, locations, paths)));
  }

  void _mapSelectBuilding(MapSelectBuilding event, Emitter<MapState> emit) {
    // you have to init first
    if (state is MapInitial) {
      return;
    }

    // count how many we have already
    int count = (state as MapIdeal).selectedBuildings.length;
    if ((state as MapIdeal).selectedBuildings.contains(event.building)) {
      // If the building is already in the list, remove it
      emit(
        MapIdeal((state as MapIdeal).selectedBuildings
            .where((b) => b != event.building)
            .whereType<Building>()
            .toList(), state.map),
      );
    } else if (count == 2) {
      // If there are already two buildings selected, clear the list and route.
      emit(
        MapIdeal([event.building], state.map),
      );
    } else {
      // Find route when 2 is selected.
      emit(
        MapIdeal([
          ...(state as MapIdeal).selectedBuildings
              .where((b) => b != null)
              .cast<Building>(),
          event.building,
        ], state.map),
      );
      add(
        _MapFindRoute(
          (state as MapIdeal).selectedBuildings[0]!,
          event.building,
        ),
      );
    }
  }

  void _mapFindRoute(_MapFindRoute event, Emitter<MapState> emit) async {
    final route = await findRoute((state as MapIdeal).map, event.start, event.end);
    if (route == null){
      return;
    }
    emit(MapFoundRoute((state as MapIdeal).selectedBuildings, route, (state as MapIdeal).map));
  }
}
