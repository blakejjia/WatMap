part of 'settings_bloc.dart';

class SettingsState {
  final String lastMapRefreshTime;
  final String lastServerRetriveTime;

  SettingsState({
    required this.lastMapRefreshTime,
    required this.lastServerRetriveTime,
  });

  factory SettingsState.fromMap(Map<String, dynamic> map) {
    return SettingsState(
      lastMapRefreshTime: map['LastMapRefreshTime'] ?? '',
      lastServerRetriveTime: map['lastServerRetriveTime'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'LastMapRefreshTime': lastMapRefreshTime,
      'lastServerRetriveTime': lastServerRetriveTime,
    };
  }

  SettingsState copyWith({
    String? lastMapRefreshTime,
    String? lastServerRetriveTime,
  }) {
    return SettingsState(
      lastMapRefreshTime: lastMapRefreshTime ?? this.lastMapRefreshTime,
      lastServerRetriveTime:
          lastServerRetriveTime ?? this.lastServerRetriveTime,
    );
  }
}
