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
      required String position}) = _DataUser;

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
  UserDataSource({required super.context, required List data}) {
    addRows(data);
    addColumn('edit', 'Edit', 100);
    addColumn('id', 'Id', 40);
    addColumn('branch', 'Branch', 100);
    addColumn('active', 'Active', 100);
    addColumn('firstname', 'First name', 200);
    addColumn('lastname', 'Last name', 200);
    addColumn('middlename', 'Middle name', 200);
    addColumn('email', 'Email', 200);
    addColumn('position', 'Position', 200);
    addColumn('department', 'Department', 200);
    branchList = ['Sartex', 'Itex'];
    activeList = ['yes', 'no'];
    HttpSqlQuery.listOfQuery('select distinct(position) from Users order by 1').then((value) => positionList = value);
    HttpSqlQuery.listOf('department', 'department').then((value) => departmentList = value);
  }

  @override
  void addRows(List<dynamic> d) {
    data.addAll(d);
    rows.addAll(d.map<DataGridRow>((e) => DataGridRow(cells: [
          DataGridCell(columnName: 'editdata', value: e.id),
          DataGridCell(columnName: 'id', value: e.id),
          DataGridCell(columnName: 'branch', value: e.branch),
          DataGridCell(columnName: 'active', value: e.active),
          DataGridCell(columnName: 'firstName', value: e.firstName),
          DataGridCell(columnName: 'lastName', value: e.lastName),
          DataGridCell(columnName: 'middleName', value: e.middleName),
          DataGridCell(columnName: 'email', value: e.email),
          DataGridCell(columnName: 'position', value: e.position),
          DataGridCell(columnName: 'department', value: e.department)
        ])));
  }

  @override
  Widget getEditWidget(String id) {
    if (id.isEmpty) {
      return UserEditWidget(user: const DataUser(id: '', branch: '', active: '', email: '', firstName: '', lastName: '',middleName: '', position: '', department: '',), source: this,);
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

  UserEditWidget({required this.user, required this.source, super.key}) {
    _tecBranch.text = user.branch;
    _tecFirstName.text = user.firstName;
    _tecLastName.text = user.lastName;
    _tecMiddleName.text = user.middleName;
    _tecEmail.text = user.email;
    _tecPosition.text = user.position;
    _tecDepartment.text = user.department;
    _tecActive.text = user.active;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
              children: [
            Padding(
                padding: const EdgeInsets.only(top:10, left: 10, right: 10),
                child: Text(L.tr('First name'),
                    style: const TextStyle(fontSize: 18))),
            Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: SizedBox(width: 200, child: TextFormField(
                  controller: _tecFirstName,
                ))),
          ]),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                  padding: const EdgeInsets.only(top:10, left: 10, right: 10),
                  child: Text(L.tr('Last name'),
                      style: const TextStyle(fontSize: 18))),
              Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: SizedBox(width: 200, child: TextFormField(
                    controller: _tecLastName,
                  ))),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                  padding: const EdgeInsets.only(top:10, left: 10, right: 10),
                  child: Text(L.tr('Middle name'),
                      style: const TextStyle(fontSize: 18))),
              Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: SizedBox(width: 200, child: TextFormField(
                    controller: _tecMiddleName,
                  ))),
            ],
          )
        ]),
        Row(children: [
          Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
            Padding(
              padding: const EdgeInsets.only(top:10, left: 10, right: 10),
              child: Text(L.tr('Email'), style: const TextStyle(fontSize: 18))),
            Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: SizedBox(width: 300, child: TextFormField(
                  controller: _tecEmail,
                ))),
          ]),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            Padding(
                padding: const EdgeInsets.only(top:10, left: 10, right: 10),
                child: Text(L.tr('Position'), style: const TextStyle(fontSize: 18))),
            Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: SizedBox(width: 300, child: TextFormField(
                  onTap: () {
                    showDialog(context: context, builder: (BuildContext context) {
                      return PopupValuesScreen(values: source.positionList);
                    }).then((value) {if (value != null) {_tecPosition.text = value;}} );
                  },
                  readOnly: true,
                  controller: _tecPosition,
                )))
          ],)
        ]),
        Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                    padding: const EdgeInsets.only(top:10, left: 10, right: 10),
                    child: Text(L.tr('Department'), style: const TextStyle(fontSize: 18))),
                Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: SizedBox(width: 300, child: TextFormField(
                      onTap: () {
                        showDialog(context: context, builder: (BuildContext context) {
                          return PopupValuesScreen(values: source.departmentList);
                        }).then((value) { if (value != null) {_tecDepartment.text = value;}});
                      },
                      readOnly: true,
                      controller: _tecDepartment,
                    )))
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                    padding: const EdgeInsets.only(top:10, left: 10, right: 10),
                    child:
                    Text(L.tr('Password'), style: const TextStyle(fontSize: 18))),
                Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: SizedBox(width: 300, child: TextFormField(
                      controller: _tecPassword,
                    ))),
              ],
            )
          ],
        ),
        Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                    padding: const EdgeInsets.only(top:10, left: 10, right: 10),
                    child:
                    Text(L.tr('Active'), style: const TextStyle(fontSize: 18))),
                Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: SizedBox(width: 300, child: TextFormField(
                      onTap: () {
                        showDialog(context: context, builder: (BuildContext context) {
                          return PopupValuesScreen(values: source.activeList);
                        }).then((value) {if (value != null) { _tecActive.text = value;}});
                      },
                      readOnly: true,
                      controller: _tecActive,
                    ))),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                    padding: const EdgeInsets.only(top:10, left: 10, right: 10),
                    child:
                    Text(L.tr('Branch'), style: const TextStyle(fontSize: 18))),
                Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: SizedBox(width: 300, child: TextFormField(
                      onTap: () {
                        showDialog(context: context, builder: (BuildContext context) {
                          return PopupValuesScreen(values: source.branchList);
                        }).then((value) {if (value != null){ _tecBranch.text = value;}});
                      },
                      readOnly: true,
                      controller: _tecBranch,
                    ))),
              ],
            )
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
