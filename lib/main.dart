import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sartex/utils/consts.dart';
import 'package:sartex/utils/http_sql.dart';
import 'package:sartex/utils/prefs.dart';
import 'package:sartex/utils/routes.dart';
import 'package:sartex/utils/translator.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'data/sql.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  prefs = await SharedPreferences.getInstance();
  await Sql.init();
  L.language = await prefs.getString(key_language) ?? key_language_am;
  String conf = await HttpSqlQuery.postString({'sl':"select * from app_conf where app_key='tr'"});
  TranslatorItemList tl = TranslatorItemList.fromJson({'list': jsonDecode(jsonDecode(conf)[0]['app_value'])});
  for (var e in tl.list) {
    L.items[e.key] = e;
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: SartexRoutes,
    );
  }
}
