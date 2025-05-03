class AppStrings {
  static const String newUser = 'Not yet';
  static const String error = 'error occurred';
  static const String success = 'db built, enjoy~';
  static const String building = 'building db... takes';

  // constants for clean routes -----------------------------------
  static const double eps = 0.1;
  static const double ptEps = 1;

  static const double stairsCost = 30; // depends on usr settings, typically ~30
  static const double outsideCostMultiplier = 4; // if sunny, 1; if snow, this number
  static const double walkSpeed = 1.5; // usually 1.5m/s
}