import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watmap/data/db/pourDb.dart';
import 'package:watmap/pages/bloc/map_bloc.dart';
import 'package:watmap/pages/components/uw_map.dart';
// ignore: depend_on_referenced_packages
import 'package:vector_math/vector_math_64.dart';

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
      body: InteractiveViewer.builder(
        transformationController: TransformationController(
          Matrix4.identity()..translate(-2500.0, -1200.0),
        ),
        minScale: 0.1,
        builder: (BuildContext context, Quad viewport) {
          return UWMap();
        },
      ),
    );
  }
}
