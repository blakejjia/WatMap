import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watmap/frontend/blocs/settings_bloc/settings_bloc.dart';
import 'package:watmap/frontend/pages/settings_page/pages/message_us/message_us_page.dart';
import 'package:watmap/frontend/pages/settings_page/pages/report_route/report_route_page.dart';

part 'components/group_tile.dart';
part 'components/info_view.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<SettingsBloc, SettingsState>(
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
                  InkWell(
                    onTap: () {
                      context.read<SettingsBloc>().add(RefreshMapEvent());
                    },
                    child: ListTile(
                      title: Text("refresh map"),
                      leading: Icon(Icons.refresh),
                      trailing: Text(state.lastMapRefreshTime),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      context.read<SettingsBloc>().add(UpdateDataEvent());
                    },
                    child: ListTile(
                      leading: Icon(Icons.cloud_download),
                      title: Text("update data"),
                      trailing: Text(state.lastUpdateTime),
                    ),
                  ),
                ],
              ),
              // ========== report ============
              SizedBox(height: 20),
              GroupedTile(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ReportRoutePage(),
                        ),
                      );
                    },
                    child: ListTile(
                      leading: Icon(Icons.add_location_alt),
                      title: Text("Tell us a undiscovered route"),
                    ),
                  ),
                ],
              ),

              // ========== about ============
              SizedBox(height: 20),
              GroupedTile(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const InfoView(),
                        ),
                      );
                    },
                    child: ListTile(
                      leading: Icon(Icons.info_outline),
                      title: Text("Software information"),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MessageUsPage(),
                        ),
                      );
                    },
                    child: ListTile(
                      leading: Icon(Icons.message),
                      title: Text("Send us a message"),
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
