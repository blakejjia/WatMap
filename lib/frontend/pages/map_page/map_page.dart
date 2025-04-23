import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// ignore: depend_on_referenced_packages
import 'package:vector_math/vector_math_64.dart' as vector_math64;
import 'package:watmap/backend/model/mid/my_route.dart';
import 'package:watmap/frontend/pages/map_page/route_page/route_page.dart';

import '../../../backend/db/database.dart';
import '../../../backend/model/mid/my_map.dart';
import '../../algorithm/algorithms.dart';
import '../../blocs/map_bloc/map_bloc.dart';

part 'components/uw_map.dart';
part 'components/map_ideal.dart';
part 'components/map_found_route.dart';
part 'components/normal.dart';

class MapPage extends StatelessWidget {
  const MapPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const NormalMapView();
  }
}
