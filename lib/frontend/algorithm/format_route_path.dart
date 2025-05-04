part of 'algorithms.dart';

List<List<String>> formatRoute(MapTriedFoundRoute state) {
  List<List<String>> output = [];

  if (state.route.paths.isEmpty) {
    return [
      ["", "No route found"],
    ];
  }

  // Starting point
  Location? startPoint = state.map.locations.firstWhere(
    (element) => element.id == state.route.paths[0].locAId,
  );
  output.add(["Starting at \n", "${startPoint.name}\n"]);

  int counter = 1;
  for (var i = 0; i < state.route.paths.length; i++) {
    var path = state.route.paths[i];
    var formattedPath = _formatPath(path, state.map);
    if (formattedPath.isEmpty) continue;
    output.add(["$counter.", ...formattedPath]);
    counter++;
  }

  // Ending point
  Location? endPoint = state.map.locations.firstWhere(
    (element) =>
        element.id == state.route.paths[state.route.paths.length - 1].locBId,
  );
  output.add(["Ending at", (endPoint.name)]);

  return output;
}

// output[-1] will be blooded
List<String> _formatPath(MyPath path, MyMap map) {
  List<String> output = [];
  Location pointB = map.locations.firstWhere(
    (element) => element.id == path.locBId,
  );
  if (pointB.building_id == null) return output;
  switch (path.pathType) {
    case PATH_STAIRS:
      output.add("climb to");
      output.add("${pointB.name} (floor ${pointB.floor})");
      break;
    case PATH_BRIDGE:
      output.add("Take bridge to");
      output.add(pointB.name);
      break;
    case PATH_TUNNEL:
      output.add("Take tunnel to");
      output.add(pointB.name);
      break;
    case PATH_OUTSIDE:
      output.add("Go out side walk to");
      output.add(pointB.name);
      break;
    case PATH_INSIDE:
      output.add("Go straight through to");
      output.add(pointB.name);
    case PATH_BRIEFLY_OUTSIDE:
      output.add("Go briefly outside to");
      output.add(pointB.name);
      break;
    default:
      output.add("Unknown path type");
      break;
  }
  return output;
}

