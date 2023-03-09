import '../../utils/translator.dart';

abstract class DashboardState {
  late String _locationName;
  String get locationName => _locationName;
  set locationName(v) => _locationName = v;

  bool _expandMenu = false;
  bool get expandMenu => _expandMenu;
  set expandMenu(v) => _expandMenu = v;

  bool _expandDirectory = false;
  bool get expandDirectory => _expandDirectory;
  set expandDirectory(v) => _expandDirectory = v;

  bool _expandLanguage = false;
  bool get expandLanguage => _expandLanguage;
  set expandLanguage(v) => _expandLanguage = v;

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