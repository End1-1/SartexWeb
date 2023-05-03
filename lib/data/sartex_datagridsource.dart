import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../utils/translator.dart';

abstract class SartexDataGridSource extends DataGridSource {
  final List<DataGridRow> rows = [];
  final List<GridColumn> columns = [];
  final List<String> columnNames = [];

  final Widget delePic = SvgPicture.asset(
    'svg/delete.svg',
    width: 36,
    height: 36,
  );

  void addRows(List<dynamic> d);

  void clearData() {
    rows.clear();
  }

  void addColumn(String columnName, {double width = 0, sort = true, filter = true}) {
    columnNames.add(columnName);
    columns.add(GridColumn(
        allowSorting: columnName != 'edit',
        allowFiltering: columnName != 'edit',
        visible: columnName != 'edit',
        columnName: columnName,
        autoFitPadding: const EdgeInsets.all(8),
        label: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            alignment: Alignment.center,
            child: Text(L.tr(columnName), style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold)))));
  }

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((e) {
      return Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.all(8.0),
        child: Text(e.value.toString()),
      );
    }).toList());
  }

  Widget getEditWidget(BuildContext context, String id) {
    return Column(children: [
      Container(
          width: 200,
          height: 200,
          alignment: Alignment.center,
          child: const Text("Unimplemented", style: TextStyle(fontSize: 28))),
      TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(L.tr('Close')))
    ]);
  }

  Widget removeData(BuildContext context, String id) {
    return Column(children: [
      Container(
          width: 200,
          height: 200,
          alignment: Alignment.center,
          child: const Text("Unimplemented", style: TextStyle(fontSize: 28))),
      TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(L.tr('Close')))
    ]);
  }

  Future<void> editData(BuildContext context, String id) async {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            children: [getEditWidget(context, id)],
          );
        }).then((value) {
      if (value != null) {
        print(value);
      }
    });
  }

  void newData(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            children: [getEditWidget(context, '')],
          );
        }).then((value) {
      if (value != null) {
        print(value);
      }
    });
  }

  @override
  bool shouldRecalculateColumnWidths() => true;
}

class EmptyDataSource extends SartexDataGridSource {
  @override
  void addRows(List<dynamic> d) {}
}
