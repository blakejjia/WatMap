part of '../map_page.dart';

Widget _path(
    MapFoundRoute state,
    List<MyPath> paths,
    BuildContext context,
    ) {
  final segments = buildSegments(state.map, paths);
  return CustomPaint(
    painter: FullRoutePainter(state.map, segments),
  );
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

class FullRoutePainter extends CustomPainter {
  final MyMap map;
  final List<Segment> segments;
  FullRoutePainter(this.map, this.segments);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFDCA1FF)
      ..strokeWidth = 6
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final path = Path();
    for (final seg in segments) {
      path.moveTo(seg[0].x, seg[0].y);
      path.lineTo(seg[1].x, seg[1].y);
    }
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

