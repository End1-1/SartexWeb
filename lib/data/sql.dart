import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;

Map<String,String> sqlList = {
"Users":"select * from Users",
"department":"select id,branch,department,patasxanatu,short_name, type from department",
"Products":"select * from Products",
"Docs":"select * from Docs",
"Sizes":"select id,code,country,name,size01,size02,size03,size04,size05,size06,size07,size08,size09,size10,coalesce(size11, '') as size11 from Sizes",
"Parthners":"select id, coalesce(branch, '') as branch, country, name, type from Parthners",
"productStatuses":"select id,coalesce(branch, '')as branch, checkStatus,prod_status from productStatuses",
"patver_data":"select id, branch, action, User, date, IDPatver, status, PatverN, PatverDate, if (cast(parent_id as unsigned)=0, id, parent_id) as parent_id, Katarox, Patviratu, brand, Model, short_code, ModelCod, sum(if(action='add', cast(Total as unsigned), 0)) as appended,sum(if(action='cancel', cast(Total as unsigned), 0)) as discarded, sum(if(action='add', cast(Total as unsigned), 0)) - sum(if(action='cancel', cast(Total as unsigned), 0)) as Total from patver_data group by IDPatver order by 10",
"open_patver_data":"select 0 as `main`, id, branch, action, User, date, IDPatver, status, PatverN, PatverDate, if (cast(parent_id as signed)=0, id, parent_id) as parent_id, Katarox, Patviratu, brand, Model, short_code, ModelCod,sum(if(action='add',1,-1)*cast(Total as decimal(14,0))) as Total,country,size_standart,variant_prod, sum(if(action='add',1,-1)*cast(Size01 as decimal(14,0))) as Size01, sum(if(action='add',1,-1)*cast(Size02 as decimal(14,0))) as Size02, sum(if(action='add',1,-1)*cast(Size03 as decimal(14,0))) as Size03, sum(if(action='add',1,-1)*cast(Size04 as decimal(14,0))) as Size04, sum(if(action='add',1,-1)*cast(Size05 as decimal(14,0))) as Size05, sum(if(action='add',1,-1)*cast(Size06 as decimal(14,0))) as Size06, sum(if(action='add',1,-1)*cast(Size07 as decimal(14,0))) as Size07, sum(if(action='add',1,-1)*cast(Size08 as decimal(14,0))) as Size08, sum(if(action='add',1,-1)*cast(Size09 as decimal(14,0))) as Size09, sum(if(action='add',1,-1)*cast(Size10 as decimal(14,0))) as Size10, Colore from patver_data %where1% group by 11      union      select 1 as `main`, id, branch, action, User, date, IDPatver, status, PatverN, PatverDate, if (cast(parent_id as signed)=0, id, parent_id) as parent_id, Katarox, Patviratu, brand, Model, short_code, ModelCod,Total,country,size_standart,variant_prod, Size01, Size02, Size03, Size04, Size05, Size06, Size07, Size08, Size09, Size10, Colore from patver_data %where2% order by 11, 1, 2 ",
"barcum":"select d.docnum, d.branch, d.date, d.pahest, d.avto, d.partner, pd.country, d.pahest, sum(d.qanak) as `qanak` from Docs d left join Apranq a on a.apr_id=d.apr_id left join patver_data pd on pd.id=a.pid where d.status='draft' and d.type='OUT' group by d.docnum order by d.date "
};

class Sql {
   static Future<void> init() async {
      print(sqlList);
   }

   static String insert (String table, Map<String, dynamic> values) {
      String keys = '', vals = '';
      values.forEach((key, value) {
         if (keys.isNotEmpty) {
            keys += ',';
            vals += ',';
         }
         keys += '$key';
         vals += "'$value'";
      });
      return 'insert into $table ($keys) values ($vals)';
   }

   static String update(String table, Map<String, dynamic> values) {
      String sql = '';
      values.forEach((key, value) {
         if (sql.isNotEmpty) {
            sql += ',';
         }
         sql += "$key='$value'";
      });
      sql = "update $table set $sql where id=${values['id']}";
      return sql;
   }

}