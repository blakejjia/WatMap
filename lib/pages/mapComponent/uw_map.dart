part of '../home_page.dart';

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
          })
        ];
      case MapFoundRoute:
        return [
          ...(state as MapFoundRoute).map.buildings.map((building) {
            return _buildings(building, context);
          }),
          ...state.selectedBuildings.map((building) {
            return _selectedWidget(building!, context);
          }),
          ...state.route.paths.map((path) {
            return _path(state, path, context);
          })
        ];
      default:
        return [];
    }
  }

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
}
