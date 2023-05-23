import 'package:sartex/screen/departments/data_department.dart';
import 'package:sartex/screen/app/app_model.dart';
import 'package:sartex/utils/prefs.dart';

class DepartmentsModel extends AppModel<DepartmentDataSource> {

  @override
  String sql() {
    String f = prefs.roleRead("9") || prefs.roleWrite("9") ? "" : " where branch='${prefs.branch()}'";
    return "select id,branch,department,patasxanatu,short_name, type from department $f ";
  }

  @override
  createDatasource() {
    datasource = DepartmentDataSource();
  }

}