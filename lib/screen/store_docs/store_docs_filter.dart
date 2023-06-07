import 'package:flutter/material.dart';
import 'package:sartex/screen/store_docs/store_docs_datasource.dart';
import 'package:sartex/screen/store_docs/store_docs_model.dart';
import 'package:sartex/utils/consts.dart';
import 'package:sartex/utils/text_editing_controller.dart';
import 'package:sartex/utils/translator.dart';
import 'package:sartex/utils/utils_class.dart';
import 'package:sartex/widgets/form_field.dart';

class StoreDocsFilter extends StatelessWidget {
  final StoreDocsModel model;
  final editDate1 = STextEditingController();
  final editDate2 = STextEditingController();
  final editDocType = STextEditingController();
  final editStore = STextEditingController();
  String docType = '';

  StoreDocsFilter(this.model);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            textFieldColumn(
              onTap: () {
                dateDialog(context, editDate1, firstDay: false);
              },
                context: context,
                title: 'Date start',
                textEditingController: editDate1
                  ..text = Utils.mysqlDateToHuman(StoreDocsModel.date1)),
            textFieldColumn(
                onTap: () {
                  dateDialog(context, editDate2, firstDay: false);
                },
                context: context,
                title: 'Date end',
                textEditingController: editDate2
                  ..text = Utils.mysqlDateToHuman(StoreDocsModel.date2)),
          ],
        ),
        Row(
          children: [
            textFieldColumn(
                onTap: (){
                  valueOfList(context, storeDocsTypes.values.toList(), editDocType, done: (){
                    docType = Utils.mapKeyOfValue(storeDocsTypes, editDocType.text);
                  });
                },
                context: context,
                title: 'Type',
                textEditingController: editDocType..text = storeDocsTypes[StoreDocsModel.type] ?? ''),
            textFieldColumn(
                context: context,
                title: 'Store',
                list: ['P1', 'P2', 'P3', 'P4'],
                textEditingController: editStore),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            const SizedBox(width: 10),
            OutlinedButton(
                style: outlined_button_style,
                onPressed: () {
                  StoreDocsModel.date1 = Utils.humanToMysqlDate(editDate1.text);
                  StoreDocsModel.date2 = Utils.humanToMysqlDate(editDate2.text);
                  StoreDocsModel.pahest = editStore.text;
                  StoreDocsModel.type = docType;
                  Navigator.pop(context, true);
                },
                child: Text(L.tr('Apply'), style: const TextStyle())),
            const SizedBox(width: 10),
            OutlinedButton(
                style: outlined_button_style,
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(L.tr('Cancel'), style: const TextStyle())),
          ],
        )
      ],
    );
  }
}
