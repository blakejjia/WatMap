import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:watmap/backend/services/pour_db.dart';
import 'package:watmap/frontend/app_strings.dart';
import 'package:watmap/main.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../map_bloc/map_bloc.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends HydratedBloc<SettingsEvent, SettingsState> {
  SettingsBloc()
    : super(
        SettingsState(
          lastMapRefreshTime: AppStrings.newUser,
          lastUpdateTime: AppStrings.newUser,
          weather: Weather.snowy,
          isBuilt: false,
          newUsr: true,
        ),
      ) {
    on<RefreshMapEvent>(_onRefreshMap);
    on<UpdateDataEvent>(_onUpdateData);
    on<NotNewUsr>(_noNotNewUser);
    on<ChangeWeather>(_onChangeWeather);
    if (state.isBuilt == false) {
      // user killed while building
      emit(state.copyWith(isBuilt: true));
      add(UpdateDataEvent());
    }
  }

  Future<void> _onRefreshMap(
    RefreshMapEvent event,
    Emitter<SettingsState> emit,
  ) async {
    if (state.isBuilt == false) return;
    getIt<MapBloc>().add(MapLoad());
    emit(state.copyWith(lastMapRefreshTime: _now()));
    Fluttertoast.showToast(msg: "map refreshed");
  }

  Future<void> _onChangeWeather(
    ChangeWeather event,
    Emitter<SettingsState> emit,
  ) async {
    if (state.isBuilt == false) return;
    emit(state.copyWith(weather: event.weather));
  }

  Future<void> _onUpdateData(
    UpdateDataEvent event,
    Emitter<SettingsState> emit,
  ) async {
    Fluttertoast.showToast(msg: "start to build database...");
    bool isSuccess = await pourDb();

    if (isSuccess == true) {
      Fluttertoast.showToast(msg: "database built!");
      emit(
        state.copyWith(lastUpdateTime: AppStrings.success, lastMapRefreshTime: AppStrings.success),
      );
      add(RefreshMapEvent());
      emit(state.copyWith(lastUpdateTime: _now()));
    } else {
      Fluttertoast.showToast(msg: "failed to build db!");
      emit(state.copyWith(lastUpdateTime: AppStrings.error, lastMapRefreshTime: AppStrings.error));
    }
  }

  Future<void> _noNotNewUser(
    NotNewUsr event,
    Emitter<SettingsState> emit,
  ) async {
    emit(state.copyWith(newUsr: false));
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
