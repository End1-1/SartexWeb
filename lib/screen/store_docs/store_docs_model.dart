import 'package:sartex/screen/app/app_model.dart';
import 'package:sartex/screen/store_docs/store_docs_datasource.dart';
import 'package:sartex/utils/http_sql.dart';
import 'package:sartex/utils/prefs.dart';
import 'package:sartex/utils/utils_class.dart';
import 'package:intl/intl.dart';

class StoreDocsModel extends AppModel<StoreDocsDatasource> {
  static String date1 = DateFormat('yyyy-MM-dd').format(Utils.firstDate(DateTime.now())),
      date2 = DateFormat('yyyy-MM-dd').format(Utils.lastDate(DateTime.now())),
      type = '', pahest = '';


  StoreDocsModel() {

  }

  @override
  createDatasource() {
    datasource = StoreDocsDatasource();
  }

  @override
  String sql() {
    String where = "where d.branch='${prefs.branch()}' and d.date between '$date1' and '$date2' ";
    if (type.isNotEmpty) {
      where += " and d.type='$type' ";
    }
    if (pahest.isNotEmpty) {
      where += " and d.pahest='$pahest' ";
    }
    return "select d.docnum, d.date, d.type, d.pahest, d.status, sum(d.yqanak) as qanak "
    "from Docs d $where "
    "group by 1, 2, 3 "
    "order by 2, 3 ";
  }

}