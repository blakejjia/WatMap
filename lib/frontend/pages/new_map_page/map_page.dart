import 'package:flutter/material.dart';
import 'package:watmap/frontend/pages/new_map_page/views/components/actions.dart';
import 'package:watmap/frontend/pages/new_map_page/views/map.dart';

class WatMapPage extends StatelessWidget {
  const WatMapPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [const WatMap(), const MapActions()]),
    );
  }
}
