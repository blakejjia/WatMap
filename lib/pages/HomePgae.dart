import 'package:flutter/material.dart';
import 'package:watmap/pages/mapDat/UWMap.dart';
import 'package:vector_math/vector_math_64.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('WatMap')),
      body: InteractiveViewer.builder(
        transformationController: TransformationController(Matrix4.identity()..translate(-2500.0, -1200.0)),
        minScale: 0.1,
        builder: (BuildContext context, Quad viewport) {
          return UWMap();
        },
      ),
    );
  }
}
