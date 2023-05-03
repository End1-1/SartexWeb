import 'package:sartex/data/data_product.dart';
import 'package:sartex/screen/app/app_model.dart';
import 'package:sartex/screen/production/production.dart';

class ProductsModel extends AppModel<ProductsDatasource> {

  @override
  String sql() {
    return "select * from Products";
  }

  @override
  createDatasource() {
    datasource = ProductsDatasource();
  }

}