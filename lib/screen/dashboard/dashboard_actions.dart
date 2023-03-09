import 'package:sartex/screen/dashboard/dashboard_state.dart';

abstract class DashboardAction {

  DashboardState _state = DashboardStateDefault();
  DashboardState get state => _state;
  set state(s) => _state = s;

}

class DashboardActionDefault extends DashboardAction {

}

class DashboardActionMenu extends DashboardAction {

  DashboardActionMenu(bool expandMenu, bool expandDirectory, bool expandLanguage) {
    state = DashboardStateDefault();
    state.expandMenu = expandMenu;
    state.expandDirectory = expandDirectory;
    state.expandLanguage = expandLanguage;
  }

  @override
  DashboardState getState() {
    return DashboardStateDefault();
  }

}
