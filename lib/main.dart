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
import 'package:sartex/screen/login_pin/login_pin_screen.dart';
import 'package:sartex/screen/partners/partners_screen.dart';
import 'package:sartex/screen/patver_data/patver_data_screen.dart';
import 'package:sartex/screen/plan_and_production/plan_and_production_screen.dart';
import 'package:sartex/screen/products/products_screen.dart';
import 'package:sartex/screen/remains/remains_screen.dart';
import 'package:sartex/screen/sizes/sizes_screen.dart';
import 'package:sartex/screen/t_hashiv/thashiv_screen.dart';
import 'package:sartex/screen/tv/tv_screen.dart';
import 'package:sartex/screen/users/users_screen.dart';
import 'package:sartex/screen/users_role/users_role_screen.dart';
import 'package:sartex/utils/consts.dart';
import 'package:sartex/utils/http_sql.dart';
import 'package:sartex/utils/prefs.dart';
import 'package:sartex/utils/translator.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'data/sql.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  prefs = await SharedPreferences.getInstance();
  prefs.resetRoles();
  await Sql.init();
  L.language = await prefs.getString(key_language) ?? key_language_am;
  String conf = await HttpSqlQuery.postString(
      {'sl': "select * from app_conf where app_key='tr'"});
  TranslatorItemList tl = TranslatorItemList.fromJson(
      {'list': jsonDecode(jsonDecode(conf)[0]['app_value'])});
  for (var e in tl.list) {
    L.items[e.key] = e;
  }
  var result = await HttpSqlQuery.post({
    'sl':
        "select user_id from Sesions where sesion_id='${prefs.session()}' and status=1"
  });
  if (result.isEmpty) {
    prefs.setInt(key_user_id, 0);
  } else {
    prefs.setInt(key_user_id, int.tryParse(result[0]['user_id']) ?? 0);
    result = await HttpSqlQuery.post(
        {'sl': "select role_id from Users where id=${result[0]['user_id']}"});
    if (result.isNotEmpty) {
      result = await HttpSqlQuery.post(
          {'sl': "select id from RoleNames where name='${result[0]['role_id']}'"});
      if (result.isEmpty) {
        prefs.setInt(key_user_id, 0);
      } else {
        result = await HttpSqlQuery.post({
          'sl':
              "select action, read_flag, write_flag from RoleData where role_id=${result[0]['id']}"
        });
        for (var e in result) {
          prefs.setRoleAction(e['action'], e['read_flag'], e['write_flag']);
        }
      }
    } else {
      prefs.setInt(key_user_id, 0);
    }
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        // theme: ThemeData(
        //   fontFamily: 'Sylfaen'
        // ),
      onGenerateRoute: (settings) {
        if (settings.name ==  route_thashiv) {
          return MaterialPageRoute(settings: settings, builder: (context){return  BlocProvider(
              create: (_) => AppBloc(GSIdle()), child: THashivScreen((settings.arguments ?? '') as String));});
        } else if (settings.name == route_barcum) {
          return MaterialPageRoute(settings: settings, builder: (context){return
            BlocProvider(
                create: (_) => AppBloc(GSIdle()), child: BarcumScreen(settings.arguments as int?)); });
          } else if (settings.name == route_tv) {
          return MaterialPageRoute(settings: settings, builder: (context){return TVScreen((settings.arguments ?? false) as bool);});
        }
        return null;
      },
        debugShowCheckedModeBanner: false,
        routes: {
          route_root: (context) => const SartexLogin(),
          route_dashboard: (context) => Dashboard(),
          route_patver_data: (context) => BlocProvider(
              create: (_) => AppBloc(GSIdle()), child: PatverDataScreen()),

          route_production: (context) => PlanAndProductionScreen(),
          route_users: (context) => BlocProvider(
              create: (_) => AppBloc(GSIdle()), child: UsersScreen()),
          route_sizes: (context) => BlocProvider(
              create: (_) => AppBloc(GSIdle()), child: SizesScreen()),
          route_department: (context) => BlocProvider(
              create: (_) => AppBloc(GSIdle()), child: DepartmentsScreen()),
          route_partners: (context) => BlocProvider(
              create: (_) => AppBloc(GSIdle()), child: PartnersScreen()),
          route_product: (context) => BlocProvider(
              create: (_) => AppBloc(GSIdle()), child: ProductsScreen()),
          route_language_editor: (context) => LanguageScreen(),
          route_users_role: (_) => BlocProvider(
              create: (_) => AppBloc(GSIdle()), child: UsersRoleScreen()),
          route_remains: (_) => BlocProvider(
              create: (_) => AppBloc(GSIdle()), child: RemainsScreen()),
          // route_thashiv: (_) => BlocProvider(
          //     create: (_) => AppBloc(GSIdle()), child: THashivScreen(ModalRoute.of(context)?.settings.arguments as String?)),
          route_login_pin: (context) => LoginPinScreen()
        });
  }
}
