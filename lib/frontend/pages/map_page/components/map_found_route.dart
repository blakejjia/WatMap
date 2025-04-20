part of '../map_page.dart';

Widget _path(MapTriedFoundRoute state, MyRoute route, BuildContext context) {
  final segments = buildSegments(state.map, route);
  return CustomPaint(painter: FullRoutePainter(state.map, segments));
}

Widget _dialogBox(MapTriedFoundRoute state, BuildContext context) {
  return Positioned(
    left: 0,
    top: 0,
    child: InkWell(
      onTap: () {
        if (state.isFound) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => RoutePage(state)),
          );
        }
      },
      child: Container(
        margin: EdgeInsets.fromLTRB(
          8.0,
          8.0 + MediaQuery.of(context).padding.top,
          8.0,
          0,
        ),
        decoration: BoxDecoration(
          color: Colors.white.withAlpha(245),
          border: Border.all(color: Colors.black, width: 1.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child:
              (state.isFound)
                  ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Route found\n",
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      ...formatRoute(state).map(
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
                      Text(
                        (state.route.time != null)
                            ? "Time: ${Duration(seconds: state.route.time!.round()).inMinutes} minutes"
                            : "Cannot calculate time",
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  )
                  : Center(
                    child: Column(
                      children: [
                        Text(
                          "route not found",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text("If you believe this is wrong"),
                        Text("settings -> tell us a route"),
                      ],
                    ),
                  ),
        ),
      ),
    ),
  );
}

class FullRoutePainter extends CustomPainter {
  final MyMap map;
  final List<Segment> segments;
  FullRoutePainter(this.map, this.segments);

  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
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
