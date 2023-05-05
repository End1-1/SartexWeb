import 'package:flutter/cupertino.dart';
import 'package:sartex/screen/app_grid_window/app_grid_screen.dart';
import 'package:sartex/screen/barcum/barcum_model.dart';
import 'package:sartex/screen/barcum/filter_widget.dart';
import 'package:sartex/utils/prefs.dart';
import 'package:sartex/utils/translator.dart';

class BarcumScreen extends AppGridScreen {
  BarcumScreen()
      : super(
            title: L.tr('Loading'),
            model: BarcumModel(),
            filterButton: true,
            plusButton: prefs.roleWrite("2"));

  void showFilter(BuildContext context) {
    BarcumFilter.filter(context, model).then((value) {
      if (value != null) {
        refreshData(context);
      }
    });
  }
}
