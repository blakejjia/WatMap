part of '../map_page.dart';

Widget _buildings(Building building, BuildContext context) {
  return Positioned(
    // left: _offsetX(building.lat),
    // top: _offsetY(building.lng),
    child: IconButton(
      icon: Icon(
        Icons.circle,
        color: Theme.of(context).colorScheme.primary.withAlpha(10),
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
    // left: _offsetX(building.x),
    // top: _offsetY(building.y),
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
