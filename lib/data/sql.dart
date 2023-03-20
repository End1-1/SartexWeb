import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;

class Sql {
   static late Map<String,dynamic> sqlList;

   static Future<void> init() async {
      String s = await rootBundle.loadString('assets/sql.txt');
      sqlList = jsonDecode(s);

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