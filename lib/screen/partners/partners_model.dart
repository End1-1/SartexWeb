import 'package:sartex/data/data_partner.dart';
import 'package:sartex/screen/app/app_model.dart';
import 'package:sartex/utils/consts.dart';
import 'package:sartex/utils/prefs.dart';

class PartnersModel extends AppModel<PartnerDatasource> {

  @override
  String sql() {
    String f = prefs.roleSuperAdmin() ? "" : " where branch='${prefs.getString(key_user_branch)}'";
    return "select id, coalesce(branch, '') as branch, country, name, type from Parthners $f";
  }

  @override
  createDatasource() {
    datasource = PartnerDatasource();
  }

}