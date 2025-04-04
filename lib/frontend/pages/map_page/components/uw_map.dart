part of '../map_page.dart';

class UWMap extends StatelessWidget {
  const UWMap({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MapBloc, MapState>(
      buildWhen: (previous, current) => previous != current,
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

  List<Widget> _buildingMarkers(MapState state, BuildContext context) {
    switch (state.runtimeType) {
      case const (MapInitial):
        return [
          Center(
            child: ElevatedButton(
              onPressed: () => context.read<MapBloc>().add(MapLoad()),
              child: Text("load"),
            ),
          ),
        ];
      case const (MapIdeal):
        return [
          ...(state as MapIdeal).map.buildings.map((building) {
            return _buildings(building, context);
          }),
          ...state.selectedBuildings.map((building) {
            return _selectedWidget(building!, context);
          }),
        ];
      case const (MapFoundRoute):
        return [
          ...(state as MapFoundRoute).map.buildings.map((building) {
            return _buildings(building, context);
          }),
          ...state.selectedBuildings.map((building) {
            return _selectedWidget(building!, context);
          }),
          ...state.route.paths.map((path) {
            return _path(state, path, context);
          }),
        ];
      default:
        return [];
    }
  }
}
