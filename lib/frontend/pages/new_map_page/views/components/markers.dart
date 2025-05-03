part of '../map.dart';

List<Marker> _buildingMarkers(MapState state, BuildContext context) {
  double scalar = max((state.camera.zoom - 15), 0.5);
  double rotation = -state.camera.rotation * pi / 180;

  if (state is MapIdeal || state is MapTriedFoundRoute) {
    return [
      ...(state as MapIdeal).map.buildings.map((building) {
        return Marker(
          point: LatLng(building.lat, building.lng),
          alignment: Alignment.center,
          height: 20,
          width: 20,
          child: _buildings(building, scalar, rotation, context, false),
        );
      }),
      ...state.selectedBuildings.map((building) {
        return Marker(
          point: LatLng(building!.lat, building.lng),
          width: 20,
          height: 20,
          child: _buildings(building, scalar, rotation, context, true),
        );
      }),
    ];
  } else {
    return [];
  }
}

Widget _buildings(
  Building building,
  double scalar,
  double rotation,
  BuildContext context,
  bool isSelected,
) {
  return Transform(
    alignment: Alignment.center,
    transform:
        Matrix4.identity()
          ..scale(scalar)
          ..rotateZ(rotation),
    child: InkWell(
      onTap: () {
        context.read<MapBloc>().add(MapSelectBuilding(building));
      },
      child: Stack(
        children: [
          Icon(
            Icons.circle,
            color:
                isSelected
                    ? Theme.of(context).colorScheme.error
                    : Theme.of(context).colorScheme.primary,
            size: 20,
          ),

          Center(
            child: Text(
              building.name,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 7,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
