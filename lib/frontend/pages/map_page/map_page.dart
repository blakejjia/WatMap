import 'package:flutter/material.dart';
import 'package:watmap/frontend/pages/map_page/views/map.dart';

import 'components/actions.dart';

class WatMapPage extends StatelessWidget {
  const WatMapPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [const OSMap(), const MapActions()]),
    );
  }
}
