import 'package:sartex/screen/app_grid_window/app_grid_screen.dart';
import 'package:sartex/screen/departments/departments_model.dart';
import 'package:sartex/utils/translator.dart';

class DepartmentsScreen extends AppGridScreen {
  DepartmentsScreen() : super(title: L.tr('Departments'), model: DepartmentsModel());

}