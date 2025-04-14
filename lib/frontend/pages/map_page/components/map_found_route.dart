part of '../map_page.dart';

Widget _path(MapFoundRoute state, MyPath path, BuildContext context) {
  return CustomPaint(painter: PathPainter(state.map, path));
}

Widget _dialogBox(MapFoundRoute state, BuildContext context) {
  return Positioned(
    left: 0,
    top: 0,
    child: InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => RoutePage(state)),
        );
      },
      child: Container(
        margin: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white.withAlpha(245),
          border: Border.all(color: Colors.black, width: 1.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Route found\n",
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
              ),

              ..._formatRoute(state).map(
                (e) => Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:
                      e
                          .map(
                            (text) =>
                                e.indexOf(text) == e.length - 1
                                    ? Text(
                                      text,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )
                                    : Text("$text "),
                          )
                          .toList(),
                ),
              ),
              const Text(
                "\n Click here for details",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

List<List<String>> _formatRoute(MapFoundRoute state) {
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
  output.add(["Starting at \n", "${startPoint.name}\n"]);

  for (var i = 0; i < state.route.paths.length; i++) {
    var path = state.route.paths[i];
    output.add(["${i + 1}.", ..._formatPath(path, state.map)]);
  }

  // Ending point
  Location? endPoint = state.map.locations.firstWhere(
    (element) =>
        element.id == state.route.paths[state.route.paths.length - 1].pointBId,
  );
  output.add(["Ending at", (endPoint.name)]);

  return output;
}

// output[-1] will be blooded
List<String> _formatPath(MyPath path, MyMap map) {
  List<String> output = [];
  Location pointA = map.locations.firstWhere(
    (element) => element.id == path.pointAId,
  );
  Location pointB = map.locations.firstWhere(
    (element) => element.id == path.pointBId,
  );
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
    default:
      output.add("Unknown path type");
      break;
  }
  return output;
}

class PathPainter extends CustomPainter {
  final MyMap map;
  final MyPath path;
  PathPainter(this.map, this.path);

  @override
  void paint(Canvas canvas, Size size) {
    var paint =
        Paint()
          ..color = Color.fromARGB(255, 220, 161, 255)
          ..strokeWidth = 6.0
          ..style = PaintingStyle.stroke
          ..strokeCap = StrokeCap.round;

    var drawingPath = Path();

    if (path.route != null && path.route!.isNotEmpty && path.route != "null") {
      // Parse the route string into a list of segments, each containing two points
      List<List<List<int>>> routeSegments = List<List<List<int>>>.from(
        jsonDecode(path.route!).map(
          (segment) => List<List<int>>.from(
            segment.map((point) => List<int>.from(point)),
          ),
        ),
      );

      for (var segment in routeSegments) {
        if (segment.length >= 2) {
          // Start drawing from the first point of the segment
          drawingPath.moveTo(
            segment[0][0].toDouble(),
            segment[0][1].toDouble(),
          );

          // Draw lines connecting all points in the segment
          for (int i = 1; i < segment.length; i++) {
            drawingPath.lineTo(
              segment[i][0].toDouble(),
              segment[i][1].toDouble(),
            );
          }
        }
      }
    } else {
      // Fallback to drawing a line between pointA and pointB
      Location? pointA = map.locations.firstWhere(
        (location) => location.id == path.pointAId,
      );
      Location? pointB = map.locations.firstWhere(
        (location) => location.id == path.pointBId,
      );

      drawingPath
        ..moveTo(pointA.x.toDouble(), pointA.y.toDouble())
        ..lineTo(pointB.x.toDouble(), pointB.y.toDouble());
    }

    // Draw the path on the canvas
    canvas.drawPath(drawingPath, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
