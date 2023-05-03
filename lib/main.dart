import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sartex/screen/app/app_bloc.dart';
import 'package:sartex/screen/barcum/barcum_screen.dart';
import 'package:sartex/screen/dashboard/dashboard_screen.dart';
import 'package:sartex/screen/departments/departments_screen.dart';
import 'package:sartex/screen/language_editor/language_screen.dart';
import 'package:sartex/screen/login/login_screen.dart';
import 'package:sartex/screen/partners/partners_screen.dart';
import 'package:sartex/screen/patver_data/patver_data_screen.dart';
import 'package:sartex/screen/plan_and_production/plan_and_production_screen.dart';
import 'package:sartex/screen/products/products_screen.dart';
import 'package:sartex/screen/sizes/sizes_screen.dart';
import 'package:sartex/screen/tv/tv_screen.dart';
import 'package:sartex/screen/users/users_screen.dart';
import 'package:sartex/utils/consts.dart';
import 'package:sartex/utils/http_sql.dart';
import 'package:sartex/utils/prefs.dart';
import 'package:sartex/utils/translator.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'data/sql.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  prefs = await SharedPreferences.getInstance();
  await Sql.init();
  L.language = await prefs.getString(key_language) ?? key_language_am;
  String conf = await HttpSqlQuery.postString(
      {'sl': "select * from app_conf where app_key='tr'"});
  TranslatorItemList tl = TranslatorItemList.fromJson(
      {'list': jsonDecode(jsonDecode(conf)[0]['app_value'])});
  for (var e in tl.list) {
    L.items[e.key] = e;
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Sylfaen'
      ),
        debugShowCheckedModeBanner: false, routes: {
      route_root: (context) => const SartexLogin(),
      route_dashboard: (context) => Dashboard(),
      route_tv: (context) => TVScreen(),
      route_patver_data: (context) => BlocProvider(
          create: (_) => AppBloc(GSIdle()), child: PatverDataScreen()),
      route_barcum: (context) =>
          BlocProvider(create: (_) => AppBloc(GSIdle()), child: BarcumScreen()),
      route_production: (context) => PlanAndProductionScreen(),
      route_users: (context) =>
          BlocProvider(create: (_) => AppBloc(GSIdle()), child: UsersScreen()),
      route_sizes: (context) =>
          BlocProvider(create: (_) => AppBloc(GSIdle()), child: SizesScreen()),
      route_department: (context) => BlocProvider(
          create: (_) => AppBloc(GSIdle()), child: DepartmentsScreen()),
      route_partners: (context) => BlocProvider(
          create: (_) => AppBloc(GSIdle()), child: PartnersScreen()),
      route_product: (context) => BlocProvider(
          create: (_) => AppBloc(GSIdle()), child: ProductsScreen()),
      route_language_editor: (context) => LanguageScreen(),
    });
  }
}
