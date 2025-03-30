import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watmap/frontend/pages/report_route_page/bloc/report_bloc.dart';

part 'components/map_data_field.dart';

class ReportRoutePage extends StatelessWidget {
  const ReportRoutePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Report a route")),
      body: BlocBuilder<ReportBloc, ReportState>(
        builder: (context, state) {
          return ListView(
            padding: const EdgeInsets.all(16.0),
            children: [
              const MapDataField(),
              // _currentData(context),
              // _uWMap(context),
              Text(state.message, style: const TextStyle(fontSize: 16.0)),
            ],
          );
        },
      ),
    );
  }
}
