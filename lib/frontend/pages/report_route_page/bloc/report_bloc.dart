import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:watmap/frontend/pages/report_route_page/report_type.dart';

part 'report_event.dart';
part 'report_state.dart';

class ReportBloc extends Bloc<ReportEvent, ReportState> {
  ReportBloc() : super(ReportState()) {
    on<ReportRouteEvent>((event, emit) {
      ReportType path = ReportType(
        buildingA: event.buildingA,
        floorA: event.floorA,
        buildingB: event.buildingB,
        floorB: event.floorB,
        pathType: event.pathType,
      );

      // TODO: http push to server
      String message =
          "Report sent successfully for:\n" +
          "There is a ${path.pathType} route from ${path.buildingA} Floor: ${path.floorA} to ${path.buildingB} Floor: ${path.floorB}";
      emit(state.copyWith(message: message));
    });
  }
}
