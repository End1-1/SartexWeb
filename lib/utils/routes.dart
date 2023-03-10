import 'package:flutter/cupertino.dart';
import 'package:sartex/screen/login/login_screen.dart';

import '../screen/dashboard/dashboard_screen.dart';
import 'consts.dart';

Map<String, Widget Function(BuildContext)> SartexRoutes = {
  route_root: (context) => SartexLogin(),
  route_dashboard: (context) => Dashboard(),
};