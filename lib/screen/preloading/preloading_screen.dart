import 'package:excel/excel.dart';
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
  int? loaded;

  PreloadingScreen({super.key, required String docNum, this.loaded}) {
    _model.docNumber = docNum;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PreloadingBloc>(
        create: (_) => PreloadingBloc(PreloadingStateIdle())
          ..add(PreloadingEventOpenDoc(docnum: _model.docNumber)),
        child: BlocBuilder<PreloadingBloc, PreloadingState>(
            builder: (context, state) {
          if (state is PreloadingStateOpenDoc) {
            if (state.items.isNotEmpty) {
              _model.editDocNum.text = _model.docNumber ?? '';
              _model.editDate.text = DateFormat('dd/MM/yyyy').format(
                  DateFormat('yyyy-MM-dd').parse(state.header['date']!));
              _model.editReceipant.text = state.header['receipant']!;
              _model.editStore.text = state.header['store']!;
              _model.editTruck.text = state.header['truck']!;
              _model.prReadyLines.clear();
              _model.prReadyLines.addAll(state.items);
            }
          } else if (state is PreloadingStateIdle) {
            return Center(child: CircularProgressIndicator());
          }
          return Column(
            children: [
              //Header
              Row(children: [
                Expanded(
                    child: Text(
                        loaded == null ? L.tr('Preloading') : L.tr('Loaded'),
                        textAlign: TextAlign.center,
                        style: tsDialogHeader))
              ]),
              Row(children: [
                textFieldColumn(
                  context: context,
                  title: 'DocNum',
                  textEditingController: _model.editDocNum,
                  enabled: false,
                ),
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
                if (prefs.roleWrite('2') && loaded == null)
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
                      assetPath: 'svg/save.svg'),
                SvgButton(
                  onTap: () {
                    _exportToExcel(context);
                  },
                  assetPath: 'svg/excel.svg',
                  darkMode: false,
                )
              ]),
              const Divider(height: 20, color: Colors.transparent),
              //MainWindow
              DefaultTabController(
                  length: loaded != null
                      ? 1
                      : (_model.docNumber ?? '').length == 0 ||
                              prefs.roleWrite("2")
                          ? 2
                          : 1,
                  initialIndex: loaded != null
                      ? 0
                      : (_model.docNumber ?? '').length == 0
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
                                      model: _model, line1: true)),
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

  _exportToExcel(BuildContext context) {
    var excel = Excel.createExcel();
    Sheet sheetObject = excel['Sheet1'];

    CellStyle cellStyle = CellStyle(
        backgroundColorHex: '#1AFF1A',
        fontFamily: getFontFamily(FontFamily.Calibri));

    CellStyle cellLine = CellStyle(
        horizontalAlign: HorizontalAlign.Center,
        backgroundColorHex: '#${Color(0xff31cafa).value.toRadixString(16)}',
        fontFamily: getFontFamily(FontFamily.Calibri),
        bold: true,
        fontColorHex: "#FFFFFF",
        fontSize: 20);

    CellStyle cellGray = CellStyle(
        horizontalAlign: HorizontalAlign.Center,
        backgroundColorHex: '#${Color(0xffb7b6b6).value.toRadixString(16)}',
        fontFamily: getFontFamily(FontFamily.Calibri),
        bold: true,
        fontColorHex: "#000000",
        fontSize: 14);

    CellStyle cellWhite = CellStyle(
        horizontalAlign: HorizontalAlign.Center,
        backgroundColorHex: '#${Color(0xffffffff).value.toRadixString(16)}',
        fontFamily: getFontFamily(FontFamily.Calibri),
        bold: true,
        fontColorHex: "#000000",
        fontSize: 14);

    CellStyle cellGreen = CellStyle(
        horizontalAlign: HorizontalAlign.Center,
        backgroundColorHex: '#${Color(0xff93ff7b).value.toRadixString(16)}',
        fontFamily: getFontFamily(FontFamily.Calibri),
        bold: true,
        fontColorHex: "#000000",
        fontSize: 14);

    CellStyle cellRed = CellStyle(
        horizontalAlign: HorizontalAlign.Center,
        backgroundColorHex: '#${Color(0xffff8e8e).value.toRadixString(16)}',
        fontFamily: getFontFamily(FontFamily.Calibri),
        bold: true,
        fontColorHex: "#000000",
        fontSize: 14);

    cellStyle.underline = Underline.Single;
    var cell = sheetObject.cell(CellIndex.indexByString('A1'));
    cell.value = L.tr('DocNum'); // dynamic values support provided;
    cell.cellStyle = cellStyle;
    cell = sheetObject.cell(CellIndex.indexByString('A2'));
    cell.value = _model.editDocNum.text;
    cell.cellStyle = cellStyle;

    cell = sheetObject.cell(CellIndex.indexByString('B1'));
    cell.value = L.tr('Date'); // dynamic values support provided;
    cell.cellStyle = cellStyle;
    cell = sheetObject.cell(CellIndex.indexByString('B2'));
    cell.value = _model.editDate.text;
    cell.cellStyle = cellStyle;

    cell = sheetObject.cell(CellIndex.indexByString('C1'));
    cell.value = L.tr('Truck'); // dynamic values support provided;
    cell.cellStyle = cellStyle;
    cell = sheetObject.cell(CellIndex.indexByString('C2'));
    cell.value = _model.editTruck.text;
    cell.cellStyle = cellStyle;

    cell = sheetObject.cell(CellIndex.indexByString('D1'));
    cell.value = L.tr('Store'); // dynamic values support provided;
    cell.cellStyle = cellStyle;
    cell = sheetObject.cell(CellIndex.indexByString('D2'));
    cell.value = _model.editStore.text;
    cell.cellStyle = cellStyle;

    cell = sheetObject.cell(CellIndex.indexByString('E1'));
    cell.value = L.tr('Receipant'); // dynamic values support provided;
    cell.cellStyle = cellStyle;
    cell = sheetObject.cell(CellIndex.indexByString('E2'));
    cell.value = _model.editReceipant.text;
    cell.cellStyle = cellStyle;

    int r = 4;
    for (final l in _model.prReadyLines) {
      cell = sheetObject.cell(CellIndex.indexByString('A$r'));
      cell.cellStyle = cellLine;
      cell.value = l.prLine;
      sheetObject.merge(
          CellIndex.indexByString('A$r'), CellIndex.indexByString('S$r'));
      for (int i = 0; i < 17; i++) {
        sheetObject
            .cell(CellIndex.indexByColumnRow(columnIndex: i, rowIndex: r))
            .cellStyle = cellLine;
      }

      r++;
      for (final m in l.items) {
        //header
        cell = sheetObject.cell(CellIndex.indexByString('A$r'));
        cell.cellStyle = cellGray;
        cell.value = L.tr('Brand');

        cell = sheetObject.cell(CellIndex.indexByString('B$r'));
        cell.cellStyle = cellGray;
        cell.value = L.tr('Model');

        cell = sheetObject.cell(CellIndex.indexByString('C$r'));
        cell.cellStyle = cellGray;
        cell.value = L.tr('Commesa');

        cell = sheetObject.cell(CellIndex.indexByString('D$r'));
        cell.cellStyle = cellGray;
        cell.value = L.tr('Country');

        cell = sheetObject.cell(CellIndex.indexByString('E$r'));
        cell.cellStyle = cellGray;
        cell.value = L.tr('Color');

        cell = sheetObject.cell(CellIndex.indexByString('F$r'));
        cell.cellStyle = cellGray;
        cell.value = L.tr('Variant');

        cell = sheetObject.cell(CellIndex.indexByString('G$r'));
        cell.cellStyle = cellGray;
        cell.value = m.preSize!.size[0];

        cell = sheetObject.cell(CellIndex.indexByString('H$r'));
        cell.cellStyle = cellGray;
        cell.value = m.preSize!.size[1];

        cell = sheetObject.cell(CellIndex.indexByString('I$r'));
        cell.cellStyle = cellGray;
        cell.value = m.preSize!.size[2];

        cell = sheetObject.cell(CellIndex.indexByString('J$r'));
        cell.cellStyle = cellGray;
        cell.value = m.preSize!.size[3];

        cell = sheetObject.cell(CellIndex.indexByString('K$r'));
        cell.cellStyle = cellGray;
        cell.value = m.preSize!.size[4];

        cell = sheetObject.cell(CellIndex.indexByString('L$r'));
        cell.cellStyle = cellGray;
        cell.value = m.preSize!.size[5];

        cell = sheetObject.cell(CellIndex.indexByString('M$r'));
        cell.cellStyle = cellGray;
        cell.value = m.preSize!.size[6];

        cell = sheetObject.cell(CellIndex.indexByString('N$r'));
        cell.cellStyle = cellGray;
        cell.value = m.preSize!.size[7];

        cell = sheetObject.cell(CellIndex.indexByString('O$r'));
        cell.cellStyle = cellGray;
        cell.value = m.preSize!.size[7];

        cell = sheetObject.cell(CellIndex.indexByString('P$r'));
        cell.cellStyle = cellGray;
        cell.value = m.preSize!.size[8];

        cell = sheetObject.cell(CellIndex.indexByString('Q$r'));
        cell.cellStyle = cellGray;
        cell.value = m.preSize!.size[10];

        cell = sheetObject.cell(CellIndex.indexByString('R$r'));
        cell.cellStyle = cellGray;
        cell.value = m.preSize!.size[11];

        cell = sheetObject.cell(CellIndex.indexByString('S$r'));
        cell.cellStyle = cellGray;
        cell.value = L.tr('Total');
        r++;

        //model, brand text
        cell = sheetObject.cell(CellIndex.indexByString('A$r'));
        cell.cellStyle = cellGray;
        cell.value = m.brand.text;

        cell = sheetObject.cell(CellIndex.indexByString('B$r'));
        cell.cellStyle = cellGray;
        cell.value = m.model.text;

        cell = sheetObject.cell(CellIndex.indexByString('C$r'));
        cell.cellStyle = cellGray;
        cell.value = m.commesa.text;

        cell = sheetObject.cell(CellIndex.indexByString('D$r'));
        cell.cellStyle = cellGray;
        cell.value = m.country.text;

        cell = sheetObject.cell(CellIndex.indexByString('E$r'));
        cell.cellStyle = cellGray;
        cell.value = m.color.text;

        cell = sheetObject.cell(CellIndex.indexByString('F$r'));
        cell.cellStyle = cellGray;
        cell.value = m.variant.text;

        //newvalues
        cell = sheetObject.cell(CellIndex.indexByString('G$r'));
        cell.cellStyle = cellGray;
        cell.value = int.tryParse(m.newvalues[0].text) ?? 0;

        cell = sheetObject.cell(CellIndex.indexByString('H$r'));
        cell.cellStyle = cellGray;
        cell.value = int.tryParse(m.newvalues[1].text) ?? 0;

        cell = sheetObject.cell(CellIndex.indexByString('I$r'));
        cell.cellStyle = cellGray;
        cell.value = int.tryParse(m.newvalues[2].text) ?? 0;

        cell = sheetObject.cell(CellIndex.indexByString('J$r'));
        cell.cellStyle = cellGray;
        cell.value = int.tryParse(m.newvalues[3].text) ?? 0;

        cell = sheetObject.cell(CellIndex.indexByString('K$r'));
        cell.cellStyle = cellGray;
        cell.value = int.tryParse(m.newvalues[4].text) ?? 0;

        cell = sheetObject.cell(CellIndex.indexByString('L$r'));
        cell.cellStyle = cellGray;
        cell.value = int.tryParse(m.newvalues[5].text) ?? 0;

        cell = sheetObject.cell(CellIndex.indexByString('M$r'));
        cell.cellStyle = cellGray;
        cell.value = int.tryParse(m.newvalues[6].text) ?? 0;

        cell = sheetObject.cell(CellIndex.indexByString('N$r'));
        cell.cellStyle = cellGray;
        cell.value = int.tryParse(m.newvalues[7].text) ?? 0;

        cell = sheetObject.cell(CellIndex.indexByString('O$r'));
        cell.cellStyle = cellGray;
        cell.value = int.tryParse(m.newvalues[8].text) ?? 0;

        cell = sheetObject.cell(CellIndex.indexByString('P$r'));
        cell.cellStyle = cellGray;
        cell.value = int.tryParse(m.newvalues[9].text) ?? 0;

        cell = sheetObject.cell(CellIndex.indexByString('Q$r'));
        cell.cellStyle = cellGray;
        cell.value = int.tryParse(m.newvalues[10].text) ?? 0;

        cell = sheetObject.cell(CellIndex.indexByString('R$r'));
        cell.cellStyle = cellGray;
        cell.value = int.tryParse(m.newvalues[11].text) ?? 0;

        cell = sheetObject.cell(CellIndex.indexByString('S$r'));
        cell.cellStyle = cellGray;
        cell.value = int.tryParse(m.newvalues[12].text) ?? 0;
        r++;

        //remains
        cell = sheetObject.cell(CellIndex.indexByString('G$r'));
        cell.cellStyle = cellGreen;
        cell.value = int.tryParse(m.pahest[0].text) ?? 0;

        cell = sheetObject.cell(CellIndex.indexByString('H$r'));
        cell.cellStyle = cellGreen;
        cell.value = int.tryParse(m.pahest[1].text) ?? 0;

        cell = sheetObject.cell(CellIndex.indexByString('I$r'));
        cell.cellStyle = cellGreen;
        cell.value = int.tryParse(m.pahest[2].text) ?? 0;

        cell = sheetObject.cell(CellIndex.indexByString('J$r'));
        cell.cellStyle = cellGreen;
        cell.value = int.tryParse(m.pahest[3].text) ?? 0;

        cell = sheetObject.cell(CellIndex.indexByString('K$r'));
        cell.cellStyle = cellGreen;
        cell.value = int.tryParse(m.pahest[4].text) ?? 0;

        cell = sheetObject.cell(CellIndex.indexByString('L$r'));
        cell.cellStyle = cellGreen;
        cell.value = int.tryParse(m.pahest[5].text) ?? 0;

        cell = sheetObject.cell(CellIndex.indexByString('M$r'));
        cell.cellStyle = cellGreen;
        cell.value = int.tryParse(m.pahest[6].text) ?? 0;

        cell = sheetObject.cell(CellIndex.indexByString('N$r'));
        cell.cellStyle = cellGreen;
        cell.value = int.tryParse(m.pahest[7].text) ?? 0;

        cell = sheetObject.cell(CellIndex.indexByString('O$r'));
        cell.cellStyle = cellGreen;
        cell.value = int.tryParse(m.pahest[8].text) ?? 0;

        cell = sheetObject.cell(CellIndex.indexByString('P$r'));
        cell.cellStyle = cellGreen;
        cell.value = int.tryParse(m.pahest[9].text) ?? 0;

        cell = sheetObject.cell(CellIndex.indexByString('Q$r'));
        cell.cellStyle = cellGreen;
        cell.value = int.tryParse(m.pahest[10].text) ?? 0;

        cell = sheetObject.cell(CellIndex.indexByString('R$r'));
        cell.cellStyle = cellGreen;
        cell.value = int.tryParse(m.pahest[11].text) ?? 0;

        cell = sheetObject.cell(CellIndex.indexByString('S$r'));
        cell.cellStyle = cellGreen;
        cell.value = int.tryParse(m.pahest[12].text) ?? 0;
        r++;

        //diffs
        int diff = (int.tryParse(m.pahest[0].text) ?? 0) -
            (int.tryParse(m.newvalues[0].text) ?? 0);
        cell = sheetObject.cell(CellIndex.indexByString('G$r'));
        cell.cellStyle = diff < 0 ? cellRed : cellGreen;
        cell.value = diff;

        diff = (int.tryParse(m.pahest[1].text) ?? 0) -
            (int.tryParse(m.newvalues[1].text) ?? 0);
        cell = sheetObject.cell(CellIndex.indexByString('H$r'));
        cell.cellStyle = diff < 0 ? cellRed : cellGreen;
        cell.value = diff;

        diff = (int.tryParse(m.pahest[2].text) ?? 0) -
            (int.tryParse(m.newvalues[2].text) ?? 0);
        cell = sheetObject.cell(CellIndex.indexByString('I$r'));
        cell.cellStyle = diff < 0 ? cellRed : cellGreen;
        cell.value = diff;

        diff = (int.tryParse(m.pahest[3].text) ?? 0) -
            (int.tryParse(m.newvalues[3].text) ?? 0);
        cell = sheetObject.cell(CellIndex.indexByString('J$r'));
        cell.cellStyle = diff < 0 ? cellRed : cellGreen;
        cell.value = diff;

        diff = (int.tryParse(m.pahest[4].text) ?? 0) -
            (int.tryParse(m.newvalues[4].text) ?? 0);
        cell = sheetObject.cell(CellIndex.indexByString('K$r'));
        cell.cellStyle = diff < 0 ? cellRed : cellGreen;
        cell.value = diff;

        diff = (int.tryParse(m.pahest[5].text) ?? 0) -
            (int.tryParse(m.newvalues[5].text) ?? 0);
        cell = sheetObject.cell(CellIndex.indexByString('L$r'));
        cell.cellStyle = diff < 0 ? cellRed : cellGreen;
        cell.value = diff;

        diff = (int.tryParse(m.pahest[6].text) ?? 0) -
            (int.tryParse(m.newvalues[6].text) ?? 0);
        cell = sheetObject.cell(CellIndex.indexByString('M$r'));
        cell.cellStyle = diff < 0 ? cellRed : cellGreen;
        cell.value = diff;

        diff = (int.tryParse(m.pahest[7].text) ?? 0) -
            (int.tryParse(m.newvalues[7].text) ?? 0);
        cell = sheetObject.cell(CellIndex.indexByString('N$r'));
        cell.cellStyle = diff < 0 ? cellRed : cellGreen;
        cell.value = diff;

        diff = (int.tryParse(m.pahest[8].text) ?? 0) -
            (int.tryParse(m.newvalues[8].text) ?? 0);
        cell = sheetObject.cell(CellIndex.indexByString('O$r'));
        cell.cellStyle = diff < 0 ? cellRed : cellGreen;
        cell.value = diff;

        diff = (int.tryParse(m.pahest[9].text) ?? 0) -
            (int.tryParse(m.newvalues[9].text) ?? 0);
        cell = sheetObject.cell(CellIndex.indexByString('P$r'));
        cell.cellStyle = diff < 0 ? cellRed : cellGreen;
        cell.value = diff;

        diff = (int.tryParse(m.pahest[10].text) ?? 0) -
            (int.tryParse(m.newvalues[10].text) ?? 0);
        cell = sheetObject.cell(CellIndex.indexByString('Q$r'));
        cell.cellStyle = diff < 0 ? cellRed : cellGreen;
        cell.value = diff;

        diff = (int.tryParse(m.pahest[11].text) ?? 0) -
            (int.tryParse(m.newvalues[11].text) ?? 0);
        cell = sheetObject.cell(CellIndex.indexByString('R$r'));
        cell.cellStyle = diff < 0 ? cellRed : cellGreen;
        cell.value = diff;

        diff = (int.tryParse(m.pahest[12].text) ?? 0) -
            (int.tryParse(m.newvalues[12].text) ?? 0);
        cell = sheetObject.cell(CellIndex.indexByString('S$r'));
        cell.cellStyle = diff < 0 ? cellRed : cellGreen;
        cell.value = diff;
        r++;
        r++;
      }
      r++;
    }

    for (int i = 0; i < 17; i++) {
      sheetObject.setColAutoFit(i);
    }

    var fileBytes = excel.save(fileName: 'preloading.xlsx');
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
