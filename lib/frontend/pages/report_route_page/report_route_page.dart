import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watmap/frontend/pages/report_route_page/bloc/report_bloc.dart';

part 'components/map_data_field.dart';

class ReportRoutePage extends StatelessWidget {
  const ReportRoutePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("New route")),
      body: BlocBuilder<ReportBloc, ReportState>(
        builder: (context, state) {
          return ListView(
            padding: const EdgeInsets.all(16.0),
            children: [
              const MapDataField(),
              _messgae(state)
            ],
          );
        },
      ),
    );
  }
}

Widget _messgae(ReportState state){
  return Center(
    child: Container(
      margin: const EdgeInsets.all(8.0),
      child: Text(
        state.message,
        style: TextStyle(
          fontSize: 16.0,
          color: state.status == "success"
              ? Colors.green
              : state.status == "error"
              ? Colors.red
              : Colors.black,
        ),
      ),
    ),
  );
}