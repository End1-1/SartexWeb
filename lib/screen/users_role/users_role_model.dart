import 'package:sartex/screen/app/app_model.dart';
import 'package:sartex/screen/users_role/users_role_datasource.dart';

class UsersRoleModel extends AppModel<UsersRoleDatasource> {
  @override
  createDatasource() {
    datasource = UsersRoleDatasource();
  }

  @override
  String sql() {
    return "select id, name from RoleNames";
  }

}