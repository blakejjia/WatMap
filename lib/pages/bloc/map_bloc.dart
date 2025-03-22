import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:watmap/data/model/mid/my_route.dart';

import '../../data/db/database.dart';
import '../../data/db/repositories/building.dart';
import '../../main.dart';

part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  MapBloc() : super(MapInitial()) {
    on<MapLoad>(_mapLoad);
    on<MapSelectBuilding>(_mapSelectBuilding);
    add(MapLoad());
  }

  void _mapLoad(MapLoad event, Emitter<MapState> emit) async {
    final buildings = await getIt<BuildingRepository>().readAllBuildings();
    emit(MapIdeal(buildings, [], null));
  }

  void _mapSelectBuilding(MapSelectBuilding event, Emitter<MapState> emit) {
    int count = (state as MapIdeal).selectedBuildings.length;
    if (count == 2) {
      // If there are already two buildings selected, clear the list
      emit((state as MapIdeal).copyWith(selectedBuildings: [event.building]));
    } else {
      // otherwise, add the building to the list
      emit(
        (state as MapIdeal).copyWith(
          selectedBuildings: [
            ...(state as MapIdeal).selectedBuildings
                .where((b) => b != null)
                .cast<Building>(),
            event.building,
          ],
        ),
      );
    }
  }
}
