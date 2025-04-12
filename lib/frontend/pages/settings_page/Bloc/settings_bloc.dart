import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:watmap/backend/services/pour_db.dart';
import 'package:watmap/frontend/bloc/map_bloc.dart';
import 'package:watmap/main.dart';

part 'settings_event.dart';
part 'settings_state.dart';

const String NEWUSER = 'Not yet';

class SettingsBloc extends HydratedBloc<SettingsEvent, SettingsState> {
  SettingsBloc()
    : super(
        SettingsState(
          lastMapRefreshTime: NEWUSER,
          lastServerRetriveTime: NEWUSER,
        ),
      ) {
    on<RefreshMapEvent>((event, emit) async {
      getIt<MapBloc>().add(MapLoad());
      emit(state.copyWith(lastMapRefreshTime: _now()));
    });
    on<RetriveDataEvent>((event, emit) async {
      emit(
        state.copyWith(
          lastServerRetriveTime: 'building db...',
          lastMapRefreshTime: 'building db...',
        ),
      );
      bool isSuccess = await pourDb();
      add(RefreshMapEvent());
      if (isSuccess) {
        emit(state.copyWith(lastServerRetriveTime: _now()));
      } else {
        emit(state.copyWith(lastServerRetriveTime: 'error occured'));
      }
    });
  }

  @override
  SettingsState? fromJson(Map<String, dynamic> json) {
    try {
      return SettingsState.fromMap(json);
    } catch (_) {
      return null;
    }
  }

  @override
  Map<String, dynamic>? toJson(SettingsState state) {
    try {
      return state.toMap();
    } catch (_) {
      return null;
    }
  }
}

String _now() {
  final now = DateTime.now();
  return '${now.year}-${now.month}-${now.day} ${now.hour}:${now.minute}';
}
