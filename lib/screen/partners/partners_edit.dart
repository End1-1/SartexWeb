import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:sartex/data/sql.dart';
import 'package:sartex/utils/consts.dart';
import 'package:sartex/utils/http_sql.dart';
import 'package:sartex/utils/prefs.dart';
import 'package:sartex/utils/translator.dart';
import 'package:sartex/widgets/edit_widget.dart';
import 'package:sartex/widgets/form_field.dart';

class PartnersEdit extends EditWidget {
  final String id;
  final _editId = TextEditingController();
  final _editBranch = TextEditingController()
    ..text = prefs.getString(key_user_branch)!;
  final _editCountry = TextEditingController();
  final _editName = TextEditingController();
  final _editType = TextEditingController();
  final stream = StreamController();

  PartnersEdit(this.id) {
    if (id.isNotEmpty) {
      HttpSqlQuery.post({'sl': "select * from Parthners where id=$id"})
          .then((value) {
        _editId.text = value[0]['id'];
        _editBranch.text = value[0]['branch'];
        _editCountry.text = value[0]['country'];
        _editName.text = value[0]['name'];
        _editType.text = value[0]['type'];
        stream.add(null);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: stream.stream,
        builder: (context, snapshot) {
          return Column(
            children: [
              Row(children: [
                textFieldColumn(
                    context: context,
                    title: 'ID',
                    enabled: false,
                    textEditingController: _editId),
                textFieldColumn(
                    context: context,
                    title: 'Branch',
                    enabled: prefs.roleSuperAdmin(),
                    list: ['Sartex', 'Itex'],
                    textEditingController: _editBranch)
              ]),
              Row(children: [
                textFieldColumn(
                    context: context,
                    title: 'Country',
                    textEditingController: _editCountry),
                textFieldColumn(
                    context: context,
                    title: 'Name',
                    textEditingController: _editName)
              ]),
              Row(children: [
                textFieldColumn(
                    context: context,
                    title: 'Type',
                    textEditingController: _editType)
              ]),
              saveWidget(context, id)
            ],
          );
        });
  }

  @override
  String getTable() {
    return "Parthners  ";
  }

  @override
  void save(BuildContext context, String table, object) {
    String err = '';
    if (_editCountry.text.isEmpty) {
      err += L.tr("Select country") + "\r\n";
    }
    if (_editName.text.isEmpty) {
      err += L.tr('Name is empty') + '\r\n';
    }
    if (_editType.text.isEmpty) {
      err += L.tr('Select type') + '\r\n';
    }
    if (err.isNotEmpty) {
      appDialog(context, err);
      return;
    }
    Map<String, String> json = {};
    json['id'] = id;
    json['branch'] = _editBranch.text;
    json['country'] = _editCountry.text;
    json['name'] = _editName.text;
    json['type'] = _editType.text;
    String sql = '';
    if (id.isEmpty) {
      json.remove('id');
      sql = Sql.insert(table, json);
    } else {
      sql = Sql.update(table, json);
    }
    HttpSqlQuery.post({'sl': sql}).then((value) {
      Navigator.pop(context , '');
    });
  }
}
