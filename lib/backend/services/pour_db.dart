import 'package:watmap/backend/services/supa_service.dart';
import '../../main.dart';
import '../repositories/building.dart';
import '../repositories/location.dart';
import '../repositories/path.dart';

Future<bool> pourDb() async {
  await getIt<BuildingRepository>().destroyAllBuildings();
  await getIt<LocationRepository>().destroyAllLocations();
  await getIt<PathRepository>().destroyAllPaths();

  try {
    await getIt<BuildingRepository>().insertAllBuildings(
      await getIt<SupaService>().getBuildings(),
    );
    await getIt<LocationRepository>().insertAllLocations(
      await getIt<SupaService>().getLocations(),
    );
    await getIt<PathRepository>().insertAllPaths(
      await getIt<SupaService>().getPaths(),
    );
  } catch (e) {
    return false;
  }
  return true;
}

