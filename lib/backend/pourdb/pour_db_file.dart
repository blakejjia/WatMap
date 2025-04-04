part of 'pour_db.dart';

Future<bool> pourDbFile() async {
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
      for (int j = i + 1; j < locations.length; j++) {
        // Upstairs
        await getIt<PathRepository>().createPath(
          MyPathsCompanion(
            pointAId: Value(locations[i]),
            pointBId: Value(locations[j]),
            pathType: Value(PATH_STAIRS),
            buildingId: Value(buildingId),
          ),
        );
        // Downstairs
        await getIt<PathRepository>().createPath(
          MyPathsCompanion(
            pointAId: Value(locations[j]),
            pointBId: Value(locations[i]),
            pathType: Value(PATH_STAIRS),
            buildingId: Value(buildingId),
          ),
        );
      }
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

  await Future.forEach(rowsAsListOfValues.skip(1), (row) async {
    try {
      //buildingA	floorA	buildingB	floorB	pathType
      int buildingA = await getIt<BuildingRepository>().getIdByName(
        row[0] as String,
      );
      int floorA = row[1] as int;
      int buildingB = await getIt<BuildingRepository>().getIdByName(
        row[2] as String,
      );
      int floorB = row[3] as int;

      Location locationA = await getIt<LocationRepository>().getLocation(
        buildingA,
        floorA,
      );
      Location locationB = await getIt<LocationRepository>().getLocation(
        buildingB,
        floorB,
      );
      // insert:
      await getIt<PathRepository>().createPath(
        MyPathsCompanion(
          pointAId: Value(locationA.id),
          pointBId: Value(locationB.id),
          pathType: Value(PATH_BRIDGE),
        ),
      );
      await getIt<PathRepository>().createPath(
        MyPathsCompanion(
          pointAId: Value(locationB.id),
          pointBId: Value(locationA.id),
          pathType: Value(PATH_BRIDGE),
        ),
      );
    } catch (e) {
      final logMessage = 'Error while rebuilding paths data: $e\nrow: $row\n';
      print(logMessage);
    }
  });
  return true;
}
