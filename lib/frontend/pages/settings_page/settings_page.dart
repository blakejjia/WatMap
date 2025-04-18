import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watmap/frontend/pages/settings_page/Bloc/settings_bloc.dart';
import 'package:watmap/frontend/pages/report_route_page/report_route_page.dart';

part 'components/group_tile.dart';
part 'components/info_view.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsBloc, SettingsState>(
      builder: (context, state) {
        return ListView(
          children: [
            SizedBox(
              height: 200,
              child: Center(
                child: Text(
                  "settings",
                  style: Theme.of(context).textTheme.displaySmall,
                ),
              ),
            ),
            // ========== basic settings ==========
            GroupedTile(
              children: [
                ListTile(
                  title: Text("refresh map"),
                  leading: Icon(Icons.refresh),
                  trailing: Text(state.lastMapRefreshTime),
                  onTap: () {
                    context.read<SettingsBloc>().add(RefreshMapEvent());
                  },
                ),
                ListTile(
                  leading: Icon(Icons.cloud_download),
                  title: Text("update data"),
                  trailing: Text(state.lastUpdateTime),
                  onTap: () {
                    context.read<SettingsBloc>().add(UpdateDataEvent());
                  },
                ),
              ],
            ),
            // ========== report ============
            SizedBox(height: 20),
            GroupedTile(
              children: [
                ListTile(
                  leading: Icon(Icons.add_location_alt),
                  title: Text("Tell us a undiscovered route"),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ReportRoutePage(),
                      ),
                    );
                  },
                ),
              ],
            ),

            // ========== about ============
            SizedBox(height: 20),
            GroupedTile(
              children: [
                ListTile(
                  leading: Icon(Icons.info_outline),
                  title: Text("Software information"),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const InfoView()),
                    );
                  },
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
