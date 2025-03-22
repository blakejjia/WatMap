import 'dart:io';
import 'package:csv/csv.dart';
import 'package:drift/drift.dart';
import 'package:flutter/services.dart';
import 'package:watmap/data/db/database.dart';
import 'package:watmap/data/db/repositories/building.dart';
import 'package:watmap/data/db/repositories/location.dart';
import 'package:watmap/data/db/repositories/path.dart';
import 'package:watmap/pages/bloc/map_bloc.dart';

import '../../main.dart';
import '../model/base/path.dart';

Future<bool> pourDb() async {
  // Check if there is existing data in the database
  // TODO: This is a temporary solution. We need to implement a better way to check if the database is empty.
  final existingBuildings =
      await getIt<BuildingRepository>().readAllBuildings();
  if (existingBuildings.isNotEmpty) {
    return false;
  }

  // Destroy existing data
  await getIt<BuildingRepository>().destroyAllBuildings();
  await getIt<LocationRepository>().destroyAllLocations();
  await getIt<PathRepository>().destroyAllPaths();

  // buildings table ----------------------------------------------------------------
  final buildingsData = await rootBundle.loadString(
    'assets/mapDat/buildings.csv',
  );
  List<List<dynamic>> rowsAsListOfValues = const CsvToListConverter().convert(
    buildingsData,
  );

  List<BuildingsCompanion> buildings =
      rowsAsListOfValues.skip(1).map((row) {
        return BuildingsCompanion(
          id: Value(row[0] as int),
          name: Value(row[1] as String),
          floor: Value(row[2] as int),
          mainFloor: Value(row[3] as int),
          x: Value(row[4] as int),
          y: Value(row[5] as int),
        );
      }).toList();

  // insert:
  await Future.forEach(buildings, (building) async {
    // S1: insert building
    final int buildingId = await getIt<BuildingRepository>().createBuilding(
      building,
    );

    // S2: In Locations table: location for each floor of building
    List<int> locations = [];
    for (int i = 1; i <= building.floor.value; i++) {
      final insertedLocation = await getIt<LocationRepository>().createLocation(
        LocationsCompanion(
          buildingId: Value(building.id.value),
          name: Value('${building.name.value} Floor $i'),
          floor: Value(i),
          x: Value(building.x.value),
          y: Value(building.y.value),
        ),
      );
      locations.add(insertedLocation);
    }

    // S3: In Path table: path of stairs
    for (int i = 0; i < locations.length - 1; i++) {
      await getIt<PathRepository>().createPath(
        PathsCompanion(
          pointAId: Value(locations[i]),
          pointBId: Value(locations[i + 1]),
          pathType: Value(PATH_STAIRS),
          buildingId: Value(buildingId),
        ),
      );
    }
  });

  // locations table ----------------------------------------------------------------
  final locationsData = await rootBundle.loadString(
    'assets/mapDat/locations.csv',
  );
  rowsAsListOfValues = const CsvToListConverter().convert(locationsData);

  // insert:
  await Future.forEach(rowsAsListOfValues.skip(1), (row) async {
    await getIt<LocationRepository>().createLocation(
      LocationsCompanion(
        buildingId: Value(row[0] as int),
        name: Value(row[1] as String),
        floor: Value(row[2] as int),
        x: Value(row[3] as int),
        y: Value(row[4] as int),
      ),
    );
  });

  // paths table ----------------------------------------------------------------
  final pathsData = await rootBundle.loadString('assets/mapDat/paths.csv');
  rowsAsListOfValues = const CsvToListConverter().convert(pathsData);

  // insert:
  await Future.forEach(rowsAsListOfValues.skip(1), (row) async {
    await getIt<PathRepository>().createPath(
      PathsCompanion(
        pointAId: Value(row[0] as int),
        pointBId: Value(row[1] as int),
        pathType: Value(row[2] as int),
        buildingId: Value(row[3] as int),
      ),
    );
  });

  return true;
}
