import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watmap/frontend/pages/map_page/map_page.dart';
import 'package:watmap/frontend/blocs/settings_bloc/settings_bloc.dart';

import 'components/actions.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          BlocListener<SettingsBloc, SettingsState>(
            listener: (context, state) {
              if (state.isBuilt == false) {
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.lastMapRefreshTime),
                    duration: const Duration(seconds: 2),
                  ),
                );
              }
            },
            child: const MapPage(),
          ),
          HomePageActions(),
        ],
      ),
    );
  }
}
