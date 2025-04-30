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
          height: 80,
          width: 40,
          child: _buildings(building, scalar, rotation, context, false),
        );
      }),
      ...state.selectedBuildings.map((building) {
        return Marker(
          point: LatLng(building!.lat, building.lng),
          width: 40,
          height: 80,
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
  double scaler,
  double rotation,
  BuildContext context,
  bool isSelected,
) {
  return Transform(
    alignment: Alignment.center,
    transform:
        Matrix4.identity()
          ..scale(scaler)
          ..rotateZ(rotation),
    child: Stack(
      children: [
        IconButton(
          icon: Icon(
            Icons.location_on,
            color:
                isSelected
                    ? Theme.of(context).colorScheme.error
                    : Theme.of(context).colorScheme.primary,
            size: 20,
          ),
          onPressed: () {
            context.read<MapBloc>().add(MapSelectBuilding(building));
          },
        ),
        Positioned(
          top: 30,
          left: 15,
          child: Text(
            building.name,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    ),
  );
}
