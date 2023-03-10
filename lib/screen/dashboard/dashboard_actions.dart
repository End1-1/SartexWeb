import 'package:sartex/screen/dashboard/dashboard_state.dart';

import '../../data/dataset.dart';

abstract class DashboardAction {

  DashboardState _state = DashboardStateDefault();
  DashboardState get state => _state;
  set state(s) => _state = s;

}

class DashboardActionDefault extends DashboardAction {

}

class DashboardActionMenu extends DashboardAction {

  DashboardActionMenu(bool expandMenu, bool expandDirectory, bool expandLanguage, {String locationName = ""}) {
    state = DashboardStateDefault();
    state.expandMenu = expandMenu;
    state.expandDirectory = expandDirectory;
    state.expandLanguage = expandLanguage;
    state.locationName = locationName;
  }

  @override
  DashboardState getState() {
    return DashboardStateDefault();
  }

}

class DashboardActionLoadData extends DashboardActionMenu {

  DashboardActionLoadData(String locationName) : super(false,false,false,locationName: locationName) {

  }

  @override
  DashboardState getState() {
    DataSet dataSet = DataSet();
    dataSet.load(state.locationName);
    return DashboardStateDataReady();
  }
}
