

Map<String,String> sqlList = {
"department":"",
"Products":"",
"Docs":"select * from Docs",
"Sizes":"",
"Parthners":"",
"productStatuses":"select id,coalesce(branch, '')as branch, checkStatus,prod_status from productStatuses",
"patver_data":"",
"open_patver_data":"select 0 as `main`, id, branch, action, User, date, IDPatver, status, PatverN, PatverDate, "
    "if (cast(coalesce(parent_id, '0') as signed)=0, id, parent_id) as parent_id, "
    "Katarox, Patviratu, brand, Model, short_code, ModelCod,"
    "sum(if(action='add',1,-1)*cast(Total as decimal(14,0))) as Total,country,size_standart,variant_prod, "
    "sum(if(action='add',1,-1)*cast(Size01 as decimal(14,0))) as Size01, "
    "sum(if(action='add',1,-1)*cast(Size02 as decimal(14,0))) as Size02, "
    "sum(if(action='add',1,-1)*cast(Size03 as decimal(14,0))) as Size03, "
    "sum(if(action='add',1,-1)*cast(Size04 as decimal(14,0))) as Size04, "
    "sum(if(action='add',1,-1)*cast(Size05 as decimal(14,0))) as Size05, "
    "sum(if(action='add',1,-1)*cast(Size06 as decimal(14,0))) as Size06, "
    "sum(if(action='add',1,-1)*cast(Size07 as decimal(14,0))) as Size07, "
    "sum(if(action='add',1,-1)*cast(Size08 as decimal(14,0))) as Size08, "
    "sum(if(action='add',1,-1)*cast(Size09 as decimal(14,0))) as Size09, "
    "sum(if(action='add',1,-1)*cast(Size10 as decimal(14,0))) as Size10, "
    "sum(if(action='add',1,-1)*cast(Size11 as decimal(14,0))) as Size11, "
    "sum(if(action='add',1,-1)*cast(Size12 as decimal(14,0))) as Size12, "
    "Colore from patver_data %where1% group by 11      "
    "union      "
    "select 1 as `main`, id, branch, action, User, date, IDPatver, status, PatverN, PatverDate, "
    "if (cast(coalesce(parent_id, '0') as signed)=0, id, parent_id) as parent_id, Katarox, Patviratu, "
    "brand, Model, short_code, ModelCod,Total,country,size_standart,variant_prod, "
    "Size01, Size02, Size03, Size04, Size05, Size06, Size07, Size08, Size09, Size10, Size11, Size12, Colore "
    "from patver_data %where2% order by 11, 1, 2 ",
"barcum":" ",
"production":"select  distinct(DocN) as DocN, p.date, pd.brand, pd.modelCod, pd.country from Production p left join Apranq a on a.apr_id=p.apr_id left join patver_data pd on pd.id=a.pid"
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

   static String insertKeys(String table, Map<String, dynamic> values) {
      String keys = '';
      values.forEach((key, value) {
         if (keys.isNotEmpty) {
            keys += ',';
         }
         keys += key;
      });
      return 'insert into $table ($keys) values ';
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