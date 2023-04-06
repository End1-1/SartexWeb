import 'package:flutter/cupertino.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sartex/data/sartex_datagridsource.dart';
import 'package:sartex/screen/preloading/preloading_screen.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

part 'barcum.freezed.dart';
part 'barcum.g.dart';

@freezed
class Barcum with _$Barcum {
  const factory Barcum({
    required String? id,
    required String? branch,
    required String? docnum,
    required String? pahest,
    required String? avto,
    required String? date,
    required String? partner,
    required String? country,
    required String? qanak
}) = _Barcum;
  factory Barcum.fromJson(Map<String, Object?> json) => _$BarcumFromJson(json);
}

@freezed
class BarcumList with _$BarcumList {
  const factory BarcumList({required List<Barcum> list}) = _BarcumList;
  factory BarcumList.fromJson(Map<String, Object?> json) => _$BarcumListFromJson(json);
}

class BarcumDatasource extends SartexDataGridSource {

  BarcumDatasource({required super.context, required List data}) {
    addRows(data);
    addColumn('edit', 'Edit', 100);
    addColumn('id', 'Document', 120);
    addColumn('date', 'Date', 100);
    addColumn('country', 'Country', 200);
    addColumn('receiver', 'Receipant', 200);
    addColumn('avto', 'Avto', 200);
    addColumn('pahest', 'Store', 200);
    addColumn('total', 'Total', 200);
  }

  @override
  void addRows(List d) {
    data.addAll(d);
    rows.addAll(d.map<DataGridRow>((e) => DataGridRow(cells: [
      DataGridCell(columnName: 'editdata', value: e.docnum),
      DataGridCell(columnName: 'docnum', value: e.docnum),
      DataGridCell(columnName: 'date', value: e.date),
      DataGridCell(columnName: 'country', value: e.country),
      DataGridCell(columnName: 'receiver', value: e.partner),
      DataGridCell(columnName: 'auto', value: e.avto),
      DataGridCell(columnName: 'pahest', value: e.pahest),
      DataGridCell(columnName: 'total', value: e.qanak),
    ])));
  }

  @override
  Widget getEditWidget(String id) {
    return PreloadingScreen(docNum: id);
  }
}