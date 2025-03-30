part of '../map_page.dart';

Widget _buildings(Building building, BuildContext context) {
  return Positioned(
    left: building.x.toDouble(),
    top: building.y.toDouble(),
    child: IconButton(
      icon: Icon(
        Icons.circle,
        color: Colors.orange.withValues(alpha: 0.3),
        size: 50,
      ),
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
      icon: Icon(
        Icons.circle,
        color: Colors.red.withValues(alpha: 0.3),
        size: 50,
      ),
      onPressed: () {
        context.read<MapBloc>().add(MapSelectBuilding(building));
      },
    ),
  );
}
