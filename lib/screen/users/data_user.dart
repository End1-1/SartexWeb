import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sartex/data/sartex_datagridsource.dart';
import 'package:sartex/data/sql.dart';
import 'package:sartex/utils/http_sql.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../utils/translator.dart';
import '../../widgets/edit_widget.dart';

part 'data_user.freezed.dart';
part 'data_user.g.dart';

@freezed
class DataUser with _$DataUser {
  const factory DataUser(
      {required String id,
      required String branch,
      required String active,
      required String department,
      required String email,
      required String firstName,
      required String lastName,
      required String middleName,
      required String position,
      required String? role,
      required String? tabelNumber,
      required String? user_id,
      required String? type}) = _DataUser;

  factory DataUser.fromJson(Map<String, Object?> json) =>
      _$DataUserFromJson(json);
}

@freezed
class DataUserList with _$DataUserList {
  const factory DataUserList({required List<DataUser> users}) = _DataUserList;

  factory DataUserList.fromJson(Map<String, Object?> json) =>
      _$DataUserListFromJson(json);
}

class UserDataSource extends SartexDataGridSource {
  UserDataSource() {
    UserEditWidget.init();
    addColumn(L.tr('Id'));
    addColumn(L.tr('Branch'));
    addColumn(L.tr('First name'));
    addColumn(L.tr('Last name'));
    addColumn(L.tr('Middle name'));
    addColumn(L.tr('Email'));
    addColumn(L.tr('Position'));
    addColumn(L.tr('Department'));
    addColumn(L.tr('Active'));
    addColumn(L.tr('Tabel id'));
    addColumn(L.tr('Type'));
  }

  @override
  void addRows(List<dynamic> d) {
    DataUserList u = DataUserList.fromJson({'users': d});
    rows.addAll(u.users.map<DataGridRow>((e) {
      int i = 0;
      return DataGridRow(cells: [
        DataGridCell(columnName: columnNames[i++], value: e.id),
        DataGridCell(columnName: columnNames[i++], value: e.branch),
        DataGridCell(columnName: columnNames[i++], value: e.firstName),
        DataGridCell(columnName: columnNames[i++], value: e.lastName),
        DataGridCell(columnName: columnNames[i++], value: e.middleName),
        DataGridCell(columnName: columnNames[i++], value: e.email),
        DataGridCell(columnName: columnNames[i++], value: e.position),
        DataGridCell(columnName: columnNames[i++], value: e.department),
        DataGridCell(columnName: columnNames[i++], value: e.active),
        DataGridCell(columnName: columnNames[i++], value: e.tabelNumber),
        DataGridCell(columnName: columnNames[i++], value: e.type),
      ]);
    }));
  }

  @override
  Widget getEditWidget(BuildContext context, String id) {
    return UserEditWidget(id: id);
  }
}

class UserEditWidget extends EditWidget {
  static late List<String> branchList;
  static late List<String> activeList;
  static late List<String> positionList;
  static late List<String> departmentList;
  static late List<String> typeList;
  static late List<String> roleList;

  var user = const DataUser(
      id: '',
      branch: '',
      active: '',
      department: '',
      email: '',
      firstName: '',
      lastName: '',
      middleName: '',
      position: '',
      role: '',
      tabelNumber: '',
      user_id: '',
      type: '');

  final TextEditingController _tecFirstName = TextEditingController();
  final TextEditingController _tecLastName = TextEditingController();
  final TextEditingController _tecMiddleName = TextEditingController();
  final TextEditingController _tecEmail = TextEditingController();
  final TextEditingController _tecPassword = TextEditingController();
  final TextEditingController _tecPosition = TextEditingController();
  final TextEditingController _tecDepartment = TextEditingController();
  final TextEditingController _tecActive = TextEditingController();
  final TextEditingController _tecBranch = TextEditingController();
  final TextEditingController _tecTabelNN = TextEditingController();
  final TextEditingController _tecRole = TextEditingController();
  final TextEditingController _tecType = TextEditingController();

  static Future<void> init() async {
    branchList = ['Sartex', 'Itex'];
    activeList = ['yes', 'no'];
    var value = await HttpSqlQuery.listOfQuery(
        'select distinct(position) from Users order by 1');
    positionList = value;
    value = await HttpSqlQuery.listOf('department', 'department');
    departmentList = value;
    value = await HttpSqlQuery.listOfQuery(
        'select distinct(type) from Users where type is not null');
    typeList = value;
    value = await HttpSqlQuery.listDistinctOf('RoleNames', 'name');
    roleList = value;
  }

  UserEditWidget({required String id, super.key}) {
    if (id.isNotEmpty) {
      HttpSqlQuery.post({'sl': "select * from Users where id=${id}"})
          .then((value) {
        user = DataUser.fromJson(value[0]);
        _tecBranch.text = user.branch;
        _tecFirstName.text = user.firstName;
        _tecLastName.text = user!.lastName;
        _tecMiddleName.text = user!.middleName;
        _tecEmail.text = user.email;
        _tecPosition.text = user.position;
        _tecDepartment.text = user.department;
        _tecActive.text = user.active;
        _tecRole.text = user.role ?? '';
        _tecType.text = user.type ?? '';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(children: [
          textFieldColumn(
              context: context,
              title: 'First name',
              textEditingController: _tecFirstName),
          textFieldColumn(
              context: context,
              title: 'Last name',
              textEditingController: _tecLastName),
          textFieldColumn(
              context: context,
              title: 'Middle name',
              textEditingController: _tecMiddleName),
        ]),
        Row(children: [
          textFieldColumn(
              context: context,
              title: 'Tabel NN',
              textEditingController: _tecTabelNN),
          textFieldColumn(
              context: context,
              title: 'Email',
              textEditingController: _tecEmail),
          textFieldColumn(
              context: context,
              title: 'Position',
              textEditingController: _tecPosition,
              list: positionList),
        ]),
        Row(
          children: [
            textFieldColumn(
                context: context,
                title: 'Department',
                textEditingController: _tecDepartment,
                list: departmentList),
            textFieldColumn(
                context: context,
                title: 'Type',
                textEditingController: _tecType,
                list: typeList),
            textFieldColumn(
                context: context,
                title: 'Password',
                textEditingController: _tecPassword)
          ],
        ),
        Row(
          children: [
            textFieldColumn(
                context: context,
                title: 'Role',
                textEditingController: _tecRole,
                list: roleList),
            textFieldColumn(
                context: context,
                title: 'Active',
                textEditingController: _tecActive,
                list: activeList),
            textFieldColumn(
                context: context,
                title: 'Branch',
                textEditingController: _tecBranch,
                list: branchList),
          ],
        ),
        saveWidget(context, user)
      ],
    );
  }

  @override
  void save(context, String table, object) {
    user = user.copyWith(
        branch: _tecBranch.text,
        firstName: _tecFirstName.text,
        lastName: _tecLastName.text,
        middleName: _tecMiddleName.text,
        email: _tecEmail.text,
        active: _tecActive.text,
        department: _tecDepartment.text,
        position: _tecPosition.text,
        role: _tecRole.text,
        tabelNumber: _tecTabelNN.text);
    String sql;
    if (user.id.isEmpty) {
      Map<String, dynamic> json = user.toJson();
      json.remove('id');
      sql = Sql.insert('Users', json);
    } else {
      String updatePassword = _tecPassword.text.isNotEmpty
          ? ",password='${_tecPassword.text}'"
          : "";
      sql =
          "update Users set branch='${user.branch}', active='${user.active}', department='${user.department}',"
          "firstName='${user.firstName}', lastName='${user.lastName}', middleName='${user.middleName}', "
          "role='${user.role}', "
          "email='${user.email}', position='${user.position}' $updatePassword where id='${user.id}'";
    }
    HttpSqlQuery.get(sql).then((value) {
      Navigator.pop(context, user);
    });
  }

  @override
  String getTable() {
    return 'Users';
  }
}
