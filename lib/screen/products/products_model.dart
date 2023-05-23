import 'package:sartex/data/data_product.dart';
import 'package:sartex/screen/app/app_model.dart';
import 'package:sartex/screen/production/production.dart';
import 'package:sartex/utils/prefs.dart';

class ProductsModel extends AppModel<ProductsDatasource> {

  @override
  String sql() {
    String f = prefs.roleSuperAdmin() ? "" : "where p.branch='${prefs.branch()}'";
    return "select p.*, pt.name as productTypeName from Products p "
        "left join ProductTypeCode pt on pt.id=p.ProductsTypeCode "
        "$f ";
  }

  @override
  createDatasource() {
    datasource = ProductsDatasource();
  }

}