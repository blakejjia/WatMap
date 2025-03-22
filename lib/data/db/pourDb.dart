import 'dart:io';
import 'package:csv/csv.dart';
import 'package:drift/drift.dart';
import 'package:watmap/data/db/database.dart';
import 'package:watmap/data/db/repositories/building.dart';
import 'package:watmap/data/db/repositories/location.dart';
import 'package:watmap/data/db/repositories/path.dart';

import '../../main.dart';
import '../model/base/path.dart';

Future<bool> pourDb() async {

  // buildings table ----------------------------------------------------------------
  final buildingsData =
      await File('assets/mapDat/buildings.csv').readAsString();
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
  final locationsData =
      await File('assets/mapDat/locations.csv').readAsString();
  rowsAsListOfValues = const CsvToListConverter().convert(
    locationsData,
  );

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
  final pathsData = await File('assets/mapDat/paths.csv').readAsString();
  rowsAsListOfValues = const CsvToListConverter().convert(
    pathsData,
  );

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
