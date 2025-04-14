part of '../map_page.dart';

class NormalMapView extends StatelessWidget {
  const NormalMapView({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // THE MAP
        InteractiveViewer.builder(
          transformationController: TransformationController(
            Matrix4.identity()
              ..translate(-1400.0, -620.0)
              ..scale(0.6, 0.6, 0.6),
          ),
          minScale: 0.12,
          builder: (BuildContext context, vector_math.Quad viewport) {
            return UWMap();
          },
        ),

        // ROUTE FOUND DIALOG
        BlocBuilder<MapBloc, MapState>(
          buildWhen: (prev, current) => prev.runtimeType != current.runtimeType,
          builder: (context, state) {
            if (state is MapFoundRoute) {
              return _dialogBox(state, context);
            }
            return Container();
          },
        ),
      ],
    );
  }
}
