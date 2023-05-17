import 'package:sartex/screen/app/app_model.dart';

import 'datasource.dart';

class THashivModel extends AppModel<THashivDatasource> {
  final String aprId;

  THashivModel(this.aprId);

  @override
  createDatasource() {
    datasource = THashivDatasource();
  }

  @override
  String sql() {
    return "select ynd_dt as `date`, if(mutq_elq='mutq', yqanak, 0) as `input`, if (mutq_elq='elq', yqanak, 0) as `out` "
        "from Docs "
        "where apr_id=$aprId and status='ok' "
        "order by ynd_dt";
  }

}