part of 'settings_bloc.dart';

class SettingsState {
  final String lastMapRefreshTime;
  final String lastUpdateTime;
  final bool isBuilt;
  final bool newUsr;

  SettingsState({
    required this.lastMapRefreshTime,
    required this.lastUpdateTime,
    required this.isBuilt,
    required this.newUsr,
  });

  factory SettingsState.fromMap(Map<String, dynamic> map) {
    return SettingsState(
      lastMapRefreshTime: map['LastMapRefreshTime']?.toString() ?? '',
      lastUpdateTime: map['lastUpdateTime']?.toString() ?? '',
      isBuilt: map['isBuilt'] as bool? ?? false,
      newUsr: map['newUsr'] as bool? ?? true,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'LastMapRefreshTime': lastMapRefreshTime,
      'lastUpdateTime': lastUpdateTime,
      'isBuilt': isBuilt,
      'newUsr': newUsr,
    };
  }

  SettingsState copyWith({
    String? lastMapRefreshTime,
    String? lastUpdateTime,
    bool? isBuilt,
    bool? newUsr,
  }) {
    return SettingsState(
      lastMapRefreshTime: lastMapRefreshTime ?? this.lastMapRefreshTime,
      lastUpdateTime: lastUpdateTime ?? this.lastUpdateTime,
      isBuilt: isBuilt ?? this.isBuilt,
      newUsr: newUsr ?? this.newUsr,
    );
  }
}
