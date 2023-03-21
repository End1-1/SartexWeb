import 'dart:convert';

import 'package:sartex/data/data_user.dart';
import 'package:sartex/data/sql.dart';
import 'package:sartex/screen/dashboard/dashboard_state.dart';
import 'package:sartex/utils/http_sql.dart';
import 'package:sartex/utils/translator.dart';

import '../../data/data_department.dart';
import '../../data/data_partner.dart';
import '../../data/data_product.dart';
import '../../data/data_product_status.dart';
import '../../data/data_sizes.dart';
import '../../data/order_row.dart';

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
      case locDepartement:
        state.data = DataDepartmentList.fromJson({'departments': jsonDecode(s)}).departments;
        break;
      case locProducts:
        state.data = ProductList.fromJson({'products': jsonDecode(s)}).products;
        break;
      case locSizes:
        state.data = SizeList.fromJson({'sizes': jsonDecode(s)}).sizes;
        break;
      case locPathners:
        state.data = PartnerList.fromJson({'partners': jsonDecode(s)}).partners;
        break;
      case locProductStatuses:
        state.data = ProductStatusList.fromJson({'productStatuses': jsonDecode(s)}).productStatuses;
        break;
      case locOrders:
        state.data = OrderRowList.fromJson({'list': jsonDecode(s)}).list;
        break;
    }
  }
}

class DashboardActionLanguageEditor extends DashboardActionMenu {

  DashboardActionLanguageEditor(String location) : super(false, false, false, locationName: location);

  @override
  Future<void> proceedAction() async {
  }

}
