part of 'report_bloc.dart';

class ReportState {
  final String message;

  const ReportState({this.message = ''});

  ReportState copyWith({String? message}) {
    return ReportState(message: message ?? this.message);
  }
}
