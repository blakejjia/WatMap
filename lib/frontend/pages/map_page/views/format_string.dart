import 'package:watmap/backend/db/database.dart';
import 'package:watmap/backend/model/mid/my_route.dart';
import 'package:watmap/frontend/algorithm/algorithms.dart';

import '../../../../backend/model/base/my_path.dart';
import '../../../../backend/model/mid/my_map.dart';

extension StringPath on MyPath {
  /// the name will be the last of this list
  /// use for bold text
  List<String> toListString(MyMap map) {
    List<String> output = [];
    Location pointB = map.locations.firstWhere(
      (element) => element.id == locBId,
    );
    String locBName = pointB.name.split('-')[0];
    if (pointB.building_id == null) return output;
    switch (pathType) {
      case PATH_STAIRS:
        output.add("climb to");
        output.add("$locBName (floor ${pointB.floor})");
        break;
      case PATH_BRIDGE:
        output.add("Take bridge to");
        output.add(locBName);
        break;
      case PATH_TUNNEL:
        output.add("Take tunnel to");
        output.add(locBName);
        break;
      case PATH_OUTSIDE:
        output.add("Go out side walk to");
        output.add(locBName);
        break;
      case PATH_INSIDE:
        output.add("Go straight through to");
        output.add(locBName);
      case PATH_BRIEFLY_OUTSIDE:
        output.add("Go briefly outside to");
        output.add(locBName);
        break;
      default:
        output.add("Unknown path type");
        break;
    }
    return output;
  }

  toLocAString(MyMap map) {
    Location pointA = map.locations.firstWhere(
      (element) => element.id == locAId,
    );
    return "${pointA.name.split('-')[0]}(floor ${pointA.floor})";
  }

  toLocBString(MyMap map) {
    Location pointB = map.locations.firstWhere(
      (element) => element.id == locBId,
    );
    return "${pointB.name.split('-')[0]}(floor ${pointB.floor})";
  }
}

extension StringRoute on MyRoute {
  String toTimeString(MyMap map) {
    final time = getTime(map);
    final distance = getMeter(map);
    return "Time: ${Duration(seconds: time.round()).inMinutes} minutes, ${distance.round()} meters";
  }
}

extension StringLocation on Location{
  String toReadableString() {
    return "${name.split('-')[0]}(floor $floor)";
  }
}