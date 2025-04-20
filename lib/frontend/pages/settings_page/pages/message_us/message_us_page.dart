import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watmap/main.dart';

import '../../../../blocs/report_bloc/report_bloc.dart';

part 'components/input_field.dart';

class MessageUsPage extends StatefulWidget {
  const MessageUsPage({super.key});

  @override
  State<MessageUsPage> createState() => _MessageUsPageState();
}

class _MessageUsPageState extends State<MessageUsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Message us")),
      body: BlocBuilder<ReportBloc, ReportState>(
        builder: (context, state) {
          return ListView(
            padding: const EdgeInsets.all(16.0),
            children: [
              const Text(
                "If you have any feedback, please let us know. It could be a bug, a suggestion, or anything else. We will try to respond if you leave your contact.",
                style: TextStyle(fontSize: 16.0),
              ),
              const SizedBox(height: 16),
              const _InputField(),
              _message(state),
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

Widget _message(ReportState state) {
  return Center(
    child: Container(
      margin: const EdgeInsets.all(8.0),
      child: Text(
        state.message,
        style: TextStyle(
          fontSize: 16.0,
          color:
              state.status == "success"
                  ? Colors.green
                  : state.status == "error"
                  ? Colors.red
                  : Colors.black,
        ),
      ),
    ),
  );
}
