import 'package:sartex/screen/departments/data_department.dart';
import 'package:sartex/screen/app/app_model.dart';

class DepartmentsModel extends AppModel<DepartmentDataSource> {

  @override
  String sql() {
    return "select id,branch,department,patasxanatu,short_name, type from department";
  }

  @override
  createDatasource() {
    datasource = DepartmentDataSource();
  }

}