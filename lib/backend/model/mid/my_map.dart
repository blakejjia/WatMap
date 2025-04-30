import '../../db/database.dart';

class MyMap {
  /// read db to memory to ensure get all data
  final List<Building> buildings;
  final List<Location> locations;
  final List<MyPath> paths;

  const MyMap(this.buildings, this.locations, this.paths);
}
