import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sartex/screen/plan/plan_bloc.dart';
import 'package:sartex/screen/plan/plan_model.dart';
import 'package:sartex/screen/plan_and_production/pp_bloc.dart';
import 'package:sartex/utils/consts.dart';
import 'package:sartex/utils/translator.dart';
import 'package:sartex/widgets/svg_button.dart';

class PlanScreen extends StatelessWidget {
  var model = PlanModel();

  PlanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
            border:
                Border.fromBorderSide(BorderSide(color: Color(0xffaabbff)))),
        margin: const EdgeInsets.fromLTRB(0, 0, 10, 10),
        height: MediaQuery.of(context).size.height * 0.51,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            header(context),
            week(context),
            tableHeader(context),
             BlocListener<PlanBloc, PlanState>(
                listener: (previouse, current) {
                  if (current is PlanSRefresh) {
                    if (current.planModel == null) {
                      BlocProvider.of<PlanBloc>(context).add(PlanERefresh(model));
                    } else {
                      model = current.planModel!;
                    }
                  }
                },
                    child:
                    BlocBuilder<PlanBloc, PlanState>(builder: (context, state) {
                  return Expanded(child: lines(context));
                }))
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
            model.loadQty();
            BlocProvider.of<PPBloc>(context).add(PAPlanData());
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
            model.loadQty();
            BlocProvider.of<PPBloc>(context).add(PAPlanData());
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
        color: Color(0xffababab),
        border: Border.fromBorderSide(BorderSide(color: Color(0xffcbcbcb))));
    const ts = TextStyle(fontSize: 14);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
            child: Container(
                decoration: decor,
                child: Row(children: [
                  Container(
                      height: 60 * scale_factor,
                      width: 50,
                      child: Align(
                          alignment: Alignment.center,
                          child: Text(L.tr('Ln.'), style: ts))),
                  Container(
                      decoration: decor,
                      height: 60 * scale_factor,
                      width: 50,
                      child: Align(
                          alignment: Alignment.center,
                          child: Text(L.tr('Prod. remain'), style: ts))),
                  Column(children: [
                    StreamBuilder(
                        stream: model.tableHeaderController.stream,
                        builder: (context, snapshort) {
                          return Row(children: [
                            Container(
                                decoration: decor,
                                height: 30 * scale_factor,
                                width: 200,
                                child: Align(
                                    alignment: Alignment.center,
                                    child: Text(L.tr('Plan'), style: ts))),
                            Container(
                                decoration: decor,
                                height: 30 * scale_factor,
                                width: 100,
                                child: Align(
                                    alignment: Alignment.center,
                                    child:
                                        Text(model.dayOfRange(1), style: ts))),
                            Container(
                                decoration: decor,
                                height: 30 * scale_factor,
                                width: 100,
                                child: Align(
                                    alignment: Alignment.center,
                                    child:
                                        Text(model.dayOfRange(2), style: ts))),
                            Container(
                                decoration: decor,
                                height: 30 * scale_factor,
                                width: 100,
                                child: Align(
                                    alignment: Alignment.center,
                                    child:
                                        Text(model.dayOfRange(3), style: ts))),
                            Container(
                                decoration: decor,
                                height: 30 * scale_factor,
                                width: 100,
                                child: Align(
                                    alignment: Alignment.center,
                                    child:
                                        Text(model.dayOfRange(4), style: ts))),
                            Container(
                                decoration: decor,
                                height: 30 * scale_factor,
                                width: 100,
                                child: Align(
                                    alignment: Alignment.center,
                                    child:
                                        Text(model.dayOfRange(5), style: ts))),
                            Container(
                                decoration: decor,
                                height: 30 * scale_factor,
                                width: 100,
                                child: Align(
                                    alignment: Alignment.center,
                                    child:
                                        Text(model.dayOfRange(6), style: ts))),
                            Container(
                                decoration: decor,
                                height: 30 * scale_factor,
                                width: 100,
                                child: Align(
                                    alignment: Alignment.center,
                                    child:
                                        Text(model.dayOfRange(7), style: ts))),
                          ]);
                        }),
                    Row(children: [
                      Container(
                          decoration: decor,
                          height: 30 * scale_factor,
                          width: 100,
                          child: Align(
                              alignment: Alignment.center,
                              child: Text(L.tr('Brand'), style: ts))),
                      Container(
                          decoration: decor,
                          height: 30 * scale_factor,
                          width: 100,
                          child: Align(
                              alignment: Alignment.center,
                              child: Text(L.tr('Model'), style: ts))),
                      Container(
                          decoration: decor,
                          height: 30 * scale_factor,
                          width: 100,
                          child: Align(
                              alignment: Alignment.center,
                              child: Text(L.tr('Mo'), style: ts))),
                      Container(
                          decoration: decor,
                          height: 30 * scale_factor,
                          width: 100,
                          child: Align(
                              alignment: Alignment.center,
                              child: Text(L.tr('To'), style: ts))),
                      Container(
                          decoration: decor,
                          height: 30 * scale_factor,
                          width: 100,
                          child: Align(
                              alignment: Alignment.center,
                              child: Text(L.tr('We'), style: ts))),
                      Container(
                          decoration: decor,
                          height: 30 * scale_factor,
                          width: 100,
                          child: Align(
                              alignment: Alignment.center,
                              child: Text(L.tr('Th'), style: ts))),
                      Container(
                          decoration: decor,
                          height: 30 * scale_factor,
                          width: 100,
                          child: Align(
                              alignment: Alignment.center,
                              child: Text(L.tr('Fr'), style: ts))),
                      Container(
                          decoration: decor,
                          height: 30 * scale_factor,
                          width: 100,
                          child: Align(
                              alignment: Alignment.center,
                              child: Text(L.tr('Sa'), style: ts))),
                      Container(
                          decoration: decor,
                          height: 30 * scale_factor,
                          width: 100,
                          child: Align(
                              alignment: Alignment.center,
                              child: Text(L.tr('Su'), style: ts))),
                    ]),
                  ]),
                  Container(
                      decoration: decor,
                      height: 60 * scale_factor,
                      width: 100,
                      child: Align(
                          alignment: Alignment.center,
                          child: Text(L.tr('Tot.'), style: ts))),
                  Container(
                      decoration: decor,
                      height: 60 * scale_factor,
                      width: 100,
                      child: Align(
                          alignment: Alignment.center,
                          child: Text(L.tr('Comesa'), style: ts))),
                  Container(
                      decoration: decor,
                      height: 60 * scale_factor,
                      width: 50,
                      child: Align(
                          alignment: Alignment.center,
                          child: Text(L.tr('Edit'), style: ts))),
                  Expanded(child: Container()),
                ]))),
      ],
    );
  }

  Widget lines(BuildContext context) {
    double rowHeight = 45 * scale_factor;
    const decor1 = BoxDecoration(
        color: Color(0xffffffff),
        border: Border.fromBorderSide(BorderSide(color: Color(0xffcbcbcb))));
    const decor2 = BoxDecoration(
        color: Colors.yellowAccent,
        border: Border.fromBorderSide(BorderSide(color: Color(0xffcbcbcb))));
    const ts = TextStyle(fontSize: 14);
    const inputDecor1 = InputDecoration(

        contentPadding: EdgeInsets.fromLTRB(5, 0, 5, 0), border: InputBorder.none);
    const inputDecor2 = InputDecoration(
        contentPadding: EdgeInsets.all(4), border: InputBorder.none);
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
                            //LINE
                            Container(
                              alignment: Alignment.center,
                                decoration: decor1,
                                padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                                height: rowHeight *
                                    (model.linesData[model.lines[i]]!.isEmpty
                                            ? 1.0
                                            : model.linesData[model.lines[i]]!
                                                .length)
                                        .toDouble(),
                                width: 50,
                                child: InkWell(
                                    onTap: () {
                                      BlocProvider.of<PPBloc>(context).add(
                                          PALine(
                                              line: model.lines[i],
                                              open: true));
                                    },
                                    child: Text(model.lines[i], style: ts, textAlign: TextAlign.center))),
                            //REMAIN
                            Expanded(
                                child: Container(
                                  alignment: Alignment.center,
                              //decoration: decor1,
                              height: rowHeight *
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
                                    Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                              width: 50,
                                              height: rowHeight,
                                              decoration: decor1,
                                              child: TextFormField(
                                                readOnly: true,
                                                decoration: inputDecor1,
                                                style: ts,
                                                controller: e.editRemain,
                                              )),
                                          Container(
                                              decoration: decor1,
                                              width: 100,
                                              height: rowHeight,
                                              child: TextFormField(
                                                readOnly: true,
                                                decoration: inputDecor1,
                                                style: ts,
                                                controller: e.editBrand,
                                              )),
                                          Container(
                                              decoration: decor1,
                                              width: 100,
                                              height: rowHeight,
                                              child: TextFormField(
                                                readOnly: true,
                                                decoration: inputDecor1,
                                                style: ts,
                                                controller: e.editModel,
                                              )),
                                          //DAYS
                                          for (int d = 0; d < 7; d++) ...[
                                            BlocBuilder<PPBloc, PPState>(
                                                builder: (context, state) {
                                              return Container(
                                                alignment: Alignment.center,
                                                  decoration: e.editMode
                                                      ? decor2
                                                      : decor1,
                                                  width: 100,
                                                  height: rowHeight,
                                                  child: TextFormField(
                                                    readOnly: !e.editMode,
                                                    textAlign: TextAlign.center,
                                                    decoration: inputDecor1,
                                                    style: ts,
                                                    controller: e.days[d],
                                                  ));
                                            }),
                                          ],
                                          Container(
                                              decoration: decor1,
                                              width: 100,
                                              height: rowHeight,
                                              child: TextFormField(
                                                readOnly: true,
                                                decoration: inputDecor1,
                                                style: ts,
                                                controller: e.editTot,
                                              )),
                                              BlocBuilder<PPBloc, PPState>(
    builder: (context, state) {
    return Container(
                                              decoration: e.editMode
                                                  ? decor2
                                                  : decor1,
                                              width: 120,
                                              height: rowHeight,
                                              child: TextFormField(
                                                readOnly: !e.editMode,
                                                decoration: inputDecor1,
                                                style: ts,
                                                controller: e.editComesa,
                                              ));}
                                              ),
                                          BlocBuilder<PPBloc, PPState>(
                                              builder: (context, state) {
                                            return Container(
                                                decoration: decor1,
                                                width: 50,
                                                height: rowHeight,
                                                child: SvgButton(
                                                  onTap: () async {
                                                    if (e.editMode) {
                                                      await model.savePlan(e);
                                                    }
                                                    e.editMode = !e.editMode;
                                                    BlocProvider.of<PPBloc>(
                                                            context)
                                                        .add(PAEditRow());
                                                  },
                                                  assetPath: e.editMode
                                                      ? 'svg/save.svg'
                                                      : 'svg/edit.svg',
                                                  darkMode: false,
                                                ));
                                          }),
                                        ])
                                  ]
                                ],
                              ),
                            )),


                          ])
                    ]
                  ]);
            }));
  }
}
