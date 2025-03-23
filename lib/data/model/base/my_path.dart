// ignore_for_file: constant_identifier_names

import 'package:drift/drift.dart';

const int PATH_OUTSIDE = 1;
const int PATH_INSIDE = 2;
const int PATH_STAIRS = 3;
const int PATH_ELEVATOR = 4;
const int PATH_TUNNEL = 5;
const int PATH_BRIDGE = 6;
const int PATH_BRIEFLY_OUTSIDE = 7;

@DataClassName('MyPath')
class MyPaths extends Table {
  /// Unique id of the Path
  IntColumn get id => integer().autoIncrement()();

  /// Starting and ending points of the path
  IntColumn get pointAId => integer()();
  IntColumn get pointBId => integer()();

  /// Type of the path
  IntColumn get pathType => integer()();
  IntColumn get buildingId => integer().nullable()();
}

// // functions for Path
// bool isInside(){
//   switch(pathType){
//     case PATH_INSIDE:
//     case PATH_STAIRS:
//     case PATH_ELEVATOR:
//     case PATH_TUNNEL:
//     case PATH_BRIDGE:
//       return true;
//     default:
//       return false;
//   }
// }
//
// double getCost(){
//   // The formula for the cost of taking a stair is 50 + 25*(number of floors)
//   if(pathType == PATH_STAIRS){
//     int floor1 = pointA.floor;
//     int floor2 = pointB.floor;
//     return (floor1 - floor2).abs() * 25 + 50;
//   }
//
//   // Other wise use the euclidean distance
//   double cost = 0;
//   cost = pointA.distanceTo(pointB);
//   // penalize going outside
//   // TODO: depends on mode: sunny or inside mode.
//   if (!isInside()){
//     cost *= 1.5;
//   }
//   return cost;
// }
