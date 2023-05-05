import 'package:sartex/screen/app_grid_window/app_grid_screen.dart';
import 'package:sartex/screen/users_role/users_role_model.dart';
import 'package:sartex/utils/translator.dart';

class UsersRoleScreen extends AppGridScreen {
  UsersRoleScreen() : super(title: L.tr('Roles'), model: UsersRoleModel());

}