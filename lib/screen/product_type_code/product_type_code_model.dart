import 'package:sartex/screen/app/app_model.dart';
import 'package:sartex/screen/product_type_code/product_type_code_datasource.dart';

class ProductTypeCodeModel extends AppModel<ProductTypeCodeDatasource> {
  @override
  createDatasource() {
    datasource = ProductTypeCodeDatasource();
  }

  @override
  String sql() {
    return "select * from ProductTypeCode";
  }

}