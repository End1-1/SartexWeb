import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:sartex/screen/app/app_screen.dart';
import 'package:sartex/utils/consts.dart';
import 'package:sartex/utils/translator.dart';

import 'model.dart';

class ReturningScreen extends App {

  ReturningScreen() : super(title: L.tr('Returning'), model: ReturnModel());

  @override
  Widget body(BuildContext context) {
    final m = (model as ReturnModel);
    return SingleChildScrollView(child:
      Column(
        children: [
          for (final e in PLines['Itex']!)...[
          Row(children: [
            Text(e),
            const SizedBox(width: 10,),
            SizedBox(width: 100, child: TextFormField(
              decoration: text_form_field_decoration,
              controller: m.tc[e],
            ))
          ],)
    ],
    Row(children: [
      OutlinedButton(
          style: outlined_button_style,
          onPressed: () {
            m.saveReturning();
          },
          child: Text(L.tr('Save')))
    ],)
        ],
      ),);
  }

}