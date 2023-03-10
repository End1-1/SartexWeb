import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;

class Sql {
   static late Map<String,dynamic> sqlList;

   static Future<void> init() async {
      String s = await rootBundle.loadString('assets/sql.txt');
      sqlList = jsonDecode(s);

      print(sqlList);
   }

}