import 'package:flutter/material.dart';
import 'package:sartex/screen/app/app_model.dart';
import 'package:sartex/screen/barcum/barcum.dart';
import 'package:intl/intl.dart';
import 'package:sartex/utils/prefs.dart';

class BarcumModel extends AppModel<BarcumDatasource> {

  DateTime d1 = DateTime.now();
  DateTime d2 = DateTime.now();
  List<String> statuses = ["'draft'", "'ok'"];
  List<bool> statusValues = [true, false];
  int? loaded;

  BarcumModel({required this.loaded}) {
    d1 = DateTime(d1.year, d1.month, 1);
    d2 = DateTime(d2.year, d2.month, DateUtils.getDaysInMonth(d2.year, d2.month));
    if (loaded != null && loaded != 2) {
      statusValues = [false, true];
    }
  }

  @override
  String sql() {
    String qanak = ((loaded ?? 0) == 0) || ((loaded ??0) == 2 ) ? 'qanak' : 'yqanak';
    String f = prefs.roleSuperAdmin() ? "" : " and d.branch='${prefs.branch()}' ";
    return "select d.docnum, d.branch, d.date, d.pahest, d.avto, d.partner, pd.country, d.pahest, sum(d.$qanak) as `qanak` "
        + "from Docs d left "
        + "join Apranq a on a.apr_id=d.apr_id "
        + "left join patver_data pd on pd.id=a.pid "
        + "where d.type='OUT' and pd.date between '${DateFormat('yyyy-MM-dd').format(d1)}' and '${DateFormat('yyyy-MM-dd').format(d2)}' "
        + "and d.status in (${((loaded ?? 0) == 0) || ((loaded ?? 0) == 2) ? getStatuses() : "'ok'"}) $f "
        + "group by d.docnum order by d.date ";

  }

  @override
  createDatasource() {
    datasource = BarcumDatasource(loaded);
  }

  String getStatuses() {
    String s = '';
    for (int i = 0; i < 2; i++) {
      if (statusValues[i]) {
        if (s.isNotEmpty) {
          s += ',';
        }
        s += statuses[i];
      }
    }
    return s;
  }

}