import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sartex/screen/preloading/preloading_bloc.dart';
import 'package:sartex/screen/preloading/preloading_item.dart';
import 'package:sartex/screen/preloading/preloading_model.dart';
import 'package:sartex/screen/preloading/preloading_widgets.dart';
import 'package:sartex/utils/consts.dart';
import 'package:sartex/utils/prefs.dart';
import 'package:sartex/utils/translator.dart';
import 'package:sartex/widgets/edit_widget.dart';
import 'package:sartex/widgets/svg_button.dart';

class PreloadingScreen extends EditWidget {
  final PreloadingModel _model = PreloadingModel();
  String? docNum;

  PreloadingScreen({super.key, this.docNum});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PreloadingBloc>(
        create: (_) => PreloadingBloc(PreloadingStateIdle())
          ..add(PreloadingEventOpenDoc(docnum: docNum)),
        child: BlocBuilder<PreloadingBloc, PreloadingState>(
            builder: (context, state) {
          if (state is PreloadingStateOpenDoc) {
            if (state.items.isNotEmpty) {
              _model.editDate.text = DateFormat('dd/MM/yyyy').format(
                  DateFormat('yyyy-MM-dd').parse(state.header['date']!));
              _model.editReceipant.text = state.header['receipant']!;
              _model.editStore.text = state.header['store']!;
              _model.editTruck.text = state.header['truck']!;
              _model.prReadyLines.addAll(state.items);
            }
          }
          return Column(
            children: [
              //Header
              Row(children: [
                Expanded(
                    child: Text(L.tr('Preloading'),
                        textAlign: TextAlign.center, style: tsDialogHeader))
              ]),
              Row(children: [
                textFieldColumn(
                    context: context,
                    title: 'Date',
                    textEditingController: _model.editDate,
                    onTap: () {
                      dateDialog(context, _model.editDate);
                    }),
                textFieldColumn(
                    context: context,
                    title: 'Track',
                    textEditingController: _model.editTruck),
                textFieldColumn(
                    context: context,
                    title: 'Store',
                    textEditingController: _model.editStore,
                    list: _model.storeNames),
                textFieldColumn(
                    context: context,
                    title: 'Receipant',
                    textEditingController: _model.editReceipant),
                Expanded(child: Container()),
                SvgButton(
                    darkMode: false,
                    onTap: () {
                      appDialogYesNo(context, L.tr('Close document?'), () {
                        Navigator.pop(context);
                      }, () {});
                    },
                    assetPath: 'svg/cancel.svg'),
                if (prefs.roleWrite('2'))
                  SvgButton(
                      darkMode: false,
                      onTap: () {
                        appDialogYesNo(context, L.tr('Save document?'), () {
                          _model.save().then((value) {
                            if (value.isNotEmpty) {
                              appDialog(context, value);
                              return;
                            }
                            Navigator.pop(context, _model.docNumber);
                          });
                        }, () {});
                      },
                      assetPath: 'svg/save.svg')
              ]),
              const Divider(height: 20, color: Colors.transparent),
              //MainWindow
              DefaultTabController(
                  length: 2,
                  initialIndex: (docNum ?? '').length == 0 ? 0 : 1,
                  child: SizedBox(
                      height: 800,
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: Scaffold(
                        appBar: TabBar(
                          labelColor: Colors.black,
                          unselectedLabelColor: Colors.black45,
                          tabs: [
                            Text(L.tr('New preloading')),
                            Text(L.tr('Preloading list'))
                          ],
                        ),
                        body: TabBarView(
                          children: [
                            prefs.roleWrite("2")
                                ? Container(
                                    alignment: Alignment.topLeft,
                                    padding: const EdgeInsets.fromLTRB(
                                        10, 20, 10, 10),
                                    child: PreloadingLine(
                                        model: _model, line1: true))
                                : Container(),
                            Container(
                                alignment: Alignment.topLeft,
                                padding:
                                    const EdgeInsets.fromLTRB(10, 20, 10, 10),
                                child: PreloadingLines(
                                    model: _model, line1: false)),
                          ],
                        ),
                      ))),
            ],
          );
        }));
  }

  @override
  String getTable() {
    return '';
  }
}

class PreloadingLine extends StatefulWidget {
  final PreloadingModel model;
  final bool line1;

  PreloadingLine({required this.model, required this.line1});

  @override
  State<StatefulWidget> createState() => _PreloadingLine();
}

class _PreloadingLine extends State<PreloadingLine> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            decoration: const BoxDecoration(color: Colors.blueAccent),
            child: Row(children: [
              const SizedBox(width: 10),
              Text(
                L.tr('Select line'),
                style: const TextStyle(color: Colors.white),
              ),
              const SizedBox(width: 10),
              Expanded(child: LineDropdownButton(model: widget.model)),
              SvgButton(
                  onTap: () {
                    setState(() {
                      widget.model.prLine.items.add(PreloadingItem());
                    });
                  },
                  assetPath: 'svg/plus.svg'),
              SvgButton(
                  onTap: () {
                    appDialogYesNo(context, L.tr('Is data ready?'), () {
                      String err = '';
                      if (widget.model.prLine.prLine.isEmpty) {
                        err += L.tr('Select line');
                      }
                      for (var e in widget.model.prLine.items) {
                        if ((int.tryParse(
                                    e.newvalues[e.newvalues.length - 1].text) ??
                                0) ==
                            0) {
                          err += L.tr('Invalid total quantity of loading');
                        }
                      }
                      if (err.isNotEmpty) {
                        appDialog(context, err);
                        return;
                      }
                      widget.model.prReadyLines.add(widget.model.prLine);
                      widget.model.prLine = PreloadingFullItem();
                      setState(() {});
                    }, () {});
                  },
                  assetPath: 'svg/save.svg')
            ])),
        Expanded(
            child: PreloadingItemsContainer(
          item: widget.model.prLine,
          model: widget.model,
          showLine1: widget.line1,
          parentState: () {
            setState(() {});
          },
        ))
      ],
    );
  }
}

class PreloadingLines extends StatefulWidget {
  final PreloadingModel model;
  final bool line1;

  PreloadingLines({super.key, required this.model, required this.line1});

  @override
  State<StatefulWidget> createState() => _PreloadingLines();
}

class _PreloadingLines extends State<PreloadingLines> {
  final TextStyle tsLine = const TextStyle(
      color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Divider(height: 20, color: Colors.transparent),
        for (var e in widget.model.prReadyLines) ...[
          Row(
            children: [
              Expanded(
                  child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      decoration: const BoxDecoration(color: Colors.blueAccent),
                      child: Text(e.prLine, style: tsLine))),
              const Divider(height: 20, color: Colors.transparent),
            ],
          ),
          PreloadingItemsContainer(
            item: e,
            showLine1: widget.line1,
            model: widget.model,
            parentState: () {
              setState(() {});
            },
          ),
          const Divider(height: 20, color: Colors.transparent),
        ]
      ],
    ));
  }
}
