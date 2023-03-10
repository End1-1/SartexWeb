import 'package:flutter/material.dart';
import 'package:sartex/utils/prefs.dart';
import 'package:sartex/utils/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'data/sql.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  prefs = await SharedPreferences.getInstance();
  await Sql.init();
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
