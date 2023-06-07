import 'package:sartex/screen/app/app_model.dart';
import 'package:sartex/screen/production_history/production_history_datasource.dart';
import 'package:sartex/utils/http_sql.dart';
import 'package:sartex/utils/prefs.dart';
import 'package:intl/intl.dart';
import 'package:sartex/utils/utils_class.dart';

class ProductionHistoryModel extends AppModel<ProductionHistoryDatasource> {
  static String date1 = DateFormat('yyyy-MM-dd').format(Utils.firstDate(DateTime.now())),
      date2 = DateFormat('yyyy-MM-dd').format(Utils.lastDate(DateTime.now())),
      brand = '', line = '', Model = '';
  static List<String> brandList = [];
  static Map<String, List<String>> modelList = {};

  ProductionHistoryModel() {
    HttpSqlQuery.post({"sl":"select distinct(brand) from Products where branch='${prefs.branch()}'"}).then((value) {
      brandList.clear();
      brandList.addAll(value.map((e)  {
        return e['brand'];
      }));
    });
    HttpSqlQuery.post({"sl":"select distinct(model) as model, brand from Products where branch='${prefs.branch()}'"}).then((value) {
      modelList.clear();
      for (final e in value) {
        if (!modelList.containsKey(e['brand'])) {
          modelList[e['brand']] = [];
        }
        modelList[e['brand']]!.add(e['model']);
      }
    });
  }
  @override
  createDatasource() {
    datasource = ProductionHistoryDatasource();
  }

  @override
  String sql() {
    String w = " where ar.branch='${prefs.branch()}' "
              "and ar.date between '$date1' and '$date2' ";
    if (brand.isNotEmpty) {
      w += "and pd.brand='$brand' ";
    }
    if (line.isNotEmpty) {
      w += "and ar.line='$line'";
    }
    if (Model.isNotEmpty) {
      w += "and pd.Model='$Model' ";
    }
    return "select a.apr_id, pd.PatverN as commesa, ar.date, ar.line, pd.brand, pd.Model, pd.variant_prod, "
          "pd.Colore, ar.size, sum(ar.art_qk) as qanak "
        "from Art ar "
        "left join Apranq a on a.apr_id=ar.apr_id "
        "left join patver_data pd on pd.id=a.pid $w "
        "group by 1, 2, 3, 4 "
        "order by 2, 3, 4 ";
  }

}