import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sartex/data/sartex_datagridsource.dart';
import 'package:sartex/screen/app/app_model.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../utils/translator.dart';

class LanguageDatasource extends SartexDataGridSource {

  final editingController = TextEditingController();
  dynamic newCellValue;

  LanguageDatasource() {
    addColumn('Key');
    addColumn('Am');
    addColumn('It');
    addRows([]);
  }

  @override
  void addRows(List d) {
    rows.addAll(L.items.values.toList().map((e) {
        return DataGridRow(cells: [
          DataGridCell(columnName: 'Key', value: e.key),
          DataGridCell(columnName: 'Am', value:e.am),
          DataGridCell(columnName: 'It', value: e.it)
        ]);
    }));
  }

  @override
  Widget? buildEditWidget(DataGridRow dataGridRow, RowColumnIndex rowColumnIndex,
      GridColumn column, CellSubmit submitCell) {
    final String displayText = dataGridRow
        .getCells()
        .firstWhere((DataGridCell dataGridCell) =>
    dataGridCell.columnName == column.columnName)
        ?.value
        ?.toString() ??
        '';

    // The new cell value must be reset.
    // To avoid committing the [DataGridCell] value that was previously edited
    // into the current non-modified [DataGridCell].
    newCellValue = null;

    return Container(
      padding: const EdgeInsets.all(8.0),
      alignment:  Alignment.centerLeft,
      child: TextField(
        autofocus: true,
        controller: editingController..text = displayText,
        textAlign:  TextAlign.left,
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 16.0),
        ),
        keyboardType: TextInputType.text,
        onChanged: (String value) {
          if (value.isNotEmpty) {
              newCellValue = value;
          } else {
            newCellValue = null;
          }
        },
        onSubmitted: (String value) {
          submitCell();
        },
      ),
    );
  }

  @override
  Future<void> onCellSubmit(DataGridRow dataGridRow, RowColumnIndex rowColumnIndex,
      GridColumn column) async {
    final dynamic oldValue = dataGridRow
        .getCells()
        .firstWhere((DataGridCell dataGridCell) =>
    dataGridCell.columnName == column.columnName)
        ?.value ??
        '';

    final int dataRowIndex = rows.indexOf(dataGridRow);

    if (newCellValue == null || oldValue == newCellValue) {
      return;
    }

    if (column.columnName == 'Am') {
      L.items[dataGridRow.getCells()[0].value] = TranslatorItem(key: dataGridRow.getCells()[0].value,  am: newCellValue, it: dataGridRow.getCells()[2].value);
      rows[dataRowIndex].getCells()[rowColumnIndex.columnIndex] =
          DataGridCell(columnName: 'Am', value: newCellValue);
    } else if (column.columnName == 'It') {
      L.items[dataGridRow.getCells()[0].value] = TranslatorItem(key: dataGridRow.getCells()[0].value,  it: newCellValue, am: dataGridRow.getCells()[1].value);
      rows[dataRowIndex].getCells()[rowColumnIndex.columnIndex] =
          DataGridCell(columnName: 'It', value: newCellValue);
    }

  }

}

class LanguageModel extends AppModel<LanguageDatasource>{
  int editRowNumber = -1;

  List<TranslatorItem> filteredItem() {
    return L.items.values.toList();
  }

  @override
  String sql() {
    return "select 1";
  }

  @override
  createDatasource() {

  }
}