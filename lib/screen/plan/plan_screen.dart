import 'package:flutter/material.dart';
import 'package:sartex/screen/plan/plan_model.dart';
import 'package:sartex/utils/consts.dart';
import 'package:sartex/utils/translator.dart';
import 'package:sartex/widgets/svg_button.dart';

class PlanScreen extends StatelessWidget {
  final model = PlanModel();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 750,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            header(context),
            week(context),
            tableHeader(context),
            Expanded(child: lines(context))
          ],
        ));
  }

  Widget header(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child:
                Align(alignment: Alignment.center, child: Text(L.tr('Week'))))
      ],
    );
  }

  Widget week(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Container()),
        SvgButton(
          onTap: () {
            model.date = model.date.add(const Duration(days: -7));
            model.dateRangeController.add(null);
            model.tableHeaderController.add(null);
          },
          assetPath: 'svg/left.svg',
          darkMode: false,
        ),
        StreamBuilder(
            stream: model.dateRangeController.stream,
            builder: (context, snapshot) {
              return Text(model.weekRange());
            }),
        SvgButton(
          onTap: () {
            model.date = model.date.add(const Duration(days: 7));
            model.dateRangeController.add(null);
            model.tableHeaderController.add(null);
          },
          assetPath: 'svg/right.svg',
          darkMode: false,
        ),
        Expanded(child: Container()),
      ],
    );
  }

  Widget tableHeader(BuildContext context) {
    const decor = BoxDecoration(
        color: Color(0xffcbcbcb),
        border: Border.fromBorderSide(BorderSide(color: Color(0xffb2ebff))));
    const ts = TextStyle(fontSize: 14);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            decoration: decor,
            height: 60,
            width: 50,
            child: Text(L.tr('Ln.'), style: ts)),
        Container(
            decoration: decor,
            height: 60,
            width: 50,
            child: Text(L.tr('Prod. remain'),
                textAlign: TextAlign.center, style: ts)),
        Column(children: [
          StreamBuilder(
              stream: model.tableHeaderController.stream,
              builder: (context, snapshort) {
                return Row(children: [
                  Container(
                      decoration: decor,
                      height: 30,
                      width: 200,
                      child: Align(
                          alignment: Alignment.center,
                          child: Text(L.tr('Plan'), style: ts))),
                  Container(
                      decoration: decor,
                      height: 30,
                      width: 50,
                      child: Text(model.dayOfRange(1), style: ts)),
                  Container(
                      decoration: decor,
                      height: 30,
                      width: 50,
                      child: Text(model.dayOfRange(2), style: ts)),
                  Container(
                      decoration: decor,
                      height: 30,
                      width: 50,
                      child: Text(model.dayOfRange(3), style: ts)),
                  Container(
                      decoration: decor,
                      height: 30,
                      width: 50,
                      child: Text(model.dayOfRange(4), style: ts)),
                  Container(
                      decoration: decor,
                      height: 30,
                      width: 50,
                      child: Text(model.dayOfRange(5), style: ts)),
                  Container(
                      decoration: decor,
                      height: 30,
                      width: 50,
                      child: Text(model.dayOfRange(6), style: ts)),
                  Container(
                      decoration: decor,
                      height: 30,
                      width: 50,
                      child: Text(model.dayOfRange(7), style: ts)),
                ]);
              }),
          Row(children: [
            Container(
                decoration: decor,
                height: 30,
                width: 100,
                child: Text(L.tr('Brand'), style: ts)),
            Container(
                decoration: decor,
                height: 30,
                width: 100,
                child: Text(L.tr('Model'), style: ts)),
            Container(
                decoration: decor,
                height: 30,
                width: 50,
                child: Text(L.tr('Mo'), style: ts)),
            Container(
                decoration: decor,
                height: 30,
                width: 50,
                child: Text(L.tr('To'), style: ts)),
            Container(
                decoration: decor,
                height: 30,
                width: 50,
                child: Text(L.tr('We'), style: ts)),
            Container(
                decoration: decor,
                height: 30,
                width: 50,
                child: Text(L.tr('Th'), style: ts)),
            Container(
                decoration: decor,
                height: 30,
                width: 50,
                child: Text(L.tr('Fr'), style: ts)),
            Container(
                decoration: decor,
                height: 30,
                width: 50,
                child: Text(L.tr('Sa'), style: ts)),
            Container(
                decoration: decor,
                height: 30,
                width: 50,
                child: Text(L.tr('Su'), style: ts)),
          ]),
        ]),
        Container(
            decoration: decor,
            height: 60,
            width: 50,
            child: Text(L.tr('Tot.'), style: ts)),
        Container(
            decoration: decor,
            height: 60,
            width: 50,
            child: Text(L.tr('Edit'), style: ts)),
      ],
    );
  }

  Widget lines(BuildContext context) {
    const decor = BoxDecoration(
        color: Color(0xffcbcbcb),
        border: Border.fromBorderSide(BorderSide(color: Color(0xffb2ebff))));
    const ts = TextStyle(fontSize: 14);
    const inputDecor = InputDecoration(contentPadding: EdgeInsets.all(0));
    return SingleChildScrollView(
        child: StreamBuilder(
            stream: model.tableDataController.stream,
            builder: (context, snapshot) {
              return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (int i = 0; i < model.lines.length; i++) ...[
                      Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                decoration: decor,
                                height: 30 *
                                    (model.linesData[model.lines[i]]!.isEmpty
                                            ? 1.0
                                            : model.linesData[model.lines[i]]!
                                                .length)
                                        .toDouble(),
                                width: 50,
                                child: Text(model.lines[i], style: ts)),
                            Container(
                              decoration: decor,
                              width: 650,
                              height: 30 *
                                  (model.linesData[model.lines[i]]!.isEmpty
                                          ? 1.0
                                          : model.linesData[model.lines[i]]!
                                              .length)
                                      .toDouble(),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  for (var e
                                      in model.linesData[model.lines[i]]!) ...[
                                        Row(crossAxisAlignment: CrossAxisAlignment.start, children:[ Container(height: 30, width: 50, decoration: decor,),
                                    Container(
                                        decoration: decor,
                                        width: 100,
                                        height: 30,
                                        child: TextFormField(
                                          decoration: inputDecor,
                                          style: ts,
                                          controller: e.editBrand,
                                          onTap: () {
                                            valueOfList(
                                                context,
                                                model.brandModel.keys.toList(),
                                                e.editBrand);
                                          },
                                        )),
                                    Container(
                                        decoration: decor,
                                        width: 100,
                                        height: 30,
                                        child: TextFormField(
                                          decoration: inputDecor,
                                          style: ts,
                                          controller: e.editModel,
                                          onTap: () {
                                            valueOfList(
                                                context,
                                                model.brandModel[
                                                        e.editBrand.text] ??
                                                    [],
                                                e.editModel);
                                          },
                                        )),
                                  ])]
                                ],
                              ),
                            ),
                            Container(
                                decoration: decor,
                                width: 50,
                                height: 30 *
                                    (model.linesData[model.lines[i]]!.isEmpty
                                            ? 1.0
                                            : model.linesData[model.lines[i]]!
                                                .length)
                                        .toDouble(),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SvgButton(
                                        onTap: () {
                                          model.linesData[model.lines[i]]!
                                              .add(PlanRowEdit());
                                          model.tableDataController.add(null);
                                        },
                                        assetPath: 'svg/plus.svg',
                                        darkMode: false)
                                  ],
                                ))
                          ])
                    ]
                  ]);
            }));
  }
}
