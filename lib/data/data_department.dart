import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sartex/data/sartex_datagridsource.dart';
import 'package:sartex/data/sql.dart';
import 'package:sartex/utils/consts.dart';
import 'package:sartex/utils/http_sql.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../utils/translator.dart';
import '../widgets/edit_widget.dart';

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
  late List<String> branchList;
  late List<String> typeList;
  
  DepartmentDataSource({required super.context, required List data}) {
    addRows(data);
    addColumn('edit');
    addColumn( 'Id');
    addColumn( 'Branch');
    addColumn('Department');
    addColumn( 'Responsible');
    addColumn( 'Short name');
    addColumn('Type');
    HttpSqlQuery.listDistinctOf('department', 'type').then((value) => typeList = value);
    branchList = ['Sartex', 'Itex'];
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

  @override
  Widget getEditWidget(String id) {
    if (id.isEmpty) {
      return DepartmentEditWidget(dep: const DataDepartment(id: '', branch: '', department: '', patasxanatu: '', short_name: '', type: ''), source: this);
    } else {
      return DepartmentEditWidget(dep: data
          .where((e) => e.id == id)
          .first, source: this);
    }
  }
}

class DepartmentEditWidget extends EditWidget {
  late DataDepartment dep;
  late DepartmentDataSource source;
  final TextEditingController _tecBranch = TextEditingController();
  final TextEditingController _tecDepartment = TextEditingController();
  final TextEditingController _tecPatasxanatu = TextEditingController();
  final TextEditingController _tecShortName = TextEditingController();
  final TextEditingController _tecType = TextEditingController();

  DepartmentEditWidget({super.key, required this.dep, required this.source}) {
    _tecBranch.text = dep.branch;
    _tecDepartment.text = dep.department;
    _tecPatasxanatu.text = dep.patasxanatu;
    _tecShortName.text = dep.short_name;
    _tecType.text = dep.type;
  }

  @override
  void save(BuildContext context, String table, object) {
    dep = dep.copyWith(branch: _tecBranch.text,
      department: _tecDepartment.text,
      patasxanatu: _tecPatasxanatu.text,
      short_name: _tecShortName.text,
      type: _tecType.text
    );
    super.save(context, table, dep);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
              padding: const EdgeInsets.only(top:10, left: 10, right: 10),
              child: Text(L.tr('Branch'),
                  style: const TextStyle(fontSize: 18))),
          Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: SizedBox(width: 300, child: TextFormField(
                onTap: (){valueOfList(context, source.branchList, _tecBranch);},
                readOnly: true,
                controller: _tecBranch,
              ))),
          Padding(
              padding: const EdgeInsets.only(top:10, left: 10, right: 10),
              child: Text(L.tr('Department'),
                  style: const TextStyle(fontSize: 18))),
          Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: SizedBox(width: 300, child: TextFormField(
                controller: _tecDepartment,
              ))),
          Padding(
              padding: const EdgeInsets.only(top:10, left: 10, right: 10),
              child: Text(L.tr('Responsible'),
                  style: const TextStyle(fontSize: 18))),
          Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: SizedBox(width: 300, child: TextFormField(
                controller: _tecPatasxanatu,
              ))),
          Padding(
              padding: const EdgeInsets.only(top:10, left: 10, right: 10),
              child: Text(L.tr('Short name'),
                  style: const TextStyle(fontSize: 18))),
          Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: SizedBox(width: 300, child: TextFormField(
                controller: _tecShortName,
              ))),
          Padding(
              padding: const EdgeInsets.only(top:10, left: 10, right: 10),
              child: Text(L.tr('Type'),
                  style: const TextStyle(fontSize: 18))),
          Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: SizedBox(width: 300, child: TextFormField(
                onTap:(){valueOfList(context, source.typeList, _tecType);},
                readOnly: true,
                controller: _tecType,
              ))),
          saveWidget(context, dep)
        ]);
  }

  @override
  String getTable() {
    return 'department';
  }
}