import '../../utils/translator.dart';

abstract class DashboardState {
  late String _locationName;
  String get locationName => _locationName;
  set locationName(ln) {
    _locationName = ln;
  }
}

class DashboardStateDefault extends DashboardState {
  DashboardStateDefault() {
    locationName = L.tr("Welcome!");
  }
}

class DashboardStateLoadData extends DashboardState {

  DashboardStateLoadData(String currentLocationName) {
    locationName = currentLocationName;
  }
}