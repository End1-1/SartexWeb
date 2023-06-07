import 'package:flutter/material.dart';
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


}
