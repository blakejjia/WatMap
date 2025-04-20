part of 'settings_bloc.dart';

sealed class SettingsEvent {}

class UpdateDataEvent extends SettingsEvent {}

class RefreshMapEvent extends SettingsEvent {}

class NotNewUsr extends SettingsEvent {}

class ChangeWeather extends SettingsEvent {
  final Weather weather;

  ChangeWeather(Weather weather) : weather = Weather.values[(weather.index + 1) % Weather.values.length];
}