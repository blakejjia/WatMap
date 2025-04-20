part of 'settings_bloc.dart';

enum Weather { sunny, snowy }

class SettingsState {
  final String lastMapRefreshTime;
  final String lastUpdateTime;
  final bool isBuilt;
  final bool newUsr;
  final Weather weather;

  SettingsState({
    required this.lastMapRefreshTime,
    required this.lastUpdateTime,
    required this.isBuilt,
    required this.newUsr,
    required this.weather,
  });

  factory SettingsState.fromMap(Map<String, dynamic> map) {
    return SettingsState(
      lastMapRefreshTime: map['LastMapRefreshTime']?.toString() ?? '',
      lastUpdateTime: map['lastUpdateTime']?.toString() ?? '',
      isBuilt: map['isBuilt'] as bool? ?? false,
      newUsr: map['newUsr'] as bool? ?? true,
      weather: Weather.values.firstWhere(
        (e) => e.toString().split('.').last == map['weather'],
        orElse: () => Weather.snowy,
      ),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'LastMapRefreshTime': lastMapRefreshTime,
      'lastUpdateTime': lastUpdateTime,
      'isBuilt': isBuilt,
      'newUsr': newUsr,
      'weather': weather.toString().split('.').last,
    };
  }

  SettingsState copyWith({
    String? lastMapRefreshTime,
    String? lastUpdateTime,
    bool? isBuilt,
    bool? newUsr,
    Weather? weather,
  }) {
    return SettingsState(
      lastMapRefreshTime: lastMapRefreshTime ?? this.lastMapRefreshTime,
      lastUpdateTime: lastUpdateTime ?? this.lastUpdateTime,
      isBuilt: isBuilt ?? this.isBuilt,
      newUsr: newUsr ?? this.newUsr,
      weather: weather ?? this.weather,
    );
  }
}
