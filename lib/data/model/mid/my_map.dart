import '../../db/database.dart';

class MyMap {

  /// There are many buildings in the map
  final List<Building> buildings;

  /// There are many locations in the map
  final List<Location> locations;

  /// There are many paths in the map
  final List<Path> paths;

  MyMap(this.buildings, this.locations, this.paths);
}
