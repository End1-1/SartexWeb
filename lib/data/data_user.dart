import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sartex/data/sartex_datagridsource.dart';
import 'package:sartex/data/sql.dart';
import 'package:sartex/screen/popup_values_screen.dart';
import 'package:sartex/utils/http_sql.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../utils/translator.dart';
import '../widgets/edit_widget.dart';

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
  late List<String> branchList;
  late List<String> activeList;
  late List<String> positionList;
  late List<String> departmentList;
  late List<String> typeList;
  late List<String> roleList;
  UserDataSource({required super.context, required List data}) {
    addRows(data);
    addColumn('edit');
    addColumn( 'Id');
    addColumn( 'Branch');
    addColumn( 'First name');
    addColumn( 'Last name');
    addColumn( 'Middle name');
    addColumn('Email');
    addColumn('Position');
    addColumn( 'Department');
    addColumn('Active');
    addColumn( 'Tabel id');
    addColumn( 'Type');
    branchList = ['Sartex', 'Itex'];
    activeList = ['yes', 'no'];
    HttpSqlQuery.listOfQuery('select distinct(position) from Users order by 1').then((value) => positionList = value);
    HttpSqlQuery.listOf('department', 'department').then((value) => departmentList = value);
    HttpSqlQuery.listOfQuery('select distinct(type) from Users where type is not null').then((value) => typeList = value);
    HttpSqlQuery.listDistinctOf('Users', 'role').then((value) {
      roleList = value;
    });
  }

  @override
  void addRows(List<dynamic> d) {
    data.addAll(d);
    rows.addAll(d.map<DataGridRow>((e) => DataGridRow(cells: [
          DataGridCell(columnName: 'editdata', value: e.id),
          DataGridCell(columnName: 'id', value: e.id),
          DataGridCell(columnName: 'branch', value: e.branch),
          DataGridCell(columnName: 'firstName', value: e.firstName),
          DataGridCell(columnName: 'lastName', value: e.lastName),
          DataGridCell(columnName: 'middleName', value: e.middleName),
          DataGridCell(columnName: 'email', value: e.email),
          DataGridCell(columnName: 'position', value: e.position),
          DataGridCell(columnName: 'department', value: e.department),
          DataGridCell(columnName: 'active', value: e.active),
          DataGridCell(columnName: 'tabelid', value: e.tabelNumber),
          DataGridCell(columnName: 'type', value: e.type),
        ])));
  }

  @override
  Widget getEditWidget(String id) {
    if (id.isEmpty) {
      return UserEditWidget(user: const DataUser(id: '', branch: '', active: '', email: '', firstName: '', lastName: '',middleName: '', position: '', department: '', user_id: '', tabelNumber: '', type: '', role: ''), source: this,);
    } else {
      return UserEditWidget(user: data
          .where((e) => e.id == id)
          .first, source: this,);
    }
  }
}

class UserEditWidget extends EditWidget {
  late DataUser user;
  late UserDataSource source;
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

  UserEditWidget({required this.user, required this.source, super.key}) {
    _tecBranch.text = user.branch;
    _tecFirstName.text = user.firstName;
    _tecLastName.text = user.lastName;
    _tecMiddleName.text = user.middleName;
    _tecEmail.text = user.email;
    _tecPosition.text = user.position;
    _tecDepartment.text = user.department;
    _tecActive.text = user.active;
    _tecRole.text = user.role ?? '';
    _tecType.text = user.type ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(children: [
        textFieldColumn(context: context, title: 'First name' , textEditingController: _tecFirstName),
        textFieldColumn(context: context, title: 'Last name', textEditingController: _tecLastName),
          textFieldColumn(context: context, title: 'Middle name', textEditingController: _tecMiddleName),
        ]),
        Row(children: [
          textFieldColumn(context: context, title: 'Tabel NN', textEditingController: _tecTabelNN),
          textFieldColumn(context: context, title: 'Email', textEditingController: _tecEmail),
          textFieldColumn(context: context, title: 'Position', textEditingController: _tecPosition, list: source.positionList),
        ]),
        Row(
          children: [
            textFieldColumn(context: context, title: 'Department', textEditingController: _tecDepartment, list: source.departmentList),
            textFieldColumn(context: context, title: 'Type', textEditingController: _tecType, list: source.typeList),
            textFieldColumn(context: context, title: 'Password', textEditingController: _tecPassword)
          ],
        ),
        Row(
          children: [
            textFieldColumn(context: context, title: 'Role', textEditingController: _tecRole, list: source.roleList),
            textFieldColumn(context: context, title: 'Active', textEditingController: _tecActive, list: source.activeList),
            textFieldColumn(context: context, title: 'Branch', textEditingController: _tecBranch, list: source.branchList),
          ],
        ),
        saveWidget(context, user)
      ],
    );
  }

  @override
  void save(context, String table, object) {
    user = user.copyWith(
      firstName: _tecFirstName.text,
      lastName: _tecLastName.text,
      middleName: _tecMiddleName.text,
      email: _tecEmail.text,
      active: _tecActive.text,
      department: _tecDepartment.text,
      position: _tecPosition.text,
      tabelNumber: _tecTabelNN.text
    );
    String sql;
    if (user.id.isEmpty) {
      Map<String,dynamic> json = user.toJson();
      json.remove('id');
      sql = Sql.insert('Users', json);
    } else {
      String updatePassword = _tecPosition.text.isNotEmpty
          ? ",password='${_tecPassword.text}'"
          : "";
      sql =
          "update Users set branch='${user.branch}', active='${user
          .active}', department='${user.department}',"
          "firstName='${user.firstName}', lastName='${user
          .lastName}', middleName='${user.middleName}', "
          "email='${user.email}', position='${user
          .position}' $updatePassword where id='${user.id}'";
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
