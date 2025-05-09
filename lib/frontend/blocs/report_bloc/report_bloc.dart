import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:watmap/backend/model/base/path_raw.dart';
import 'package:watmap/backend/services/supa_service.dart';

import '../../../main.dart';

part 'report_event.dart';
part 'report_state.dart';

class ReportBloc extends Bloc<ReportEvent, ReportState> {
  ReportBloc() : super(ReportState()) {
    on<SendUsMessageEvent>((event, emit) async {
      bool response = await getIt<SupaService>().reportMessage(
        event.message,
        event.contact,
      );
      if (response) {
        emit(
          state.copyWith(
            status: "success",
            message: "Thank you for your feedback",
          ),
        );
      } else {
        emit(
          state.copyWith(status: "error", message: "Failed to send message"),
        );
      }
    });

    on<ReportRouteEvent>((event, emit) async {
      RawPath path = RawPath(
        buildingA: event.buildingA,
        floorA: event.floorA,
        buildingB: event.buildingB,
        floorB: event.floorB,
        pathType: event.pathType,
      );

      bool response = await getIt<SupaService>().reportPath(path);
      if (response) {
        emit(
          state.copyWith(
            status: "success",
            message:
                "It will be reviewed by blake within 3 days, try update data after hood.",
          ),
        );
      } else {
        emit(
          state.copyWith(status: "error", message: "Failed to report route"),
        );
      }
    });

    on<RefreshReportEvent>((event, emit) {
      emit(state.copyWith(status: "", message: ""));
    });
  }
}
