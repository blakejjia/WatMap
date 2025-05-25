import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_cancellable_tile_provider/flutter_map_cancellable_tile_provider.dart';
import 'package:flutter_map_tile_caching/flutter_map_tile_caching.dart';
import 'package:latlong2/latlong.dart';
import 'package:watmap/backend/db/database.dart';
import 'package:watmap/frontend/blocs/map_bloc/map_bloc.dart';
import 'package:watmap/frontend/blocs/settings_bloc/settings_bloc.dart';
import 'package:watmap/frontend/pages/map_page/views/format_string.dart';
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
    if (context.read<MapBloc>().state.map.buildings.isEmpty) {
      context.read<SettingsBloc>().add(UpdateDataEvent());
    }
  }

  @override
  Widget build(BuildContext context) {
    late FMTCTileProvider tileProvider;
    if (!kIsWeb) {
      tileProvider = FMTCTileProvider(
        stores: const {'mapStore': BrowseStoreStrategy.readUpdateCreate},
      );
    }

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
            cameraConstraint: CameraConstraint.containCenter(
              bounds: LatLngBounds(
                LatLng(43.46331506457337, -80.52699695774027),
                LatLng(43.4776931711855, -80.56239865789252),
              ),
            ),
          ),
          children: [
            TileLayer(
              urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
              userAgentPackageName: 'com.jia-yx.watmap',
              tileProvider:
                  kIsWeb ? CancellableNetworkTileProvider() : tileProvider,
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
