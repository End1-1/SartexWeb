import 'package:flutter/cupertino.dart';
import 'package:sartex/screen/app_grid_window/app_grid_screen.dart';
import 'package:sartex/screen/patver_data/patver_data_model.dart';
import 'package:sartex/utils/translator.dart';

import 'filter_widget.dart';

class PatverDataScreen extends AppGridScreen {
  PatverDataScreen({super.key})
      : super(
            title: L.tr('Orders'),
            model: PatverDataModel(),
            filterButton: true);

  void showFilter(BuildContext context) {
    PatverDataFilter.filter(context, model).then((value) {
      if (value != null) {
        refreshData(context);
      }
    });
  }
}
