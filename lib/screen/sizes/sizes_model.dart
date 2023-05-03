import 'package:sartex/data/data_sizes.dart';
import 'package:sartex/screen/app/app_model.dart';

class SizesModel extends AppModel<SizeDatasource> {


  @override
  String sql() {
    return "select id,code,country,name,size01,size02,size03,size04,size05,size06,size07,size08,size09,size10,coalesce(size11, '') as size11 from Sizes";
  }

  @override
  createDatasource() {
    datasource = SizeDatasource();
  }
}
