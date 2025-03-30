part of 'settings_bloc.dart';

sealed class SettingsEvent {}

class RetriveDataEvent extends SettingsEvent {}

class RefreshMapEvent extends SettingsEvent {}
