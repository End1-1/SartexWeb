import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sartex/data/sartex_datagridsource.dart';
import 'package:sartex/data/sql.dart';
import 'package:sartex/utils/consts.dart';
import 'package:sartex/utils/http_sql.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../utils/translator.dart';
import '../../widgets/edit_widget.dart';

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
  DepartmentDataSource() {
    addColumn(L.tr('Id'));
    addColumn(L.tr('Branc'));
    addColumn(L.tr('Department'));
    addColumn(L.tr('Responsible'));
    addColumn(L.tr('Short name'));
    addColumn(L.tr('Type'));
  }

  @override
  void addRows(List d) {
    DataDepartmentList dl = DataDepartmentList.fromJson({'departments': d});
    rows.addAll(dl.departments.map<DataGridRow>((e) {
      int i = 0;
      return DataGridRow(cells: [
        DataGridCell(columnName: columnNames[i++], value: e.id),
        DataGridCell(columnName: columnNames[i++], value: e.branch),
        DataGridCell(columnName: columnNames[i++], value: e.department),
        DataGridCell(columnName: columnNames[i++], value: e.patasxanatu),
        DataGridCell(columnName: columnNames[i++], value: e.short_name),
        DataGridCell(columnName: columnNames[i++], value: e.type),
      ]);
    }));
  }

  @override
  Widget getEditWidget(BuildContext context, String id) {
    return DepartmentEditWidget(id: id);
  }
}

class DepartmentEditWidget extends EditWidget {
  DataDepartment dep = const DataDepartment(
      id: '',
      branch: '',
      department: '',
      patasxanatu: '',
      short_name: '',
      type: '');
  static late List<String> branchList;
  static late List<String> typeList;

  final TextEditingController _tecBranch = TextEditingController();
  final TextEditingController _tecDepartment = TextEditingController();
  final TextEditingController _tecPatasxanatu = TextEditingController();
  final TextEditingController _tecShortName = TextEditingController();
  final TextEditingController _tecType = TextEditingController();

  static Future<void> init() async {
    branchList = ['Sartex', 'Itex'];
    var value = await HttpSqlQuery.listDistinctOf('department', 'type');
    typeList = value;
  }

  DepartmentEditWidget({super.key, required String id}) {
    if (id.isNotEmpty) {
      HttpSqlQuery.post({
        'sl':
            "select id,branch,department,patasxanatu,short_name, type from department where id=${id}"
      }).then((value) {
        dep = DataDepartment.fromJson(value[0]);
        _tecBranch.text = dep.branch;
        _tecDepartment.text = dep.department;
        _tecPatasxanatu.text = dep.patasxanatu;
        _tecShortName.text = dep.short_name;
        _tecType.text = dep.type;
      });
    }
  }

  @override
  void save(BuildContext context, String table, object) {
    dep = dep.copyWith(
        branch: _tecBranch.text,
        department: _tecDepartment.text,
        patasxanatu: _tecPatasxanatu.text,
        short_name: _tecShortName.text,
        type: _tecType.text);
    super.save(context, table, dep);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
              padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
              child:
                  Text(L.tr('Branch'), style: const TextStyle(fontSize: 18))),
          Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: SizedBox(
                  width: 300,
                  child: TextFormField(
                    onTap: () {
                      valueOfList(context, branchList, _tecBranch);
                    },
                    readOnly: true,
                    controller: _tecBranch,
                  ))),
          Padding(
              padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
              child: Text(L.tr('Department'),
                  style: const TextStyle(fontSize: 18))),
          Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: SizedBox(
                  width: 300,
                  child: TextFormField(
                    controller: _tecDepartment,
                  ))),
          Padding(
              padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
              child: Text(L.tr('Responsible'),
                  style: const TextStyle(fontSize: 18))),
          Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: SizedBox(
                  width: 300,
                  child: TextFormField(
                    controller: _tecPatasxanatu,
                  ))),
          Padding(
              padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
              child: Text(L.tr('Short name'),
                  style: const TextStyle(fontSize: 18))),
          Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: SizedBox(
                  width: 300,
                  child: TextFormField(
                    controller: _tecShortName,
                  ))),
          Padding(
              padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
              child: Text(L.tr('Type'), style: const TextStyle(fontSize: 18))),
          Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: SizedBox(
                  width: 300,
                  child: TextFormField(
                    onTap: () {
                      valueOfList(context, typeList, _tecType);
                    },
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
