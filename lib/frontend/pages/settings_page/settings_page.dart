import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watmap/frontend/pages/settings_page/Bloc/settings_bloc.dart';
import 'package:watmap/frontend/pages/settings_page/components/report_route/bloc/report_bloc.dart';
import 'package:watmap/frontend/pages/settings_page/components/report_route/report_route_page.dart';
import 'package:watmap/main.dart';

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
                  title: Text("retrive data"),
                  trailing: Text(state.lastServerRetriveTime),
                  onTap: () {
                    context.read<SettingsBloc>().add(RetriveDataEvent());
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
                  title: Text("report a route"),
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
