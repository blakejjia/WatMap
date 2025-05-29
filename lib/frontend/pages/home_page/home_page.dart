import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watmap/frontend/pages/home_page/views/welcome_view.dart';
import 'package:watmap/frontend/blocs/settings_bloc/settings_bloc.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

import '../map_page/map_page.dart';

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
          BlocBuilder<SettingsBloc, SettingsState>(
            builder: (context, state) {
              if (state.newUsr) {
                if (kIsWeb) {
                  // On web, we need to add a delay to the welcome view
                  context.read<SettingsBloc>().add(NotNewUsr());
                } else {
                  return const WelcomeView();
                }
              }
              return WatMapPage();
            },
          ),
        ],
      ),
    );
  }
}
