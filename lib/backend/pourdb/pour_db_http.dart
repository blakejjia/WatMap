import 'package:drift/drift.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:watmap/backend/db/database.dart';
import 'package:watmap/backend/repositories/building.dart';
import 'package:watmap/backend/repositories/location.dart';
import 'package:watmap/backend/repositories/path.dart';

import '../../main.dart';
import '../model/base/my_path.dart';
import 'http.dart';

Future<bool> pourDbHttp() async {
  // Destroy existing data
  await getIt<BuildingRepository>().destroyAllBuildings();
  await getIt<LocationRepository>().destroyAllLocations();
  await getIt<PathRepository>().destroyAllPaths();

  // buildings table ----------------------------------------------------------------
  Fluttertoast.showToast(msg: "rebuilding data, please wait...");
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
  }

  Fluttertoast.showToast(msg: "Database updated successfully");
  return true;
}
