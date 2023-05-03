import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sartex/screen/app/app_model.dart';
import 'package:sartex/screen/patver_data/order_row.dart';

class PatverDataModel extends AppModel<OrderRowDatasource> {
  
  DateTime d1 = DateTime.now();
  DateTime d2 = DateTime.now();
  List<String> statuses = ["'inProgress'", "'done'"];
  List<bool> statusValues = [true, false];
  
  PatverDataModel() {
    d1 = DateTime(d1.year, d1.month, 1);
    d2 = DateTime(d2.year, d2.month, DateUtils.getDaysInMonth(d2.year, d2.month));
  }
  

  @override
  String sql() {
    return "select id, branch, action, User, date, IDPatver, status, PatverN, PatverDate, "
        + "if (cast(pd.parent_id as unsigned)=0, pd.id, pd.parent_id) as parent_id, Katarox, Patviratu, brand, Model, short_code, ModelCod, "
        + "sum(if(action='add', cast(Total as unsigned), 0)) as appended,sum(if(action='cancel', cast(Total as unsigned), 0)) as discarded, "
        + "sum(if(action='add', cast(Total as unsigned), 0)) - sum(if(action='cancel', cast(Total as unsigned), 0)) as Total, "
        + "coalesce(ex.executed, 0) as executed, coalesce(nl.nextload, 0) as nextload "
        + "from patver_data pd "
        + "left join (select parent_id, sum(cast(Total as unsigned)) as executed from patver_data where action='done' group by 1) as ex on ex.parent_id=pd.parent_id  "
        + "left join (select pn.parent_id, sum(d.qanak) as nextload from Docs d left join Apranq a on a.apr_id=d.apr_id left join patver_data pn on pn.id=a.pid) as nl on nl.parent_id=pd.parent_id "
        + "where pd.date between '${DateFormat('yyyy-MM-dd').format(d1)}' and '${DateFormat('yyyy-MM-dd').format(d2)}' and pd.status in (${getStatuses()})"
        "group by IDPatver order by 10";
  }

  @override
  createDatasource() {
    datasource = OrderRowDatasource();
  }

  @override
  String filterString() {
    return '${DateFormat('dd/MM/yyyy').format(d1)} - ${DateFormat('dd/MM/yyyy').format(d2)}';
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