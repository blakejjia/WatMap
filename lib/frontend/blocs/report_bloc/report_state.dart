part of 'report_bloc.dart';

class ReportState {
  final String message;
  final String status;

  const ReportState({this.message = '', this.status = ''});

  ReportState copyWith({String? message, String? status}) {
    return ReportState(
      message: message ?? this.message,
      status: status ?? this.status,
    );
  }
}
