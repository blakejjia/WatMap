import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:watmap/backend/model/base/my_path.dart';
import 'package:watmap/frontend/bloc/map_bloc.dart';
// ignore: depend_on_referenced_packages
import 'package:vector_math/vector_math_64.dart' as vector_math;
import 'package:watmap/frontend/pages/map_page/route_page/route_page.dart';
import 'package:watmap/frontend/pages/settings_page/Bloc/settings_bloc.dart';
import 'package:watmap/main.dart';

import '../../../backend/db/database.dart';
import '../../../backend/model/mid/my_map.dart';

part 'components/uw_map.dart';
part 'components/map_ideal.dart';
part 'components/map_found_route.dart';
part 'views/normal.dart';
part 'views/welcome.dart';

class MapPage extends StatelessWidget {
  const MapPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsBloc, SettingsState>(
      builder: (context, state) {
        if (state.lastMapRefreshTime == NEWUSER) {
          return const WelcomeView();
        } else {
          return const NormalMapView();
        }
      },
    );
  }
}
