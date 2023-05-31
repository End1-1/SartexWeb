import 'package:sartex/screen/app/app_model.dart';
import 'package:sartex/screen/production_history/production_history_datasource.dart';

class ProductionHistoryModel extends AppModel<ProductionHistoryDatasource> {
  @override
  createDatasource() {
    datasource = ProductionHistoryDatasource();
  }

  @override
  String sql() {
    // TODO: implement sql
    throw UnimplementedError();
  }

}