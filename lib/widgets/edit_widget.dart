import 'package:flutter/material.dart';
import 'package:sartex/screen/popup_values_screen.dart';

import '../data/sql.dart';
import '../utils/consts.dart';
import '../utils/http_sql.dart';
import '../utils/translator.dart';

abstract class EditWidget extends StatelessWidget {
  const EditWidget({super.key});

  @override
  Widget build(BuildContext context);

  String getTable();

  void save(BuildContext context, String table, dynamic object) {
    String sql = '';
    Map<String, dynamic> json = object.toJson();
    if (object.id.isEmpty) {
      json.remove('id');
      sql = Sql.insert(table, json);
    } else {
      sql = Sql.update(table, json);
    }
    HttpSqlQuery.get(sql).then((value) {
      if (value.contains(key_error)) {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return SimpleDialog(children: [
                Container(
                    width: 200,
                    height: 200,
                    alignment: Alignment.center,
                    child: const Text("Unimplemented",
                        style: TextStyle(fontSize: 28))),
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(L.tr('Close')))
              ]);
            });
        return;
      }
      Navigator.pop(context, object);
    });
  }

  Widget saveWidget(BuildContext context, Object o) {
    return Padding(
        padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
        child: Row(
          children: [
            OutlinedButton(
                style: outlined_button_style,
                onPressed: () {
                  save(context, getTable(), o);
                },
                child: Text(L.tr('Save'), style: const TextStyle())),
            const SizedBox(width: 20),
            OutlinedButton(
                style: outlined_button_style,
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(L.tr('Cancel'), style: const TextStyle())),
          ],
        ));
  }

  List<Widget> textField(
      {required BuildContext context,
      required String title,
      required TextEditingController textEditingController,
      required VoidCallback? onTap,
      ValueChanged<String>? onChange,
      List<String>? list,
      int width = 200,
      bool enabled = true}) {
    final List<Widget> l = [];
    l.add(Padding(
        padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
        child: Text(L.tr(title), style: const TextStyle(fontSize: 18))));
    l.add(Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: SizedBox(
            width: 300,
            child: TextFormField(
              decoration: text_form_field_decoration,
              onChanged: onChange,
              enabled: enabled,
              onTap: onTap ??
                  (list == null
                      ? null
                      : () {
                          if (list.isNotEmpty) {
                            valueOfList(context, list, textEditingController);
                          }
                        }),
              readOnly: list != null || onTap != null || !enabled,
              controller: textEditingController,
            ))));
    return l;
  }

  Widget textFieldColumn(
      {required BuildContext context,
      required String title,
      required TextEditingController textEditingController,
      List<String>? list,
      int width = 200,
      bool enabled = true,
      VoidCallback? onTap,
      ValueChanged<String>? onChange}) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: textField(
            context: context,
            title: title,
            textEditingController: textEditingController,
            onTap: onTap,
            enabled: enabled,
            onChange: onChange,
            list: list,
            width: width));
  }
}
