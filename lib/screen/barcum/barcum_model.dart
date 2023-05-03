import 'package:flutter/material.dart';
import 'package:sartex/screen/app/app_model.dart';
import 'package:sartex/screen/barcum/barcum.dart';
import 'package:intl/intl.dart';

class BarcumModel extends AppModel<BarcumDatasource> {

  DateTime d1 = DateTime.now();
  DateTime d2 = DateTime.now();
  List<String> statuses = ["'draft'", "'ok'"];
  List<bool> statusValues = [true, false];

  BarcumModel() {
    d1 = DateTime(d1.year, d1.month, 1);
    d2 = DateTime(d2.year, d2.month, DateUtils.getDaysInMonth(d2.year, d2.month));
  }

  @override
  String sql() {
    return "select d.docnum, d.branch, d.date, d.pahest, d.avto, d.partner, pd.country, d.pahest, sum(d.qanak) as `qanak` "
        + "from Docs d left "
        + "join Apranq a on a.apr_id=d.apr_id "
        + "left join patver_data pd on pd.id=a.pid "
        + "where d.type='OUT' and pd.date between '${DateFormat('yyyy-MM-dd').format(d1)}' and '${DateFormat('yyyy-MM-dd').format(d2)}' "
        + "and d.status in (${getStatuses()})"
        + "group by d.docnum order by d.date ";

  }

  @override
  createDatasource() {
    datasource = BarcumDatasource();
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