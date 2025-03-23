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
  print("rendering dialog box");
  return Positioned(
    left: 0,
    top: 0,
    child: Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text('Route Found!'),
            // TODO: better format route
            Text(state.route.paths.toString())
          ],
        ),
      ),
    ),
  );
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
