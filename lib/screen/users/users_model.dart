import 'package:sartex/screen/app/app_model.dart';
import 'package:sartex/screen/users/data_user.dart';

class UsersModel extends AppModel<UserDataSource> {


  @override
  String sql() {
    return "select * from Users";
  }

  @override
  createDatasource() {
    datasource = UserDataSource();
  }
}
