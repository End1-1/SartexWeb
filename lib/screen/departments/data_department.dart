import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sartex/data/sartex_datagridsource.dart';
import 'package:sartex/data/sql.dart';
import 'package:sartex/utils/consts.dart';
import 'package:sartex/utils/http_sql.dart';
import 'package:sartex/utils/prefs.dart';
import 'package:sartex/utils/text_editing_controller.dart';
import 'package:sartex/widgets/form_field.dart';
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
      required String? patasxanatu,
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
  static List<String> branchList = ['Sartex', 'Itex'];
  static List<String> typeList = [];

  final TextEditingController _tecBranch = TextEditingController();
  final TextEditingController _tecDepartment = TextEditingController();
  final TextEditingController _tecPatasxanatu = TextEditingController();
  final TextEditingController _tecShortName = TextEditingController();
  final TextEditingController _tecType = TextEditingController();



  DepartmentEditWidget({super.key, required String id}) {
    HttpSqlQuery.listDistinctOf('department', 'type').then((value) {
      typeList = value;
      if (id.isNotEmpty) {
        HttpSqlQuery.post({
          'sl':
          "select id,branch,department,patasxanatu,short_name, type from department where id=${id}"
        }).then((value) {
          dep = DataDepartment.fromJson(value[0]);
          _tecBranch.text = dep.branch;
          _tecDepartment.text = dep.department;
          _tecPatasxanatu.text = dep.patasxanatu ?? '';
          _tecShortName.text = dep.short_name;
          _tecType.text = dep.type;
        });
      } else {
        if (!prefs.roleSuperAdmin()) {
          _tecBranch.text = prefs.branch();
        }
      }
    });

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
          textFieldColumn(context: context, title: L.tr('Branch'), textEditingController: _tecBranch, onTap: () {
            valueOfList(context, branchList, _tecBranch);
          }, list: branchList, enabled: prefs.roleSuperAdmin()),
          textFieldColumn(context: context, title: L.tr('Department'), textEditingController: _tecDepartment),
          textFieldColumn(context: context, title: L.tr('Responsible'), textEditingController: _tecPatasxanatu),
          textFieldColumn(context: context, title: L.tr('Short name'), textEditingController: _tecShortName),
          textFieldColumn(context: context, title: L.tr('Type'), textEditingController: _tecType,
            list: typeList),
          saveWidget(context, dep)
        ]);
  }

  @override
  String getTable() {
    return 'department';
  }
}
