import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sartex/data/sartex_datagridsource.dart';
import 'package:sartex/utils/translator.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

part 'data_sizes.freezed.dart';
part 'data_sizes.g.dart';

@freezed
class DataSize with _$DataSize {
  const DataSize._();

  const factory DataSize({
    required String id,
    required String? code,
    required String? country,
    required String? name,
    required String? size01,
    required String? size02,
    required String? size03,
    required String? size04,
    required String? size05,
    required String? size06,
    required String? size07,
    required String? size08,
    required String? size09,
    required String? size10,
    required String? size11,
    required String? size12
}) = _DataSize;

  factory DataSize.fromJson(Map<String, dynamic> json) => _$DataSizeFromJson(json);

  String sizeOfIndex(int i) {
    String? s;
    switch (i) {
      case 1:
        s = size01;
        break;
      case 2:
        s = size02;
        break;
      case 3:
        s = size03;
        break;
      case 4:
        s = size04;
        break;
      case 5:
        s = size05;
        break;
      case 6:
        s = size06;
        break;
      case 7:
        s = size07;
        break;
      case 8:
        s = size08;
        break;
      case 9:
         s = size09;
         break;
      case 10:
        s = size10;
        break;
      case 11:
        s = size11;
        break;
      case 12:
        s = size12;
        break;
      default:
        throw Exception('Invalid index for size');
    }
    return s ?? '0';
  }
}

@freezed
class SizeList with _$SizeList {
  const factory SizeList({required List<DataSize> sizes}) = _SizeList;
  factory SizeList.fromJson(Map<String, dynamic> json) => _$SizeListFromJson(json);
}

class SizeDatasource extends SartexDataGridSource {
  SizeDatasource(){
    addColumn(L.tr('Id'));
    addColumn(L.tr('Code'));
    addColumn(L.tr('Country'));
    addColumn(L.tr('Name'));
    addColumn(L.tr('size01'));
    addColumn(L.tr('size02'));
    addColumn(L.tr('size03'));
    addColumn(L.tr('size04'));
    addColumn(L.tr('size05'));
    addColumn(L.tr('size06'));
    addColumn(L.tr('size07'));
    addColumn(L.tr('size08'));
    addColumn(L.tr('size09'));
    addColumn(L.tr('size10'));
    addColumn(L.tr('size11'));
    addColumn(L.tr('size12'));
  }

  @override
  void addRows(List d) {
    SizeList sl = SizeList.fromJson({'sizes':d});
    rows.addAll(sl.sizes.map<DataGridRow>((e) {
      int i = 0;
        return DataGridRow(cells: [
      DataGridCell(columnName: columnNames[i++], value: e.id),
      DataGridCell(columnName: columnNames[i++], value: e.code),
      DataGridCell(columnName: columnNames[i++], value: e.country),
      DataGridCell(columnName: columnNames[i++], value: e.name),
      DataGridCell(columnName: columnNames[i++], value: e.size01),
      DataGridCell(columnName: columnNames[i++], value: e.size02),
      DataGridCell(columnName: columnNames[i++], value: e.size03),
      DataGridCell(columnName: columnNames[i++], value: e.size04),
      DataGridCell(columnName: columnNames[i++], value: e.size05),
      DataGridCell(columnName: columnNames[i++], value: e.size06),
      DataGridCell(columnName: columnNames[i++], value: e.size07),
      DataGridCell(columnName: columnNames[i++], value: e.size08),
      DataGridCell(columnName: columnNames[i++], value: e.size09),
      DataGridCell(columnName: columnNames[i++], value: e.size10),
      DataGridCell(columnName: columnNames[i++], value: e.size11),
      DataGridCell(columnName: columnNames[i++], value: e.size12),
    ]);}));
  }
}