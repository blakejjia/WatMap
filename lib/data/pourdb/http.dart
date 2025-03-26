import 'dart:convert';
import 'dart:io';
import 'package:csv/csv.dart';
import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:watmap/data/db/database.dart';

import '../../main.dart';
import '../model/base/my_path.dart';
import '../repositories/building.dart';
import '../repositories/location.dart';

class MapHttpService {
  final String baseUrl;

  MapHttpService(this.baseUrl);

  Future<List<BuildingsCompanion>> fetchBuildings() async {
    final response = await http.get(Uri.parse('$baseUrl/uwmap/buildings'));
    if (response.statusCode == 200) {
      successToast();
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
      failedToast();
      throw HttpException('Failed to fetch data');
    }
  }

  Future<List<MyPathsCompanion>> fetchPaths() async {
    final response = await http.get(Uri.parse('$baseUrl/uwmap/paths'));
    if (response.statusCode == 200) {
      successToast();
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
            // TODO: PATH_BRIDGE turn to said in csv
            pathType: Value(PATH_BRIDGE),
          );
        }).toList(),
      );

      return paths;
    } else {
      failedToast();
      throw HttpException('Failed to fetch data');
    }
  }

  Future<List<LocationsCompanion>> fetchLocations() async {
    final response = await http.get(Uri.parse('$baseUrl/uwmap/locations'));
    if (response.statusCode == 200) {
      successToast();
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
      failedToast();
      throw HttpException('Failed to fetch data');
    }
  }
}

void successToast() {
  Fluttertoast.showToast(
    msg: "Success to fetch data",
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 2,
    backgroundColor: Colors.green,
    textColor: Colors.white,
    fontSize: 16.0,
  );
}

void failedToast() {
  Fluttertoast.showToast(
    msg: "Failed to fetch data",
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 2,
    backgroundColor: Colors.red,
    textColor: Colors.white,
    fontSize: 16.0,
  );
}
