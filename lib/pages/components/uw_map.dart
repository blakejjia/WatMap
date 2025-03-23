import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/db/database.dart';
import '../bloc/map_bloc.dart';

class UWMap extends StatelessWidget {
  const UWMap({super.key});

  List<Widget> _buildingMarkers(MapState state, BuildContext context) {
    switch (state.runtimeType) {
      case MapInitial:
        return [
          Center(
            child: ElevatedButton(
              onPressed: () => context.read<MapBloc>().add(MapLoad()),
              child: Text("load"),
            ),
          ),
        ];
      case MapIdeal:
        return [
          ...(state as MapIdeal).map.buildings.map((building) {
            return _buildings(building, context);
          }),
          ...state.selectedBuildings.map((building) {
            return _selectedWidget(building!, context);
          }),
          ...state.route?.paths.map((path) {
                return _path(state, path, context);
              }) ??
              [],
        ];

      default:
        return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MapBloc, MapState>(
      builder: (context, state) {
        return Stack(
          children: [
            Image.asset('assets/campusMap.png', fit: BoxFit.contain),
            ...(_buildingMarkers(state, context)),
          ],
        );
      },
    );
  }
}

Widget _buildings(Building building, BuildContext context) {
  return Positioned(
    left: building.x.toDouble(),
    top: building.y.toDouble(),
    child: IconButton(
      icon: Icon(Icons.circle, color: Colors.orange.withOpacity(0.3), size: 50),
      onPressed: () {
        context.read<MapBloc>().add(MapSelectBuilding(building));
      },
    ),
  );
}

Widget _selectedWidget(Building building, BuildContext context) {
  return Positioned(
    left: building.x.toDouble(),
    top: building.y.toDouble(),
    child: IconButton(
      icon: Icon(Icons.circle, color: Colors.red.withOpacity(1), size: 50),
      onPressed: () {
        context.read<MapBloc>().add(MapSelectBuilding(building));
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Clicked on ${building.name}'),
            duration: Duration(seconds: 2),
          ),
        );
      },
    ),
  );
}

Widget _path(MapIdeal state, MyPath path, BuildContext context) {
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
          ..moveTo(pointA.x.toDouble()+33, pointA.y.toDouble()+32)
          ..lineTo(pointB.x.toDouble()+33, pointB.y.toDouble()+32);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
