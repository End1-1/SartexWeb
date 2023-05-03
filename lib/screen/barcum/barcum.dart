import 'package:flutter/cupertino.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sartex/data/sartex_datagridsource.dart';
import 'package:sartex/screen/preloading/preloading_screen.dart';
import 'package:sartex/utils/translator.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

part 'barcum.freezed.dart';

part 'barcum.g.dart';

@freezed
class Barcum with _$Barcum {
  const factory Barcum(
      {required String? id,
      required String? branch,
      required String? docnum,
      required String? pahest,
      required String? avto,
      required String? date,
      required String? partner,
      required String? country,
      required String? qanak}) = _Barcum;

  factory Barcum.fromJson(Map<String, Object?> json) => _$BarcumFromJson(json);
}

@freezed
class BarcumList with _$BarcumList {
  const factory BarcumList({required List<Barcum> list}) = _BarcumList;

  factory BarcumList.fromJson(Map<String, Object?> json) =>
      _$BarcumListFromJson(json);
}

class BarcumDatasource extends SartexDataGridSource {
  BarcumDatasource() {
    addColumn(L.tr('Document'));
    addColumn(L.tr('Date'));
    addColumn(L.tr('Country'));
    addColumn(L.tr('Receipant'));
    addColumn(L.tr('Avto'));
    addColumn(L.tr('Store'));
    addColumn(L.tr('Total'));
  }

  @override
  void addRows(List d) {
    BarcumList b = BarcumList.fromJson({'list': d});
    rows.addAll(b.list.map<DataGridRow>((e) {
      int i = 0;
      return DataGridRow(cells: [
        DataGridCell(columnName: columnNames[i++], value: e.docnum),
        DataGridCell(columnName: columnNames[i++], value: e.date),
        DataGridCell(columnName: columnNames[i++], value: e.country),
        DataGridCell(columnName: columnNames[i++], value: e.partner),
        DataGridCell(columnName: columnNames[i++], value: e.avto),
        DataGridCell(columnName: columnNames[i++], value: e.pahest),
        DataGridCell(columnName: columnNames[i++], value: e.qanak),
      ]);
    }));
  }

  @override
  Widget getEditWidget(BuildContext context, String id) {
    return PreloadingScreen(docNum: id);
  }
}
