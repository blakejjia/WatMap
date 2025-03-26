import 'package:flutter/material.dart';
import 'package:watmap/pages/bloc/map_bloc.dart';
import '../../data/model/models.dart';

part 'components/path_card.dart';

class RoutePage extends StatelessWidget {
  final MapFoundRoute state;
  const RoutePage(this.state, {super.key});

  @override
  Widget build(BuildContext context) {
    MyRoute route = state.route;
    MyMap map = state.map;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "From ${_locationName(route.paths[0].pointAId,map)} "
          "to ${_locationName(route.paths[route.paths.length - 1].pointBId,map)}",
          style: TextStyle(fontSize: 18),
        ),
      ),
      body: ListView.builder(
        itemCount: route.paths.length + 2,
            itemBuilder: (context, index) {
              if (index == 0) {
                return _startCard(route.paths[0], map);
              } else if (index == route.paths.length + 1) {
                return _endCard(route.paths[route.paths.length - 1], map);
              } else {
                return _pathCard(route.paths[index - 1], map, index);
              }
            },
      ),
    );
  }
}

String _locationName(int id, MyMap map) {
  return map.locations.firstWhere((location) => location.id == id).name;
}
