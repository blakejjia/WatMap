part of 'report_bloc.dart';

@immutable
sealed class ReportEvent {}

class ReportRouteEvent extends ReportEvent {
  final String buildingA;
  final String floorA;
  final String buildingB;
  final String floorB;
  final String pathType;

  ReportRouteEvent({
    required this.buildingA,
    required this.floorA,
    required this.buildingB,
    required this.floorB,
    required this.pathType,
  });
}
