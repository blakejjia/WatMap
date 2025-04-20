import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watmap/frontend/blocs/report_bloc/report_bloc.dart';

import '../../../../../main.dart';

part 'components/input_field.dart';

class ReportRoutePage extends StatefulWidget {
  const ReportRoutePage({super.key});

  @override
  State<ReportRoutePage> createState() => _ReportRoutePageState();
}

class _ReportRoutePageState extends State<ReportRoutePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("New route")),
      body: BlocBuilder<ReportBloc, ReportState>(
        builder: (context, state) {
          return ListView(
            padding: const EdgeInsets.all(16.0),
            children: [
              const _InputField(),
              _message(state)
            ],
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    getIt<ReportBloc>().add(RefreshReportEvent());
    super.dispose();
  }
}

Widget _message(ReportState state){
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