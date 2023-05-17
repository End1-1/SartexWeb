import 'package:sartex/screen/app/app_model.dart';
import 'package:sartex/screen/users/data_user.dart';
import 'package:sartex/utils/consts.dart';
import 'package:sartex/utils/prefs.dart';

class UsersModel extends AppModel<UserDataSource> {


  @override
  String sql() {
    String f = prefs.roleRead("9") || prefs.roleWrite("9") ? "" : " where branch=${prefs.getString(key_user_branch)} ";
    return "select * from Users $f ";
  }

  @override
  createDatasource() {
    datasource = UserDataSource();
  }
}
