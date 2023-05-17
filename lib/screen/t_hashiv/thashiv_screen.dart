import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:sartex/screen/app_grid_window/app_grid_screen.dart';
import 'package:sartex/utils/consts.dart';
import 'package:sartex/utils/translator.dart';

import 'model.dart';

class THashivScreen extends AppGridScreen {
  THashivScreen(String? aprId)
      : super(
            title: L.tr('T-account'),
            model: THashivModel(aprId ?? ''),
            plusButton: false,
  tapBack: (){

  });

  @override
  void onTapBack(BuildContext context) {
    Navigator.pushNamed(context, route_remains);
  }
}
