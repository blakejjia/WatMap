part of '../home_page.dart';

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
      },
    ),
  );
}