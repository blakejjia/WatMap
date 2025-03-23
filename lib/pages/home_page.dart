import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watmap/data/db/pourDb.dart';
import 'package:watmap/pages/bloc/map_bloc.dart';
// ignore: depend_on_referenced_packages
import 'package:vector_math/vector_math_64.dart' as vector_math;

import '../data/db/database.dart';

part './mapComponent/uw_map.dart';
part './mapComponent/map_ideal.dart';
part './mapComponent/map_found_route.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('WatMap'),
        actions: [
          IconButton(
            onPressed: () async {
              await pourDb();
              context.read<MapBloc>().add(MapLoad());
            },
            icon: Icon(Icons.refresh),
          ),
        ],
      ),
      body: Stack(
        children: [
          // THE MAP
          InteractiveViewer.builder(
            transformationController: TransformationController(
              Matrix4.identity()..translate(-2500.0, -1200.0),
            ),
            minScale: 0.1,
            builder: (BuildContext context, vector_math.Quad viewport) {
              return UWMap();
            },
          ),

          // ROUTE FOUND DIALOG
          BlocBuilder<MapBloc, MapState>(
            buildWhen:
                (prev, current) => prev.runtimeType != current.runtimeType,
            builder: (context, state) {
              if (state is MapFoundRoute) {
                return _dialogBox(state, context);
              }
              return Container();
            },
          ),
        ],
      ),
    );
  }
}
