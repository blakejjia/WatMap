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
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(_formatRoute(state)),
        ),
      ),
    ),
  );
}

String _formatRoute(MapFoundRoute state) {
  String output = "";

  if (state.route.paths.isEmpty) {
    return "No route found";
  }

  // Starting point
  Location? startPoint = state.map.locations.firstWhere(
    (element) => element.id == state.route.paths[0].pointAId,
  );
  output += "Starting at ${startPoint.name}\n";

  for (var path in state.route.paths) {
    output += "${_formatPath(path, state.map)}\n";
  }

  // Ending point
  Location? endPoint = state.map.locations.firstWhere(
    (element) =>
        element.id == state.route.paths[state.route.paths.length - 1].pointBId,
  );
  output += "Ending at ${endPoint.name}\n";

  return output;
}

String _formatPath(MyPath path, MyMap map) {
  String output = "";
  Location pointA = map.locations.firstWhere(
    (element) => element.id == path.pointAId,
  );
  Location pointB = map.locations.firstWhere(
    (element) => element.id == path.pointBId,
  );
  switch (path.pathType) {
    case PATH_STAIRS:
      output += "climb to ${pointB.name} Lv ${pointB.floor}";
      break;
    case PATH_BRIDGE:
      output += "${pointA.name} -> ${pointB.name} by bridge";
      break;
    // Add cases for other pathTypes here as needed
    case PATH_TUNNEL:
      output += "${pointA.name} -> ${pointB.name} by tunnel";
      break;
    default:
      output += "Unknown path type";
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
          ..color = Colors.blue
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
