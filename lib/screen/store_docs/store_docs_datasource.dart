import 'package:flutter/cupertino.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sartex/data/sartex_datagridsource.dart';
import 'package:sartex/screen/store_docs/store_docs_edit_widget.dart';
import 'package:sartex/utils/translator.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

part 'store_docs_datasource.freezed.dart';
part 'store_docs_datasource.g.dart';

final Map<String, String> storeDocsTypes = {
'INP':L.tr('Store input'),
'OINP': L.tr('Outsource input'),
  'GUQ': L.tr('Inventorization'),
  'TES': L.tr('TES'),
  'OUT': L.tr("Out"),
};

@freezed
class StoreDocRecord with _$StoreDocRecord {
  const factory StoreDocRecord({
    required String docnum, date, type, pahest, status, qanak,
}) = _StoreDocRecord;
  factory StoreDocRecord.fromJson(Map<String,dynamic> json) => _$StoreDocRecordFromJson(json);
}

class StoreDocsDatasource extends SartexDataGridSource {

  StoreDocsDatasource() {
    addColumn(L.tr('Doc NN'));
    addColumn(L.tr('Date'));
    addColumn(L.tr('Type'));
    addColumn(L.tr('Store'));
    addColumn(L.tr('Status'));
    addColumn(L.tr('Quantity'));

    sumRows.add(GridTableSummaryRow(
        title: L.tr('Total'),
        showSummaryInRow: false,
        columns: [
          GridSummaryColumn(
              name: L.tr('Quantity'),
              columnName: L.tr('Quantity'),
              summaryType: GridSummaryType.sum)
        ], position: GridTableSummaryRowPosition.bottom));
  }

  @override
  void addRows(List d) {
    List<StoreDocRecord> l = [];
    for (final e in d) {
      l.add(StoreDocRecord.fromJson(e));
    }
    rows.addAll(l.map<DataGridRow>((e) {
      int i = 0;
      return DataGridRow(cells:[
        DataGridCell(columnName: columnNames[i++], value: e.docnum),
        DataGridCell(columnName: columnNames[i++], value: e.type),
        DataGridCell(columnName: columnNames[i++], value: e.date),
        DataGridCell(columnName: columnNames[i++], value: e.pahest),
        DataGridCell(columnName: columnNames[i++], value: e.status),
        DataGridCell(columnName: columnNames[i++], value: double.tryParse(e.qanak ?? '0') ?? 0),
      ]);
    }));
  }

  @override
  Widget getEditWidget(BuildContext context, String id) {
    return StoreDocsEditWidget(id);
  }
}