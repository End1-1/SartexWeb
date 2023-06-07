import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sartex/screen/app_grid_window/app_grid_screen.dart';
import 'package:sartex/screen/store_docs/store_docs_filter.dart';
import 'package:sartex/screen/store_docs/store_docs_model.dart';
import 'package:sartex/utils/consts.dart';
import 'package:sartex/utils/translator.dart';

class StoreDocsScreen extends AppGridScreen {
  StoreDocsScreen({super.key})
      : super(title: L.tr('Store documents'), model: StoreDocsModel(), filterButton: true, plusButton: false);

  static void open(BuildContext context) {
    showDialog(context: context, builder: (context) {
      return SimpleDialog(children: [StoreDocsFilter(StoreDocsModel())]);
    }).then((value) {
        Navigator.pushNamed(context, route_store_documents);
    });
  }

  @override
  void showFilter(BuildContext context) {
    showDialog(context: context, builder: (context) {
      return SimpleDialog(children: [StoreDocsFilter(model as StoreDocsModel)]);
    }).then((value) {
      if (value ?? false) {
        refreshData(context);
      }
    });
  }

  @override
  void onTapBack(BuildContext context) {
    Navigator.pushNamed(context, route_store_documents);
  }
}
