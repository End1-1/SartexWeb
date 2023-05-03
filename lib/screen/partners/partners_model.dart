import 'package:sartex/data/data_partner.dart';
import 'package:sartex/screen/app/app_model.dart';

class PartnersModel extends AppModel<PartnerDatasource> {

  @override
  String sql() {
    return "select id, coalesce(branch, '') as branch, country, name, type from Parthners";
  }

  @override
  createDatasource() {
    datasource = PartnerDatasource();
  }

}