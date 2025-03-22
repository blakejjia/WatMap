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
          ... (state as MapIdeal).buildings.map((building) {
            return _buildings(building, context);
          }).toList(),
          ... (state as MapIdeal).selectedBuildings.map((building) {
            return _selectedWidget(building!, context);
          }).toList(),
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

Widget _buildings(Building building, BuildContext context){
  return Positioned(
    left: building.x.toDouble(),
    top: building.y.toDouble(),
    child: IconButton(
      icon: Icon(
        Icons.circle,
        color: Colors.orange.withOpacity(0.3),
        size: 50,
      ),
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

Widget _selectedWidget(Building building, BuildContext context){
  return Positioned(
    left: building.x.toDouble(),
    top: building.y.toDouble(),
    child: IconButton(
      icon: Icon(
        Icons.circle,
        color: Colors.red.withOpacity(1),
        size: 50,
      ),
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