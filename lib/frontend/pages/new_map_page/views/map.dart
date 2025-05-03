import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_tile_caching/flutter_map_tile_caching.dart';
import 'package:latlong2/latlong.dart';
import 'package:watmap/backend/db/database.dart';
import 'package:watmap/frontend/blocs/map_bloc/map_bloc.dart';
import 'package:watmap/main.dart';

import '../../../algorithm/algorithms.dart';
import '../route_page/route_page.dart';

part 'components/markers.dart';
part 'components/paths.dart';
part 'components/route_dialog.dart';

class OSMap extends StatefulWidget {
  const OSMap({super.key});

  @override
  State<OSMap> createState() => _OSMapState();
}

class _OSMapState extends State<OSMap> {
  final MapController controller = MapController();

  @override
  void initState() {
    super.initState();
    context.read<MapBloc>().add(MapLoad());
    controller.mapEventStream.listen((event) {
      getIt<MapBloc>().add(UpdateMapCameraState(event.camera));
    });
  }

  @override
  Widget build(BuildContext context) {
    final tileProvider = FMTCTileProvider(
      stores: const {'mapStore': BrowseStoreStrategy.readUpdateCreate},
    );

    return Stack(
      children: [
        FlutterMap(
          mapController: controller,
          options: MapOptions(
            initialCenter: LatLng(43.4723, -80.5449),
            initialZoom: 16.0,
            maxZoom: 18.0,
            minZoom: 15.0,
            initialRotation: 23,
          ),
          children: [
            TileLayer(
              urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
              userAgentPackageName: 'com.jia-yx.watmap',
              tileProvider: tileProvider,
            ),
            BlocBuilder<MapBloc, MapState>(
              builder: (context, state) {
                if (state is MapTriedFoundRoute) {
                  return PolylineLayer(polylines: _paths(state, context));
                }
                return const SizedBox();
              },
            ),
            BlocBuilder<MapBloc, MapState>(
              builder: (context, state) {
                final markers = _buildingMarkers(
                  context.read<MapBloc>().state,
                  context,
                );
                return MarkerLayer(markers: markers);
              },
            ),
          ],
        ),
        BlocBuilder<MapBloc, MapState>(
          builder: (context, state) {
            if (state is MapTriedFoundRoute) {
              return dialogBox(state, context);
            }
            return const SizedBox();
          },
        ),
      ],
    );
  }
}
