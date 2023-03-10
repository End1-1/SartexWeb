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

  void addRows(List<dynamic> d);

  void addColumn(String columnName, String label, double width) {
    columns.add(GridColumn(
        width: width,
        columnName: columnName,
        label: Container(
            decoration: const BoxDecoration(
                color: color_table_header,
                border: Border.fromBorderSide(
                    BorderSide(color: color_table_header_border, width: 0.5))),
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            alignment: Alignment.center,
            child: Text(L.tr(label),
                style: const TextStyle(color: Colors.white)))));
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
        child: e.value.toString() == 'editdata'
            ? Row(children: [
                MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: InkWell(
                        onTap: () {}, child: SvgPicture.asset('svg/edit.svg', width: 36, height: 36,))),
                MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: InkWell(
                        onTap: () {},
                        child: SvgPicture.asset('svg/delete.svg', width: 36, height: 36,)))
              ])
            : Text(e.value.toString()),
      );
    }).toList());
  }
}

class EmptyDataSource extends SartexDataGridSource {
  @override
  void addRows(List<dynamic> d) {}
}
