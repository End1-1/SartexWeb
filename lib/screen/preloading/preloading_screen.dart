import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sartex/screen/preloading/preloading_bloc.dart';
import 'package:sartex/screen/preloading/preloading_functions.dart';
import 'package:sartex/screen/preloading/preloading_item.dart';
import 'package:sartex/screen/preloading/preloading_model.dart';
import 'package:sartex/screen/preloading/preloading_widgets.dart';
import 'package:sartex/screen/preloading_summary/preloading_summary_screen.dart';
import 'package:sartex/utils/consts.dart';
import 'package:sartex/utils/prefs.dart';
import 'package:sartex/utils/translator.dart';
import 'package:sartex/widgets/edit_widget.dart';
import 'package:sartex/widgets/form_field.dart';
import 'package:sartex/widgets/svg_button.dart';
import 'dart:html' as html;

class PreloadingScreen extends EditWidget {
  final PreloadingModel model = PreloadingModel();
  late final PreloadingFunction functions;
  int? loaded;
  var saving = false;

  PreloadingScreen({super.key, required String docNum, this.loaded}) {
    model.docNumber = docNum;
    functions = PreloadingFunction(widget: this);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PreloadingBloc>(
        create: (_) => PreloadingBloc(PreloadingStateIdle())
          ..add(PreloadingEventOpenDoc(docnum: model.docNumber)),
        child: BlocBuilder<PreloadingBloc, PreloadingState>(
            builder: (context, state) {
              if (state is PreloadingStateSummary) {
                state.data['doc'] = [{'docnum':model.docNumber}];
                return PreloadingSummmaryScreen(doc: state.data);
              }
          if (state is PreloadingStateOpenDoc) {
            if (state.items.isNotEmpty) {
              model.editDocNum.text = model.docNumber ?? '';
              model.editDate.text = DateFormat('dd/MM/yyyy').format(
                  DateFormat('yyyy-MM-dd').parse(state.header['date']!));
              model.editReceipant.text = state.header['receipant']!;
              model.editStore.text = state.header['store']!;
              model.editTruck.text = state.header['truck']!;
              model.prReadyLines.clear();
              model.prReadyLines.addAll(state.items);
            }
          } else if (state is PreloadingStateIdle || state is PreloadingStateInProgress) {
            return const Center(child: CircularProgressIndicator());
          }
          return Column(
            children: [
              //Header
              Row(children: [
                Expanded(
                    child: Text(
              (loaded == null || loaded == 2) ? L.tr('Preloading') : L.tr('Loaded'),
                        textAlign: TextAlign.center,
                        style: tsDialogHeader))
              ]),
              Row(children: [
                textFieldColumn(
                  context: context,
                  title: 'DocNum',
                  textEditingController: model.editDocNum,
                  enabled: false,
                ),
                textFieldColumn(
                    context: context,
                    title: 'Date',
                    textEditingController: model.editDate,
                    onTap: () {
                      dateDialog(context, model.editDate);
                    }),
                textFieldColumn(
                    context: context,
                    title: 'Track',
                    textEditingController: model.editTruck),
                Expanded(child: Container()),
                SvgButton(
                    darkMode: false,
                    onTap: () {
                      appDialogYesNo(context, L.tr('Close document?'), () {
                        Navigator.pop(context);
                      }, () {});
                    },
                    assetPath: 'svg/cancel.svg'),
                if (prefs.roleWrite('2') && loaded == null)
                  SvgButton(
                      darkMode: false,
                      onTap: () {
                        if (saving) {
                          return;
                        }
                        appDialogYesNo(context, L.tr('Save document?'), () {
                          saving = true;
                          model.save().then((value) {
                            if (value.isNotEmpty) {
                              appDialog(context, value);
                              return;
                            }
                            Navigator.pop(context, model.docNumber);
                          });
                        }, () {});
                      },
                      assetPath: 'svg/save.svg'),
                SvgButton(
                  onTap: () {
                    functions.exportToExcel(context);
                  },
                  assetPath: 'svg/excel.svg',
                  darkMode: false,
                ),
                SvgButton(
                  onTap: () {
                    model.showMnac = !model.showMnac;
                    if (model.docNumber != null) {
                      BlocProvider.of<PreloadingBloc>(context).add(
                          PreloadingEventOpenDoc(docnum: model.docNumber!));
                    }
                  },
                  assetPath: 'svg/eye.svg',
                  darkMode: false,
                ),
                if (loaded == 2)
                  SvgButton(onTap: (){
                    if (model.docNumber != null) {
                      BlocProvider.of<PreloadingBloc>(context).add(
                          PreloadingEventSummary(docnum: model.docNumber!));
                    }
                  }, assetPath: 'svg/sum.svg', darkMode:false,)
              ]),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [textFieldColumn(
                    context: context,
                    title: 'Store',
                    textEditingController: model.editStore,
                    list: model.storeNames),
                textFieldColumn(
                    context: context,
                    title: 'Receipant',
                    textEditingController: model.editReceipant),
              ]),
              const Divider(height: 20, color: Colors.transparent),
              //MainWindow
              DefaultTabController(
                  length: loaded != null
                      ? 1
                      : (model.docNumber ?? '').length == 0 ||
                              prefs.roleWrite("2")
                          ? 2
                          : 1,
                  initialIndex: loaded != null
                      ? 0
                      : (model.docNumber ?? '').length == 0
                          ? 0
                          : 1,
                  child: SizedBox(
                      height: 800,
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: Scaffold(
                        appBar: TabBar(
                          labelColor: Colors.black,
                          unselectedLabelColor: Colors.black45,
                          tabs: [
                            if (prefs.roleWrite("2") && loaded == null)
                              Text(L.tr('New preloading')),
                            Text(L.tr('Preloading list'))
                          ],
                        ),
                        body: TabBarView(
                          children: [
                            if (prefs.roleWrite("2") && loaded == null)
                              Container(
                                  alignment: Alignment.topLeft,
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 20, 10, 10),
                                  child: PreloadingLine(
                                      model: model, line1: true)),
                            Container(
                                alignment: Alignment.topLeft,
                                padding:
                                    const EdgeInsets.fromLTRB(10, 20, 10, 10),
                                child: PreloadingLines(readyOnly: loaded != null,
                                    model: model, line1: false)),
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
                    if (widget.model.editStore.text.isEmpty) {
                      // appDialog(context, L.tr('Select store'));
                      // return;
                    }
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
                      //Check if same apr_id, line exists, then update
                      for (final checkLine in widget.model.prReadyLines) {
                        if (checkLine.prLine == widget.model.prLine.prLine) {
                          for (final currentItem in widget.model.prLine.items) {
                            bool found = false;
                            for (final checkItem in checkLine.items) {
                              if (checkItem.brand.text ==
                                      currentItem.brand.text &&
                                  checkItem.model.text ==
                                      currentItem.model.text &&
                                  checkItem.commesa.text ==
                                      currentItem.commesa.text &&
                                  checkItem.country.text ==
                                      currentItem.country.text &&
                                  checkItem.variant.text ==
                                      currentItem.variant.text &&
                                  checkItem.color.text ==
                                      currentItem.color.text) {
                                for (int i = 0; i < 12; i++) {
                                  checkItem.newvalues[i].text =
                                      ((int.tryParse(currentItem
                                                      .newvalues[i].text) ??
                                                  0) +
                                              (int.tryParse(checkItem
                                                      .newvalues[i].text) ??
                                                  0))
                                          .toString();
                                }
                                widget.model.prLine.items.remove(currentItem);
                                found = true;
                              }
                            }
                            if (!found) {
                              checkLine.items.add(currentItem);
                              widget.model.prLine.items.remove(currentItem);
                            }
                          }
                        }
                      }

                      //not exists, new line
                      if (widget.model.prLine.items.isNotEmpty) {
                        widget.model.prReadyLines.add(widget.model.prLine);
                        widget.model.prLine = PreloadingFullItem();
                      }
                      setState(() {});
                    }, () {});
                  },
                  assetPath: 'svg/save.svg')
            ])),
        Expanded(
            child: PreloadingItemsContainer(
              readOnly: false,
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
  final bool readyOnly;

  PreloadingLines({super.key, required this.model, required this.line1, required this.readyOnly});

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
            readOnly: widget.readyOnly,
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
