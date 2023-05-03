import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sartex/screen/app/app_model.dart';
import 'package:sartex/screen/patver_data/patver_data_model.dart';
import 'package:sartex/utils/consts.dart';
import 'package:sartex/utils/text_editing_controller.dart';
import 'package:sartex/utils/translator.dart';
import 'package:intl/intl.dart';

class PatverDataFilter extends StatelessWidget {
  final d1Controller = TextEditingController();
  final d2Controller = TextEditingController();
  final statusController = StreamController();
  final PatverDataModel model;

  PatverDataFilter(this.model, {super.key}) {
    d1Controller.text = DateFormat('dd/MM/yyyy').format(model.d1);
    d2Controller.text = DateFormat('dd/MM/yyyy').format(model.d2);
  }

  final date1Controller = STextEditingController();
  final date2Controller = STextEditingController();

  static Future<bool?> filter(BuildContext context, AppModel model) {
    return showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            contentPadding: const EdgeInsets.all(10),
            children: [PatverDataFilter(model as PatverDataModel)],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      TextFormField(
        decoration: InputDecoration(label: Text(L.tr('Start date'))),
        controller: d1Controller,
        readOnly: true,
        onTap: () {
          dateDialog(context, d1Controller, firstDay: false);
        },
      ),
      const SizedBox(height: 20),
      TextFormField(
        decoration: InputDecoration(label: Text(L.tr('Start date'))),
        controller: d2Controller,
        readOnly: true,
        onTap: () {
          dateDialog(context, d2Controller, firstDay: false);
        },
      ),
      const SizedBox(height: 20),
      StreamBuilder(
          stream: statusController.stream,
          builder: (context, snapshot) {
            return Column(
              children: [
                CheckboxListTile(
                  title: Text(model.statuses[0]),
                  value: model.statusValues[0],
                  onChanged: (v) {
                    v = v ?? false;
                    model.statusValues[0] = v;
                    statusController.add(null);
                  },
                ),
                CheckboxListTile(
                  title: Text(model.statuses[1]),
                  value: model.statusValues[1],
                  onChanged: (v) {
                    v = v ?? false;
                    model.statusValues[1] = v;
                    statusController.add(null);
                  },
                )
              ],
            );
          }),
      const SizedBox(height: 40),
      Row(
        children: [
          OutlinedButton(
              style: outlined_button_style,
              onPressed: () {
                model.d1 = DateFormat("dd/MM/yyyy").parse(d1Controller.text);
                model.d2 = DateFormat("dd/MM/yyyy").parse(d2Controller.text);
                Navigator.pop(context, true);
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
      )
    ]);
  }
}
