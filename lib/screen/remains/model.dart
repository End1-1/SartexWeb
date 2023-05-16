import 'package:sartex/screen/app/app_model.dart';

import 'datasource.dart';

class RemainsModel extends AppModel<RemainsDatasource> {

  @override
  createDatasource() {
    datasource = RemainsDatasource();
  }

  @override
  String sql() {
    return "select pd.branch, m.pahest, pd.brand, pd.Model, pd.ModelCod, pd.country, pd.variant_prod, pd.Colore, "
    "m.mnacord "
    "from Apranq a "
    "left join patver_data pd on pd.id=a.pid "
    "left join Mnacord m on m.apr_id=a.apr_id "
    "where cast(coalesce(m.mnacord, 0) as signed)>0";
  }

}