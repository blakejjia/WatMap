import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../data/db/repositories/building.dart';
import '../../main.dart';

class UWMap extends StatefulWidget {
  const UWMap({super.key});

  @override
  State<UWMap> createState() => _UWMapState();
}

class _UWMapState extends State<UWMap> {
  List<Widget> _buildingMarkers = [];

  @override
  void initState() {
    super.initState();
    _loadBuildingData();
  }

  Future<void> _loadBuildingData() async {
    final buildings = await getIt<BuildingRepository>().readAllBuildings();
    print(buildings);
    setState(() {
      _buildingMarkers = buildings.map((building) {
        return Positioned(
          left: building.x.toDouble(),
          top: building.y.toDouble(),
          child: IconButton(
            icon: Icon(Icons.circle, color: Colors.orange.withOpacity(0.3), size: 50),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Clicked on ${building.name}'),
                  duration: Duration(seconds: 2),
                ),
              );
            },
          ),
        );
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          'assets/campusMap.png',
          fit: BoxFit.contain,
        ),
        ..._buildingMarkers,
      ],
    );
  }
}

