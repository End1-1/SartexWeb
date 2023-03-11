import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sartex/data/sartex_datagridsource.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../utils/consts.dart';
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
  UserDataSource({required super.context, required List<DataUser> userData}) {
    addRows(userData);
    addColumn('edit', 'Edit', 100);
    addColumn('id', 'Id', 40);
    addColumn('branch', 'Branch', 100);
    addColumn('active', 'Active', 100);
    addColumn('firstname', 'First name', 200);
    addColumn('lastname', 'Last name', 200);
    addColumn('middlename', 'Middle name', 200);
    addColumn('email', 'Email', 200);
    addColumn('position', 'Position', 200);
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
          DataGridCell(columnName: 'position', value: e.position)
        ])));
  }

  @override
  Widget getEditWidget(String id) {
    return UserEditWidget(user: data.where((e) => e.id == id).first);
  }
}

class UserEditWidget extends EditWidget {
  late DataUser user;
  final TextEditingController _tecFirstName = TextEditingController();
  final TextEditingController _tecLastName = TextEditingController();
  final TextEditingController _tecMiddleName = TextEditingController();
  final TextEditingController _tecEmail = TextEditingController();
  final TextEditingController _tecPassword = TextEditingController();

  UserEditWidget({required this.user, super.key}) {
    _tecFirstName.text = user.firstName;
    _tecLastName.text = user.lastName;
    _tecMiddleName.text = user.middleName;
    _tecEmail.text = user.email;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
            padding: const EdgeInsets.all(10),
            child:
                Text(L.tr('First name'), style: const TextStyle(fontSize: 18))),
        Padding(
            padding: const EdgeInsets.all(10),
            child: TextFormField(
              controller: _tecFirstName,
            )),
        Padding(
            padding: const EdgeInsets.all(10),
            child:
                Text(L.tr('Last name'), style: const TextStyle(fontSize: 18))),
        Padding(
            padding: const EdgeInsets.all(10),
            child: TextFormField(
              controller: _tecLastName,
            )),
        Padding(
            padding: const EdgeInsets.all(10),
            child: Text(L.tr('Middle name'),
                style: const TextStyle(fontSize: 18))),
        Padding(
            padding: const EdgeInsets.all(10),
            child: TextFormField(
              controller: _tecMiddleName,
            )),
        Padding(
            padding: const EdgeInsets.all(10),
            child: Text(L.tr('Email'), style: const TextStyle(fontSize: 18))),
        Padding(
            padding: const EdgeInsets.all(10),
            child: TextFormField(
              controller: _tecEmail,
            )),
        Padding(
            padding: const EdgeInsets.all(10),
            child:
                Text(L.tr('Password'), style: const TextStyle(fontSize: 18))),
        Padding(
            padding: const EdgeInsets.all(10),
            child: TextFormField(
              controller: _tecPassword,
            )),
    Padding(padding: const EdgeInsets.all(10), child: Row(
      children: [
        TextButton(onPressed: (){save(context, user);}, child: Text(L.tr('Save'), style: const TextStyle())),
        TextButton(onPressed: (){Navigator.pop(context);}, child: Text(L.tr('Cancel'), style: const TextStyle())),
      ],
    ))
    ],
    );
  }

  @override
  void save(context, object) {
    user = user.copyWith(firstName: _tecFirstName.text);
    Navigator.pop(context);
  }
}
