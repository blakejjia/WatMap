part of '../home_page.dart';

Widget _path(MapFoundRoute state, MyPath path, BuildContext context) {
  final pointA =
      state.map.locations
          .where((location) => location.id == path.pointAId)
          .first;
  final pointB =
      state.map.locations
          .where((location) => location.id == path.pointBId)
          .first;
  return CustomPaint(painter: PathPainter(pointA, pointB));
}

Widget _dialogBox(MapFoundRoute state, BuildContext context) {
  return Positioned(
    left: 0,
    top: 0,
    child: InkWell(
      onTap: (){
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

// TODO: better format route
String _formatRoute(MapFoundRoute state) {
  String output = "";

  if (state.route.paths.length == 0) {
    return "No route found";
  }

  // Starting point
  Location startPoint = state.map.locations.firstWhere((element) => element.id == state.route.paths[0].pointAId);
  output += "Starting at ${startPoint.name}\n";

  for (var path in state.route.paths) {
    output += "${_formatPath(path, state.map)}\n";
  }

  // ending point
  Location endPoint = state.map.locations.firstWhere((element) => element.id == state.route.paths[state.route.paths.length - 1].pointBId);
  output += "Ending at ${endPoint.name}\n";

  return output;
}

String _formatPath(MyPath path, MyMap map) {
  String output = "";
  Location pointA = map.locations.firstWhere((element) => element.id == path.pointAId);
  Location pointB = map.locations.firstWhere((element) => element.id == path.pointBId);
  if (path.pathType == PATH_STAIRS){
    output += "climb up ${pointB.floor - pointA.floor} floors to ${pointB.name}";
  }
  if (path.pathType == PATH_BRIDGE){
    output += "Take bridge from ${pointA.name.substring(0,3)} to ${pointB.name.substring(0,3)}";
  }
  return output;
}

class PathPainter extends CustomPainter {
  final Location pointA;
  final Location pointB;

  PathPainter(this.pointA, this.pointB);

  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = Colors.blue
          ..strokeWidth = 6.0
          ..style = PaintingStyle.stroke;

    final path =
        Path()
          ..moveTo(pointA.x.toDouble() + 33, pointA.y.toDouble() + 32)
          ..lineTo(pointB.x.toDouble() + 33, pointB.y.toDouble() + 32);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
