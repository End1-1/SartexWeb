import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sartex/screen/users_role/user_role_bloc.dart';
import 'package:sartex/utils/consts.dart';
import 'package:sartex/utils/http_sql.dart';
import 'package:sartex/utils/text_editing_controller.dart';
import 'package:sartex/utils/translator.dart';
import 'package:sartex/widgets/edit_widget.dart';

part 'users_role_edit.freezed.dart';

part 'users_role_edit.g.dart';

@freezed
class RoleData with _$RoleData {
  const factory RoleData({required String action,
    required String read_flag,
    required String write_flag}) = _RoleData;

  factory RoleData.fromJson(Map<String, dynamic> json) =>
      _$RoleDataFromJson(json);
}

class UsersRoleEditWidget extends EditWidget {
  late String id;

  UsersRoleEditWidget(this.id, {super.key});

  final nameController = STextEditingController();
  final Map<String, RoleData> rolesData = {
    "1": const RoleData(action: "1", read_flag: "0", write_flag: "0"),
    "2": const RoleData(action: "2", read_flag: "0", write_flag: "0"),
    "3": const RoleData(action: "3", read_flag: "0", write_flag: "0"),
    "4": const RoleData(action: "4", read_flag: "0", write_flag: "0"),
    "5": const RoleData(action: "5", read_flag: "0", write_flag: "0"),
    "6": const RoleData(action: "6", read_flag: "0", write_flag: "0"),
    "7": const RoleData(action: "7", read_flag: "0", write_flag: "0"),
    "8": const RoleData(action: "8", read_flag: "0", write_flag: "0"),
    "9": const RoleData(action: "9", read_flag: "0", write_flag: "0"),
    "10": const RoleData(action: "10", read_flag: "0", write_flag: "0"),
    "11": const RoleData(action: "11", read_flag: "0", write_flag: "0"),
  };

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UserRoleBloc>(
        create: (_) =>
        UserRoleBloc()
          ..add(UserRoleGetEvent(id.isEmpty ? '0' : id)),
        child:
        BlocBuilder<UserRoleBloc, UserRoleState>(builder: (context, state) {
          if (state is UserRoleLoading) {
            return const SizedBox(
                height: 36, width: 36, child: CircularProgressIndicator());
          }
          if (state is UserRoleData) {
            print(rolesData);
            print(state.check);
            state.check.forEach((key, value) {
              rolesData[key] =
                  rolesData[key]!.copyWith(read_flag: value['read_flag']!);
              rolesData[key] =
                  rolesData[key]!.copyWith(write_flag: value['write_flag']!);
            });
            nameController.text = state.name;
          }

          return Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            width: 400,
            height: 500,
            child: SingleChildScrollView(child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(
                      label: Text(L.tr('Name')),
                      border: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black12))),
                  controller: nameController,
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    SizedBox(
                        width: 300,
                        child: Align(
                            alignment: Alignment.center,
                            child: Text(L.tr('Action')))),
                    SizedBox(
                        width: 100,
                        child: Align(
                            alignment: Alignment.center,
                            child: Text(L.tr('Read')))),
                    SizedBox(
                        width: 100,
                        child: Align(
                            alignment: Alignment.center,
                            child: Text(L.tr('Write')))),
                  ],
                ),
                const SizedBox(width: 20),
                _Checkbox(rolesData, L.tr('Super admin'), "9"),
                const SizedBox(height: 10),
                _Checkbox(rolesData, L.tr('Orders'), "1"),
                const SizedBox(height: 10),
                _Checkbox(rolesData, L.tr('Loading'), "2"),
                const SizedBox(height: 10),
                _Checkbox(rolesData, L.tr('Production'), "3"),
                const SizedBox(height: 10),
                _Checkbox(rolesData, L.tr('TV'), "4"),
                const SizedBox(height: 10),
                _Checkbox(rolesData, L.tr('Permissions'), "5"),
                const SizedBox(width: 20),
                _Checkbox(rolesData, L.tr('Users'), "6"),
                const SizedBox(width: 20),
                _Checkbox(rolesData, L.tr('Other directories'), "7"),
                const SizedBox(width: 20),
                _Checkbox(rolesData, L.tr('Translator'), "8"),
                const SizedBox(width: 20),
                _Checkbox(rolesData, L.tr('Execute production'), "10"),
                const SizedBox(width: 20),
                _Checkbox(rolesData, L.tr('TV only'), "11"),
                const SizedBox(width: 20),
                Row(children: [
                  Expanded(child: Container()),
                  OutlinedButton(
                      style: outlined_button_style,
                      onPressed: () async {
                        save(context, '', null);
                        Navigator.pop(context);
                      },
                      child:
                      Text(L.tr('Save'), style: const TextStyle())),
                const SizedBox(width: 10),
                OutlinedButton(
                    style: outlined_button_style,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child:
                    Text(L.tr('Cancel'), style: const TextStyle())),
                Expanded(child: Container())])
              ],
            )
          ));
        }));
  }

  @override
  String getTable() {
    return "RoleNames";
  }

  @override
  save(BuildContext context, String table, dynamic o) async {
    if (id.isEmpty) {
      var result = await HttpSqlQuery.post(
          {'sl': "select coalesce(max(id), 0)+1 as id from RoleNames "});
      id = result[0]['id'];
      await HttpSqlQuery.post({
        'sl':
        "insert into RoleNames (id, name) values ($id, '${nameController
            .text}')"
      });
    }
    await HttpSqlQuery.post({'sl': "delete from RoleData where role_id=$id"});
    rolesData.forEach((key, value) async {
      await HttpSqlQuery.post({
        'sl':
        "insert into RoleData (role_id, action, read_flag, write_flag) values ($id, ${value
            .action}, ${value.read_flag}, ${value.write_flag})"
      });
    });
  }
}

class _Checkbox extends StatefulWidget {
  Map<String, RoleData> rolesData;
  String title;
  String index;

  _Checkbox(this.rolesData, this.title, this.index);

  @override
  State<StatefulWidget> createState() => _CheckboxState();
}

class _CheckboxState extends State<_Checkbox> {
  @override
  Widget build(BuildContext context) {
    return Row(children: [
      SizedBox(width: 300, child: Text(widget.title)),
      SizedBox(
          width: 50,
          child: Checkbox(
              value: widget.rolesData[widget.index]!.read_flag == "1",
              onChanged: (bool? value) {
                value ??= false;
                widget.rolesData[widget.index] = widget.rolesData[widget.index]!
                    .copyWith(read_flag: value ? "1" : "0");
                setState(() {});
              })),
      SizedBox(
          width: 50,
          child: Checkbox(
              value: widget.rolesData[widget.index]!.write_flag == "1",
              onChanged: (bool? value) {
                value ??= false;
                widget.rolesData[widget.index] = widget.rolesData[widget.index]!
                    .copyWith(write_flag: value ? "1" : "0");
                setState(() {});
              }))
    ]);
  }
}
