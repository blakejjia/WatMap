part of 'settings_bloc.dart';

sealed class SettingsEvent {}

class UpdateDataEvent extends SettingsEvent {}

class RefreshMapEvent extends SettingsEvent {}

class NotNewUsr extends SettingsEvent {}