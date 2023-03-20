import '../../utils/translator.dart';

const locUsers = 'Users';
const locDefault = 'Welcome!';
const locDepartement = 'department';
const locProducts = 'Products';
const locSizes = 'Sizes';
const locPathners = 'Parthners';
const locProductStatuses = 'productStatuses';
const locOrders = 'patver_data';

abstract class DashboardState {

  late String _locationName;
  String get locationName => _locationName;
  set locationName(v) => _locationName = L.tr(v);

  bool _expandMenu = false;
  bool get expandMenu => _expandMenu;
  set expandMenu(v) => _expandMenu = v;

  bool _expandDirectory = false;
  bool get expandDirectory => _expandDirectory;
  set expandDirectory(v) => _expandDirectory = v;

  bool _expandLanguage = false;
  bool get expandLanguage => _expandLanguage;
  set expandLanguage(v) => _expandLanguage = v;

  dynamic data;

}

class DashboardStateDefault extends DashboardState {
  DashboardStateDefault() {
    locationName = locDefault;
  }
}

class DashboardStateLoadData extends DashboardState {

  DashboardStateLoadData(String currentLocationName) {
    locationName = currentLocationName;
  }
}

class DashboardStateDataReady extends DashboardState {

}