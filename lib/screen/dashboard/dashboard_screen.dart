import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sartex/screen/app/app_screen.dart';

import '../../utils/translator.dart';
import '../../widgets/svg_button.dart';
import 'dashboard_model.dart';
import 'dashboard_state.dart';

class Dashboard extends App {
  Dashboard() : super(title: '', model: DashboardModel());

  @override
  Widget body(BuildContext context) {
    return Align(
        alignment: Alignment.center,
        child: Text(L.tr('Get started!')));
  }
}

class _SartexDashboardScreen  {



  Widget _appendButton(BuildContext context, String location) {
    switch (location) {
      case locUsers:
      case locDepartement:
      case locProducts:
      case locSizes:
      case locPathners:
      case locProductStatuses:
      case locOrders:
      case locDocs:
      case locBarcum:
        return SvgButton(
             onTap: () {
            //   showDialog(
            //       barrierDismissible: false,
            //       context: context,
            //       builder: (BuildContext context) {
            //         return SimpleDialog(
            //           children: [_model!.datasource.getEditWidget('')],
            //         );
            //       });
            },
            assetPath: 'svg/plusfolder.svg');
    }
    return Container();
  }
}
