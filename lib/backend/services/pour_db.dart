import 'package:drift/drift.dart';
import 'package:watmap/backend/model/base/path_raw.dart';
import 'package:watmap/backend/services/SupaService.dart';

import '../../main.dart';
import '../db/database.dart';
import '../model/base/my_path.dart';
import '../repositories/building.dart';
import '../repositories/location.dart';
import '../repositories/path.dart';

Future<bool> pourDb() async {
  await getIt<BuildingRepository>().destroyAllBuildings();
  await getIt<LocationRepository>().destroyAllLocations();
  await getIt<PathRepository>().destroyAllPaths();
  // buildings table ----------------------------------------------------------------
  try {
    List<Building> buildings = await getIt<SupaService>().getBuildings();

    // insert:
    await Future.forEach(buildings, (building) async {
      // S1: insert building
      final int buildingId = await getIt<BuildingRepository>().createBuilding(
        BuildingsCompanion(
          name: Value(building.name),
          floor: Value(building.floor),
          x: Value(building.x),
          y: Value(building.y),
        ),
      );

      // S2: In Locations table: location for each floor of building
      List<int> locations = [];
      for (int i = 0; i <= building.floor; i++) {
        LocationsCompanion location = LocationsCompanion(
          name: Value(building.name),
          floor: Value(i),
          x: Value(building.x),
          y: Value(building.y),
          buildingId: Value(buildingId),
        );
        final insertedLocation = await getIt<LocationRepository>()
            .createLocation(location);
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
  } catch (e, stack) {
    print('Error while rebuilding buildings data: $e');
    print(stack);
    return false;
  }

  // locations table ----------------------------------------------------------------
  try {
    List<Location> locations = await getIt<SupaService>().getLocations();
    await Future.forEach(locations, (location) async {
      await getIt<LocationRepository>().createLocation(
        LocationsCompanion(
          buildingId: Value(location.buildingId),
          name: Value(location.name),
          floor: Value(location.floor),
          x: Value(location.x),
          y: Value(location.y),
        ),
      );
    });
  } catch (e, stack) {
    print('Error while rebuilding locations data: $e');
    print(stack);
    return false;
  }

  // paths table ----------------------------------------------------------------
  try {
    List<RawPath> paths = await getIt<SupaService>().getPaths();
    await Future.forEach(paths, (path) async {
      // convert raw path to path
      final pointAId = await getLocationId(path.buildingA, path.floorA);
      final pointBId = await getLocationId(path.buildingB, path.floorB);
      // insert
      await getIt<PathRepository>().createPath(
        MyPathsCompanion(
          pointAId: Value(pointAId),
          pointBId: Value(pointBId),
          pathType: Value(prasePathType(path.pathType)),
          route: Value(path.route.toString()),
        ),
      );
      await getIt<PathRepository>().createPath(
        MyPathsCompanion(
          pointAId: Value(pointBId),
          pointBId: Value(pointAId),
          pathType: Value(prasePathType(path.pathType)),
          route: Value(path.route.toString()),
        ),
      );
    });
  } catch (e, stack) {
    print('Error while rebuilding paths data: $e');
    print(stack);
    return false;
  }
  return true;
}

int prasePathType(String pathType) {
  switch (pathType) {
    case 'STAIRS':
      return PATH_STAIRS;
    case 'ELEVATOR':
      return PATH_ELEVATOR;
    case 'OUTSIDE':
      return PATH_OUTSIDE;
    case 'INSIDE':
      return PATH_INSIDE;
    case 'TUNNEL':
      return PATH_TUNNEL;
    case 'BRIDGE':
      return PATH_BRIDGE;
    case 'BRIEFLY_OUTSIDE':
      return PATH_BRIEFLY_OUTSIDE;
    default:
      throw ArgumentError('Invalid path type: $pathType');
  }
}

Future<int> getLocationId(String buildingName, int floor) async {
  final buildingId = await getIt<BuildingRepository>().getIdByName(
    buildingName,
  );
  final location = await getIt<LocationRepository>().getLocation(
    buildingId,
    floor,
  );
  return location?.id ?? -1;
}
