import 'package:flutter/material.dart';
import 'package:sartex/screen/production_history/production_history_model.dart';
import 'package:sartex/screen/store_docs/store_docs_datasource.dart';
import 'package:sartex/screen/store_docs/store_docs_model.dart';
import 'package:sartex/utils/consts.dart';
import 'package:sartex/utils/prefs.dart';
import 'package:sartex/utils/text_editing_controller.dart';
import 'package:sartex/utils/translator.dart';
import 'package:sartex/utils/utils_class.dart';
import 'package:sartex/widgets/form_field.dart';

class ProductionHistoryFilter extends StatelessWidget {
  final ProductionHistoryModel model;
  final editDate1 = STextEditingController();
  final editDate2 = STextEditingController();
  final editBrand = STextEditingController();
  final editModel = STextEditingController();
  final editLine = STextEditingController();
  String docType = '';

  ProductionHistoryFilter(this.model);

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
                  ..text = Utils.mysqlDateToHuman(ProductionHistoryModel.date1)),
            textFieldColumn(
                onTap: () {
                  dateDialog(context, editDate2, firstDay: false);
                },
                context: context,
                title: 'Date end',
                textEditingController: editDate2
                  ..text = Utils.mysqlDateToHuman(ProductionHistoryModel.date2)),
          ],
        ),
        Row(
          children: [
            textFieldColumn(
                context: context,
                title: 'Brand',
                list: ProductionHistoryModel.brandList,
                textEditingController: editBrand..text = ProductionHistoryModel.brand),
            textFieldColumn(
                context: context,
                title: 'Model',
                onTap: () {
                  if (editBrand.text.isEmpty) {
                    return;
                  }
                  valueOfList(context, ProductionHistoryModel.modelList[editBrand.text]!, editModel);
                },
                textEditingController: editModel),
          ],
        ),
        Row(
          children: [
            textFieldColumn(
               list: PLines[prefs.branch()]!..insert(0, ''),
                context: context,
                title: 'Line',
                textEditingController: editLine..text = ProductionHistoryModel.line),
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
                  ProductionHistoryModel.date1 = Utils.humanToMysqlDate(editDate1.text);
                  ProductionHistoryModel.date2 = Utils.humanToMysqlDate(editDate2.text);
                  ProductionHistoryModel.brand = editBrand.text;
                  ProductionHistoryModel.line = editLine.text;
                  ProductionHistoryModel.Model = editModel.text;
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
