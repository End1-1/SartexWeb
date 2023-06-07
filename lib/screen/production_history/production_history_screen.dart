import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sartex/screen/app_grid_window/app_grid_screen.dart';
import 'package:sartex/screen/production_history/production_history_filter.dart';
import 'package:sartex/screen/production_history/production_history_model.dart';
import 'package:sartex/utils/consts.dart';
import 'package:sartex/utils/translator.dart';

class ProductionHistoryScreen extends AppGridScreen {
  ProductionHistoryScreen() : super(title: L.tr('Production'), model: ProductionHistoryModel(), filterButton: true, plusButton: false);

  static void open(BuildContext context) {
    showDialog(context: context, builder: (context) {
      return SimpleDialog(children: [ProductionHistoryFilter(ProductionHistoryModel())]);
    }).then((value) {
        Navigator.pushNamed(context, route_production_history);

    });

  }

  @override
  void showFilter(BuildContext context) {
    showDialog(context: context, builder: (context) {
      return SimpleDialog(children: [ProductionHistoryFilter(model as ProductionHistoryModel)]);
    }).then((value) {
      if (value ?? false) {
        refreshData(context);
      }
    });
  }

}