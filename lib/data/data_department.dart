import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sartex/data/sartex_datagridsource.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

part 'data_department.freezed.dart';
part 'data_department.g.dart';

@freezed
class DataDepartment with _$DataDepartment {
  const factory DataDepartment(
      {required String id,
      required String branch,
      required String department,
      required String patasxanatu,
      required String short_name,
      required String type}) = _DataDepartment;

  factory DataDepartment.fromJson(Map<String, dynamic> json) =>
      _$DataDepartmentFromJson(json);
}

@freezed
class DataDepartmentList with _$DataDepartmentList {
  const factory DataDepartmentList(
      {required List<DataDepartment> departments}) = _DataDepartmentList;

  factory DataDepartmentList.fromJson(Map<String, dynamic> json) =>
      _$DataDepartmentListFromJson(json);
}

class DepartmentDataSource extends SartexDataGridSource {
  DepartmentDataSource({required super.context, required List<DataDepartment> depData}) {
    addRows(depData);
    addColumn('edit', 'Edit', 100);
    addColumn('id', 'Id', 40);
    addColumn('branch', 'Branch', 100);
    addColumn('department', 'Department', 200);
    addColumn('patasxanatu', 'Responsible', 200);
    addColumn('short_name', 'Short name', 200);
    addColumn('type', 'Type', 200);
  }

  @override
  void addRows(List d) {
    data.addAll(d);
    rows.addAll(d.map<DataGridRow>((e) => DataGridRow(cells: [
          DataGridCell(columnName: 'editdata', value: e.id),
          DataGridCell(columnName: 'id', value: e.id),
          DataGridCell(columnName: 'branch', value: e.branch),
          DataGridCell(columnName: 'department', value: e.department),
          DataGridCell(columnName: 'patasxanatu', value: e.patasxanatu),
          DataGridCell(columnName: 'short_name', value: e.short_name),
          DataGridCell(columnName: 'type', value: e.type),
        ])));
  }
}
