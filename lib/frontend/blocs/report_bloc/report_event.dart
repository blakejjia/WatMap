part of 'report_bloc.dart';

@immutable
sealed class ReportEvent {}

class ReportRouteEvent extends ReportEvent {
  final String buildingA;
  final int floorA;
  final String buildingB;
  final int floorB;
  final String pathType;

  ReportRouteEvent({
    required String buildingA,
    required String floorA,
    required String buildingB,
    required String floorB,
    required this.pathType,
  }) : buildingA = buildingA.toUpperCase(),
       floorA = extractNumber(floorA),
       buildingB = buildingB.toUpperCase(),
       floorB = extractNumber(floorB);
}

int extractNumber(String input) {
  final RegExp regex = RegExp(r'\d+');
  final Match? match = regex.firstMatch(input);
  return match != null ? int.parse(match.group(0)!) : 0;
}

// called inside the Message us page
class SendUsMessageEvent extends ReportEvent {
  final String message;
  final String contact;

  SendUsMessageEvent(this.message, this.contact);
}

// called when usr leave the report page.
class RefreshReportEvent extends ReportEvent {
  RefreshReportEvent();
}
