part of 'pour_db.dart';

Future<bool> pourDbHttp() async {
  // buildings table ----------------------------------------------------------------
  try {
    List<BuildingsCompanion> buildings =
        await getIt<MapHttpService>().fetchBuildings();

    // insert:
    await Future.forEach(buildings, (building) async {
      // S1: insert building
      final int buildingId = await getIt<BuildingRepository>().createBuilding(
        building,
      );

      // S2: In Locations table: location for each floor of building
      List<int> locations = [];
      for (int i = 0; i <= building.floor.value; i++) {
        final insertedLocation = await getIt<LocationRepository>()
            .createLocation(
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
  } catch (e) {
    final logMessage = 'Error while rebuilding buildings data: $e';
    print(logMessage);
    return false;
  }

  // locations table ----------------------------------------------------------------
  try {
    List<LocationsCompanion> locations =
        await getIt<MapHttpService>().fetchLocations();
    await Future.forEach(locations, (location) async {
      await getIt<LocationRepository>().createLocation(location);
    });
  } catch (e) {
    final logMessage = 'Error while rebuilding buildings data: $e';
    print(logMessage);
    return false;
  }

  // paths table ----------------------------------------------------------------
  try {
    List<MyPathsCompanion> paths = await getIt<MapHttpService>().fetchPaths();
    await Future.forEach(paths, (path) async {
      await getIt<PathRepository>().createPath(path);
      await getIt<PathRepository>().createPath(
        MyPathsCompanion(
          pointAId: path.pointBId,
          pointBId: path.pointAId,
          pathType: path.pathType,
        ),
      );
    });
  } catch (e) {
    final logMessage = 'Error while rebuilding buildings data: $e';
    print(logMessage);
    return false;
  }

  return true;
}
