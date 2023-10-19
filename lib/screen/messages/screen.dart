import 'package:flutter/material.dart';
import 'package:sartex/screen/app/app_screen.dart';
import 'package:sartex/utils/consts.dart';
import 'package:sartex/utils/translator.dart';

import 'model.dart';

class MessagesScreen extends App {
  MessagesScreen() : super(title: L.tr('Notice'), model: MessagesModel());

  @override
  Widget body(BuildContext context) {
    final m = (model as MessagesModel);
    return StreamBuilder<String?>(
        stream: m.str.stream,
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            m.getNotice();
          }
          return SingleChildScrollView(child: Column(children: [
            Row(
              children: [
                Expanded(
                    child: Text(L.tr('Notice'),
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 18)))
              ],
            ),
            const SizedBox(width: 10,),
            const Row(children: [Text("#1")],),
            const SizedBox(width: 10,),
            Row(
              children: [
                Expanded(
                    child: TextFormField(
                  controller: m.txt1,
                  maxLines: 20,
                  minLines: 20,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black26))),
                ))
              ],
            ),
            const SizedBox(width: 10,),
            const Row(children: [Text("#2")],),
            const SizedBox(width: 10,),
            Row(
              children: [
                Expanded(
                    child: TextFormField(
                      controller: m.txt2,
                      maxLines: 20,
                      minLines: 20,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black26))),
                    ))
              ],
            ),
            const SizedBox(width: 10,),
            Row(children: [
              Text(L.tr('Font size'), style: const TextStyle(fontSize: 16),),
              const SizedBox(width: 10),
              SizedBox(width: 100, child: TextFormField(
                decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black26))),
                controller: m.fontSizeController,
                keyboardType: TextInputType.number,
              ))
            ],),
            const SizedBox(height: 10,),
            Row(
              children: [
                Expanded(child: Container()),
                OutlinedButton(
                    style: outlined_button_style,
                    onPressed: () {
                      m.enableNotice();
                    },
                    child: Text(m.enabled ? L.tr('Disable') : L.tr('Enable'))),
                const SizedBox(width: 10,),
                OutlinedButton(
                    style: outlined_button_style,
                    onPressed: () {
                      m.saveNotice();
                    },
                    child: Text(L.tr('Save'))),
                Expanded(child: Container()),
              ],
            )
          ]));
        });
  }
}
