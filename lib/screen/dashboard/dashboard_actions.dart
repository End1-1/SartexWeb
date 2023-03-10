import 'dart:convert';

import 'package:sartex/data/data_user.dart';
import 'package:sartex/data/sql.dart';
import 'package:sartex/screen/dashboard/dashboard_state.dart';
import 'package:sartex/utils/http_sql.dart';
import 'package:sartex/utils/translator.dart';

import '../../data/dataset.dart';

abstract class DashboardAction {

  DashboardState _state = DashboardStateDefault();
  DashboardState get state => _state;
  set state(s) => _state = s;

  Future<void> proceedAction();

}

class DashboardActionDefault extends DashboardAction {
  @override
  Future<void> proceedAction() async {

  }

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
  Future<void> proceedAction() async {

  }

}

class DashboardActionLoadData extends DashboardActionMenu {

  DashboardActionLoadData(String locationName) : super(false,false,false,locationName: locationName) {

  }

  @override
  Future<void> proceedAction() async {
    String s = await HttpSqlQuery.postString({'sl':Sql.sqlList[state.locationName]});
    //HANDLE ERROR
    switch (state.locationName) {
      case locUsers:
        state.data = DataUserList.fromJson({'users': jsonDecode(s)}).users;
        break;
    }
  }
}
