import 'package:flutter/material.dart';
import 'package:sartex/screen/production/production_model.dart';
import 'package:sartex/utils/consts.dart';
import 'package:sartex/utils/translator.dart';
import 'package:sartex/widgets/edit_widget.dart';
import 'package:sartex/widgets/svg_button.dart';

class ProductionWidget extends EditWidget {
  final _model = ProductionModel();

  ProductionWidget({super.key, required String? DocN}) {
    _model.DocN = DocN;
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Row(children: [
        Expanded(
            child: Text(L.tr('Production'),
                textAlign: TextAlign.center, style: tsDialogHeader))
      ]),
      headerRow1(context),
      lines(context),
      Row(
        children: [
          Expanded(
              child: Center(
                  child: SvgButton(
            onTap: () {
              _model.lines.add(ProductionLine());
              _model.linesController.add(null);
            },
            assetPath: 'svg/plus.svg',
            darkMode: false,
          )))
        ],
      ),

    ]);
  }

  @override
  String getTable() {
    return 'Production';
  }

  Widget headerRow1(BuildContext context) {
    return Row(children: [
      textFieldColumn(
          context: context,
          title: 'Date',
          textEditingController: _model.editDate,
          onTap: () {
            dateDialog(context, _model.editDate);
          }),
      textFieldColumn(
          context: context,
          title: 'Doc number',
          textEditingController: _model.editDocN,
          enabled: false),
      Expanded(child: Container()),
      SvgButton(
          darkMode: false,
          onTap: () {
            appDialogYesNo(context, L.tr('Close document?'), () {
              Navigator.pop(context);
            }, () {});
          },
          assetPath: 'svg/cancel.svg'),
      SvgButton(
          darkMode: false,
          onTap: () {
            appDialogYesNo(context, L.tr('Save document?'), () {
              _model.save().then((value) {
                if (value.isNotEmpty) {
                  appDialog(context, value);
                  return;
                }
                Navigator.pop(context, _model.DocN);
              });
            }, () {});
          },
          assetPath: 'svg/save.svg')
    ]);
  }

  Widget lines(BuildContext context) {
    return StreamBuilder(
        stream: _model.linesController.stream,
        builder: (context, snapshot) {
          return Column(
            children: [
              for (var e in _model.lines) ...[
                Row(
                  children: [
                    Text(L.tr('Line')),
                    Expanded(child: DropdownLine(productionLine: e))
                  ],
                )
              ]
            ],
          );
        });
  }
}

class DropdownLine extends StatefulWidget {
  ProductionLine productionLine;

  DropdownLine({super.key, required this.productionLine});

  @override
  State<StatefulWidget> createState() => _DropdownLine();
}

class _DropdownLine extends State<DropdownLine> {
  @override
  Widget build(BuildContext context) {
    return DropdownButton(
        underline: const SizedBox(),
        isExpanded: true,
        value: widget.productionLine.name,
        items: Lines.map((e) => DropdownMenuItem(value: e, child: Text(e)))
            .toList(),
        onChanged: (value) {
          widget.productionLine.name = value!;
          setState(() {});
        });
  }
}
