import 'package:sartex/screen/app_grid_window/app_grid_screen.dart';
import 'package:sartex/screen/users/users_model.dart';
import 'package:sartex/utils/translator.dart';

class UsersScreen extends AppGridScreen {
  UsersScreen() : super(title: L.tr('Users'), model: UsersModel());

}