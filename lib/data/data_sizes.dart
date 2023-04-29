import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sartex/data/sartex_datagridsource.dart';
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
  SizeDatasource({required super.context, required List data}){
    addRows(data);
    addColumn('Edit');
    addColumn('Id');
    addColumn('Code');
    addColumn('Country');
    addColumn('Name');
    addColumn('size01');
    addColumn('size02');
    addColumn('size03');
    addColumn('size04');
    addColumn('size05');
    addColumn('size06');
    addColumn('size07');
    addColumn('size08');
    addColumn('size09');
    addColumn('size10');
    addColumn('size11');
    addColumn('size12');
  }

  @override
  void addRows(List d) {
    data.addAll(d);
    rows.addAll(d.map<DataGridRow>((e) => DataGridRow(cells: [
      DataGridCell(columnName: 'editdata', value: e.id),
      DataGridCell(columnName: 'id', value: e.id),
      DataGridCell(columnName: 'code', value: e.code),
      DataGridCell(columnName: 'country', value: e.country),
      DataGridCell(columnName: 'name', value: e.name),
      DataGridCell(columnName: 'size01', value: e.size01),
      DataGridCell(columnName: 'size02', value: e.size02),
      DataGridCell(columnName: 'size03', value: e.size03),
      DataGridCell(columnName: 'size04', value: e.size04),
      DataGridCell(columnName: 'size05', value: e.size05),
      DataGridCell(columnName: 'size06', value: e.size06),
      DataGridCell(columnName: 'size07', value: e.size07),
      DataGridCell(columnName: 'size08', value: e.size08),
      DataGridCell(columnName: 'size09', value: e.size09),
      DataGridCell(columnName: 'size10', value: e.size10),
      DataGridCell(columnName: 'size11', value: e.size11),
      DataGridCell(columnName: 'size12', value: e.size12),
    ])));
  }
}