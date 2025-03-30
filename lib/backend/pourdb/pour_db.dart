import 'package:csv/csv.dart';
import 'package:drift/drift.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:watmap/backend/db/database.dart';
import 'package:watmap/backend/model/base/my_path.dart';
import 'package:watmap/backend/pourdb/http.dart';
import 'package:watmap/backend/repositories/building.dart';
import 'package:watmap/backend/repositories/location.dart';
import 'package:watmap/backend/repositories/path.dart';
import 'package:watmap/frontend/pages/settings_page/Bloc/settings_bloc.dart';
import 'package:watmap/main.dart';

part 'pour_db_http.dart';
part 'pour_db_file.dart';

/// Pour data into the database from either a local file or a server.
/// 0 - pour data from server
/// 1 - pour data from local file
/// 2 - error
Future<int> pourDb({bool? isOnline}) async {
  Fluttertoast.showToast(msg: "rebuilding data, please wait...");

  // Destroy existing data
  await getIt<BuildingRepository>().destroyAllBuildings();
  await getIt<LocationRepository>().destroyAllLocations();
  await getIt<PathRepository>().destroyAllPaths();

  // check if server online
  final bool isOnline = await getIt<MapHttpService>().pingServer();

  if (isOnline) {
    // Attempt to fetch data from server
    if (await pourDbHttp()) {
      Fluttertoast.showToast(msg: "Database updated from server");
      return 0;
    }
  }

  // Fallback to fetching data from local file
  if (getIt<SettingsState>().lastServerRetriveTime == NEWUSER &&
      await pourDbFile()) {
    Fluttertoast.showToast(msg: "Database updated from local file");
    return isOnline ? 1 : 1; // 1 indicates local file success
  }

  // If all attempts fail
  Fluttertoast.showToast(msg: "Failed to fetch data from local file");
  return 2;
}
