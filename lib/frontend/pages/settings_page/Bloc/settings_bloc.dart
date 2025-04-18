import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:watmap/backend/services/pour_db.dart';
import 'package:watmap/frontend/bloc/map_bloc.dart';
import 'package:watmap/main.dart';

part 'settings_event.dart';
part 'settings_state.dart';

const String NEWUSER = 'Not yet';
const String ERROR = 'error occurred';
const String SUCCESS = 'db built, enjoy~';
const String BUILDING = 'building db... takes';

class SettingsBloc extends HydratedBloc<SettingsEvent, SettingsState> {
  SettingsBloc()
      : super(
    SettingsState(
      lastMapRefreshTime: NEWUSER,
      lastUpdateTime: NEWUSER,
      isBuilt: false,
      newUsr: true,
    ),
  ) {
    on<RefreshMapEvent>(_onRefreshMap);
    on<UpdateDataEvent>(_onUpdateData);
    on<NotNewUsr>(_noNotNewUser);
    if(state.isBuilt == false) {
      // user killed while building
      emit(state.copyWith(isBuilt: true));
      add(UpdateDataEvent());
    }
  }

  Future<void> _onRefreshMap(RefreshMapEvent event, Emitter<SettingsState> emit) async {
    if (state.isBuilt == false) return;
    getIt<MapBloc>().add(MapLoad());
    emit(state.copyWith(lastMapRefreshTime: _now()));
  }

  Future<void> _onUpdateData(UpdateDataEvent event, Emitter<SettingsState> emit) async {
    if (state.isBuilt == false) return;
    emit(state.copyWith(isBuilt: false));
    _buildingTicker(emit);
    bool isSuccess = await pourDb();

    if (isSuccess == true) {
      emit(state.copyWith(lastUpdateTime: SUCCESS, lastMapRefreshTime: SUCCESS));
      add(RefreshMapEvent());
      emit(state.copyWith(lastUpdateTime: _now()));
    } else {
      emit(state.copyWith(lastUpdateTime: ERROR, lastMapRefreshTime: ERROR));
    }
    emit(state.copyWith(isBuilt: true));
  }

  Future<void> _noNotNewUser(NotNewUsr event, Emitter<SettingsState> emit) async {
    emit(state.copyWith(newUsr: false));
  }

  Future<void> _buildingTicker(Emitter<SettingsState> emit) async {
    int counter = 0;
    while (state.isBuilt == false) {
      counter++;
      emit(state.copyWith(
        lastUpdateTime: "$BUILDING $counter s",
        lastMapRefreshTime: "$BUILDING $counter s",
      ));
      await Future.delayed(const Duration(seconds: 1));
    }
    return;
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
  return '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')} '
      '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}';
}
