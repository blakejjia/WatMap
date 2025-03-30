import 'dart:convert';
import 'dart:io';
import 'package:csv/csv.dart';
import 'package:drift/drift.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:watmap/backend/db/database.dart';

import '../../main.dart';
import '../model/base/my_path.dart';
import '../repositories/building.dart';
import '../repositories/location.dart';

class MapHttpService {
  final String baseUrl;
  final Duration timeoutDuration = const Duration(seconds: 10);

  MapHttpService(this.baseUrl);

  Future<bool> pingServer() async {
    try {
      final response = await http
          .get(Uri.parse('$baseUrl/ping'))
          .timeout(timeoutDuration);
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<List<BuildingsCompanion>> fetchBuildings() async {
    final response = await http
        .get(Uri.parse('$baseUrl/buildings'))
        .timeout(timeoutDuration);
    if (response.statusCode == 200) {
      Fluttertoast.showToast(msg: "loading buildings data...");
      List<List<dynamic>> rowsAsListOfValues = const CsvToListConverter()
          .convert(jsonDecode(response.body)['message']);
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

      return buildings;
    } else {
      Fluttertoast.showToast(msg: "failed to load buildings data");
      throw HttpException('Failed to fetch data');
    }
  }

  Future<List<MyPathsCompanion>> fetchPaths() async {
    final response = await http
        .get(Uri.parse('$baseUrl/paths'))
        .timeout(timeoutDuration);
    if (response.statusCode == 200) {
      Fluttertoast.showToast(msg: "loading paths data...");
      List<List<dynamic>> rowsAsListOfValues = const CsvToListConverter()
          .convert(jsonDecode(response.body)['message']);
      List<MyPathsCompanion> paths = await Future.wait(
        rowsAsListOfValues.skip(1).map((row) async {
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
          return MyPathsCompanion(
            pointAId: Value(locationA.id),
            pointBId: Value(locationB.id),
            pathType: Value(processPathtype(row[4])),
          );
        }).toList(),
      );

      return paths;
    } else {
      Fluttertoast.showToast(msg: "failed to load paths data");
      throw HttpException('Failed to fetch data');
    }
  }

  Future<List<LocationsCompanion>> fetchLocations() async {
    final response = await http
        .get(Uri.parse('$baseUrl/locations'))
        .timeout(timeoutDuration);
    if (response.statusCode == 200) {
      Fluttertoast.showToast(msg: "loading locations data...");
      List<List<dynamic>> locationsData = const CsvToListConverter().convert(
        jsonDecode(response.body)['message'],
      );
      List<LocationsCompanion> locations =
          locationsData.skip(1).map((row) {
            return LocationsCompanion(
              buildingId: Value(row[0] as int),
              name: Value(row[1] as String),
              floor: Value(row[2] as int),
              x: Value(row[3] as int),
              y: Value(row[4] as int),
            );
          }).toList();

      return locations;
    } else {
      Fluttertoast.showToast(msg: "failed to load locations data");
      throw HttpException('Failed to fetch data');
    }
  }
}

int processPathtype(String pathType) {
  switch (pathType) {
    case 'INSIDE':
      return PATH_INSIDE;
    case 'OUTSIDE':
      return PATH_OUTSIDE;
    case 'STAIRS':
      return PATH_STAIRS;
    case 'ELECATOR':
      return PATH_ELEVATOR;
    case 'BRIDGE':
      return PATH_BRIDGE;
    case 'TUNNEL':
      return PATH_TUNNEL;
    default:
      return PATH_OUTSIDE; // Default value if none matchs
  }
}
