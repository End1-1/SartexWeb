import 'package:flutter/material.dart';
import 'package:sartex/screen/app/app_screen.dart';

import '../../utils/translator.dart';
import 'dashboard_model.dart';

class Dashboard extends App {
  Dashboard() : super(title: '', model: DashboardModel());

  @override
  Widget body(BuildContext context) {
    return Align(
        alignment: Alignment.center,
        child: Text(L.tr('Get started!')));
  }
}
