import 'package:flutter/material.dart';
import 'package:watmap/frontend/pages/map_page/views/format_string.dart';
import '../../../../backend/model/models.dart';
import '../../../blocs/map_bloc/map_bloc.dart';

part 'components/path_card.dart';

class RoutePage extends StatelessWidget {
  final MapTriedFoundRoute state;
  const RoutePage(this.state, {super.key});

  @override
  Widget build(BuildContext context) {
    MyRoute route = state.route;
    MyMap map = state.map;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "From ${route.paths[0].toLocAString(map)} "
          "to ${route.paths[route.paths.length - 1].toLocBString(map)}",
          style: TextStyle(fontSize: 18),
        ),
      ),
      body: ListView.builder(
        itemCount: route.paths.length + 2,
        itemBuilder: (context, index) {
          if (index == 0) {
            return Column(
              children: [
                _construction(),
                _startCard(route.paths[0], map),
              ],
            );
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

