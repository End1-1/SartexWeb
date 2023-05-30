import 'package:sartex/screen/app/app_model.dart';
import 'package:sartex/screen/store_docs/store_docs_datasource.dart';

class StoreDocsModel extends AppModel<StoreDocsDatasource> {
  @override
  createDatasource() {
    datasource = StoreDocsDatasource();
  }

  @override
  String sql() {
    return "";
  }

}