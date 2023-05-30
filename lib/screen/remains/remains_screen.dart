import 'package:flutter/cupertino.dart';
import 'package:sartex/screen/app_grid_window/app_grid_screen.dart';
import 'package:sartex/screen/remains/model.dart';
import 'package:sartex/utils/consts.dart';
import 'package:sartex/utils/translator.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class RemainsScreen extends AppGridScreen {
  RemainsScreen() : super(title: L.tr('Stock remains'), model: RemainsModel(), plusButton: false);

  @override
  cellTap(BuildContext context, DataGridCellTapDetails details) {
    var aprId = model.datasource
        .effectiveRows[details.rowColumnIndex.rowIndex - 1]
        .getCells()[0]
        .value;

    Navigator.pushNamed(context, route_thashiv, arguments: aprId);
  }
}