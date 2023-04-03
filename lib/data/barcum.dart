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
    required String? IDBarcum,
    required String? DatePreLoading,
    required String? TruckN,
    required String? Receipant,
    required String? DateOfLoading,
    required String? action,
    required String? type,
    required String? IDPatver,
    required String? status,
    required String? Size01,
    required String? Size02,
    required String? Size03,
    required String? Size04,
    required String? Size05,
    required String? Size06,
    required String? Size07,
    required String? Size08,
    required String? Size09,
    required String? Size10,
    required String? Total,
    required String? TotalPatverData
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
    addColumn('id', 'Id', 40);
    addColumn('date', 'Date', 100);
    addColumn('branch', 'Branch', 100);
    addColumn('country', 'Country', 200);
    addColumn('receiver', 'Receiver', 200);
    addColumn('avto', 'Avto', 200);
    addColumn('pahest', 'Store', 200);
    addColumn('total', 'Total', 200);
    addColumn('status', 'Status', 200);
  }

  @override
  void addRows(List d) {
    data.addAll(d);
    rows.addAll(d.map<DataGridRow>((e) => DataGridRow(cells: [
      DataGridCell(columnName: 'editdata', value: e.id),
      DataGridCell(columnName: 'id', value: e.id),
      DataGridCell(columnName: 'date', value: e.date),
      DataGridCell(columnName: 'branch', value: e.branch),
      DataGridCell(columnName: 'country', value: e.country),
      DataGridCell(columnName: 'receiver', value: e.receiver),
      DataGridCell(columnName: 'auto', value: e.TruckN),
      DataGridCell(columnName: 'pahest', value: e.pahest),
      DataGridCell(columnName: 'total', value: e.Total),
      DataGridCell(columnName: 'status', value: e.status),
    ])));
  }

  @override
  Widget getEditWidget(String id) {
    return PreloadingScreen();
  }
}