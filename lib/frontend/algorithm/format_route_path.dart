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
    (element) => element.id == state.route.paths[0].pointAId,
  );
  output.add(["Starting at \n", "${startPoint.buildingId}\n"]);

  for (var i = 0; i < state.route.paths.length; i++) {
    var path = state.route.paths[i];
    output.add(["${i + 1}.", ..._formatPath(path, state.map)]);
  }

  // Ending point
  Location? endPoint = state.map.locations.firstWhere(
    (element) =>
        element.id == state.route.paths[state.route.paths.length - 1].pointBId,
  );
  output.add(["Ending at", (endPoint.id)]);

  return output;
}

// output[-1] will be blooded
List<String> _formatPath(MyPath path, MyMap map) {
  List<String> output = [];
  Location pointB = map.locations.firstWhere(
    (element) => element.id == path.pointBId,
  );
  switch (path.pathType) {
    case PATH_STAIRS:
      output.add("climb to");
      output.add("${pointB.id} (floor ${pointB.floor})");
      break;
    case PATH_BRIDGE:
      output.add("Take bridge to");
      output.add(pointB.id);
      break;
    case PATH_TUNNEL:
      output.add("Take tunnel to");
      output.add(pointB.id);
      break;
    case PATH_OUTSIDE:
      output.add("Go out side walk to");
      output.add(pointB.id);
      break;
    case PATH_INSIDE:
      output.add("Go straight through to");
      output.add(pointB.id);
    case PATH_BRIEFLY_OUTSIDE:
      output.add("Go briefly outside to");
      output.add(pointB.id);
      break;
    default:
      output.add("Unknown path type");
      break;
  }
  return output;
}
