import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sartex/data/sartex_datagridsource.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

part 'data_sizes.freezed.dart';
part 'data_sizes.g.dart';

@freezed
class Size with _$Size {
  const Size._();

  const factory Size({
    required String id,
    required String code,
    required String country,
    required String name,
    required String size01,
    required String size02,
    required String size03,
    required String size04,
    required String size05,
    required String size06,
    required String size07,
    required String size08,
    required String size09,
    required String size10
}) = _Size;

  factory Size.fromJson(Map<String, dynamic> json) => _$SizeFromJson(json);

  String sizeOfIndex(int i) {
    switch (i) {
      case 1:
        return size01;
      case 2:
        return size02;
      case 3:
        return size03;
      case 4:
        return size04;
      case 5:
        return size05;
      case 6:
        return size06;
      case 7:
        return size07;
      case 8:
        return size08;
      case 9:
        return size09;
      case 10:
        return size10;
      default:
        throw Exception('Invalid index for size');
    }
  }
}

@freezed
class SizeList with _$SizeList {
  const factory SizeList({required List<Size> sizes}) = _SizeList;
  factory SizeList.fromJson(Map<String, dynamic> json) => _$SizeListFromJson(json);
}

class SizeDatasource extends SartexDataGridSource {
  SizeDatasource({required super.context, required List data}){
    addRows(data);
    addColumn('edit', 'Edit', 100);
    addColumn('id', 'Id', 40);
    addColumn('code', 'Code', 100);
    addColumn('country', 'Country', 200);
    addColumn('name', 'Name', 200);
    addColumn('size01', '1', 70);
    addColumn('size02', '2', 70);
    addColumn('size03', '3', 70);
    addColumn('size04', '4', 70);
    addColumn('size05', '5', 70);
    addColumn('size06', '6', 70);
    addColumn('size07', '7', 70);
    addColumn('size08', '8', 70);
    addColumn('size09', '9', 70);
    addColumn('size10', '10', 70);;
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
    ])));
  }
}