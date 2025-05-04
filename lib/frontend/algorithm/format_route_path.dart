part of 'algorithms.dart';

List<List<String>> formatRoute(MapTriedFoundRoute state) {
  List<List<String>> output = [];

  if (state.route.paths.isEmpty) {
    return [
      ["", "No route found"],
    ];
  }

  // Starting point
  Location startPoint = state.map.locations.firstWhere(
    (element) => element.id == state.route.paths[0].locAId,
  );
  output.add(["Starting at \n", "${startPoint.toReadableString()}\n"]);

  int counter = 1;
  for (var i = 0; i < state.route.paths.length; i++) {
    var path = state.route.paths[i];
    var formattedPath = path.toListString(state.map);
    if (formattedPath.isEmpty) continue;
    output.add(["$counter.", ...formattedPath]);
    counter++;
  }

  // Ending point
  Location endPoint = state.map.locations.firstWhere(
    (element) =>
        element.id == state.route.paths[state.route.paths.length - 1].locBId,
  );
  output.add(["Ending at", (endPoint.toReadableString())]);

  return output;
}


