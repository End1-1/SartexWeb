import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../utils/consts.dart';
import '../utils/translator.dart';

abstract class SartexDataGridSource extends DataGridSource {
  final List<dynamic> data = [];
  final List<DataGridRow> rows = [];
  final List<GridColumn> columns = [];
  final BuildContext context;
  final Widget editPic = SvgPicture.asset(
    'svg/edit.svg',
    width: 36,
    height: 36,
  );
  final Widget delePic = SvgPicture.asset(
    'svg/delete.svg',
    width: 36,
    height: 36,
  );

  SartexDataGridSource({required this.context});

  void addRows(List<dynamic> d);

  void addColumn(String columnName, {double width = 0}) {
    columns.add(GridColumn(
        allowSorting: columnName != 'edit',
        allowFiltering: columnName != 'edit',
        columnName: columnName,
        autoFitPadding: const EdgeInsets.all(8),
        label: Container(

            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            alignment: Alignment.center,
            child: Text(L.tr(columnName)))));
  }

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    Color getBackgroundColor() {
      int index = effectiveRows.indexOf(row);
      return index % 2 == 0 ? color_datagrid_even : color_datagrid_odd;
    }

    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((e) {
      return Container(
        decoration: BoxDecoration(color: getBackgroundColor()),
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.all(8.0),
        child: e.columnName == 'editdata'
            ? Row(children: [
                MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: InkWell(
                        onTap: () {
                          editData(e.value);
                        },
                        child: editPic)),
                MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: InkWell(
                        onTap: () {
                          removeData(e.value);
                        },
                        child: delePic))
              ])
            : Text(e.value.toString()),
      );
    }).toList());
  }

  Widget getEditWidget(String id) {
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

  Widget removeData(String id) {
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

  void editData(String id) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            children: [getEditWidget(id)],
          );
        }).then((value) {
      if (value != null) {
        print(value);
      }
    });
  }

  void newData() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            children: [getEditWidget('')],
          );
        }).then((value) {
      if (value != null) {
        print(value);
      }
    });
  }
}

class EmptyDataSource extends SartexDataGridSource {
  EmptyDataSource({required super.context});

  @override
  void addRows(List<dynamic> d) {}
}
