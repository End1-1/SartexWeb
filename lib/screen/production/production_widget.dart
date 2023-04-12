import 'package:flutter/material.dart';
import 'package:sartex/screen/production/production_model.dart';
import 'package:sartex/utils/consts.dart';
import 'package:sartex/utils/translator.dart';
import 'package:sartex/widgets/edit_widget.dart';
import 'package:sartex/widgets/svg_button.dart';

class ProductionWidget extends EditWidget {
  final _model = ProductionModel();

  final InputDecoration labelDecor = const InputDecoration(
      isDense: true,
      border: InputBorder.none,
      contentPadding: EdgeInsets.fromLTRB(3, 5, 3, 5));
  final InputDecoration formDecor = const InputDecoration(
      isDense: true,
      border: InputBorder.none,
      contentPadding: EdgeInsets.fromLTRB(5, 15, 5, 15));

  ProductionWidget({super.key, required String? DocN}) {
    _model.DocN = DocN;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: MediaQuery.of(context).size.height * 0.9,
        width: MediaQuery.of(context).size.width * 0.9,
        child: Column(children: [
          Row(children: [
            Expanded(
                child: Text(L.tr('Production'),
                    textAlign: TextAlign.center, style: tsDialogHeader))
          ]),
          headerRow1(context),
          Expanded(child: SingleChildScrollView(child: lines(context))),
          Row(
            children: [
              Expanded(
                  child: Align(
                      alignment: Alignment.center,
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
        ]));
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
                Container(
                    margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                    decoration: const BoxDecoration(color: Colors.blueAccent),
                    child: Row(
                      children: [
                        Text(L.tr('Line')),
                        const SizedBox(width: 10),
                        Expanded(child: DropdownLine(productionLine: e)),
                        SvgButton(
                            onTap: () {
                              e.items.add(ProductionItem());
                              _model.linesController.add(null);
                            },
                            assetPath: 'svg/plus.svg'),
                        const SizedBox(width: 10),
                      ],
                    )),
                Column(children: [
                  for (var l in e.items) ...[
                    Container(
                        margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                        decoration: const BoxDecoration(color: Colors.black38),
                        child: Row(children: [
                          //BRAND
                          Container(
                            width: 120,
                            decoration:
                                const BoxDecoration(color: Colors.black38),
                            child: Column(
                              children: [
                                TextFormField(
                                  readOnly: true,
                                  decoration: labelDecor,
                                  initialValue: L.tr('Brand'),
                                ),
                                TextFormField(
                                  decoration: formDecor,
                                  controller: l.editBrand,
                                  onTap: () {
                                    valueOfList(
                                        context, l.brandLevel, l.editBrand,
                                        done: () {
                                      l
                                          .buildModelLevel(l.editBrand.text)
                                          .then((value) {
                                        if (l.modelLevel.length == 1) {
                                          l.editModel.text = l.modelLevel.first;
                                        }
                                      });
                                    });
                                  },
                                )
                              ],
                            ),
                          ),
                          //MODEL
                          Container(
                            width: 200,
                            decoration:
                                const BoxDecoration(color: Colors.black38),
                            child: Column(
                              children: [
                                TextFormField(
                                  readOnly: true,
                                  decoration: labelDecor,
                                  initialValue: L.tr('Model'),
                                ),
                                TextFormField(
                                  decoration: formDecor,
                                  controller: l.editModel
                                    ..addListener(() {
                                      l
                                          .buildCommesaLevel(l.editBrand.text,
                                              l.editModel.text)
                                          .then((value) {
                                        if (l.commesaLevel.length == 1) {
                                          l.editCommesa.text =
                                              l.commesaLevel.first;
                                        }
                                      });
                                    }),
                                  onTap: () {
                                    valueOfList(
                                        context, l.modelLevel, l.editModel,
                                        done: () {
                                      l
                                          .buildCommesaLevel(l.editBrand.text,
                                              l.editModel.text)
                                          .then((value) {
                                        if (l.commesaLevel.length == 1) {
                                          l.editCommesa.text =
                                              l.commesaLevel.first;
                                        }
                                      });
                                    });
                                  },
                                )
                              ],
                            ),
                          ),
                          //COMMES
                          Container(
                            width: 100,
                            decoration:
                                const BoxDecoration(color: Colors.black38),
                            child: Column(
                              children: [
                                TextFormField(
                                  readOnly: true,
                                  decoration: labelDecor,
                                  initialValue: L.tr('Order'),
                                ),
                                TextFormField(
                                  decoration: formDecor,
                                  controller: l.editCommesa
                                    ..addListener(() {
                                      l
                                          .buildCountryLevel(
                                              l.editBrand.text,
                                              l.editModel.text,
                                              l.editCommesa.text)
                                          .then((value) {
                                        if (l.countryLevel.length == 1) {
                                          l.editCountry.text =
                                              l.countryLevel.first;
                                        }
                                      });
                                    }),
                                  onTap: () {
                                    valueOfList(
                                        context, l.commesaLevel, l.editCommesa,
                                        done: () {
                                      l
                                          .buildCountryLevel(
                                              l.editBrand.text,
                                              l.editModel.text,
                                              l.editCommesa.text)
                                          .then((value) {
                                        if (l.countryLevel.length == 1) {
                                          l.editCountry.text =
                                              l.countryLevel.first;
                                        }
                                      });
                                    });
                                  },
                                )
                              ],
                            ),
                          ),
                          //COUNTRY
                          Container(
                            width: 100,
                            decoration:
                                const BoxDecoration(color: Colors.black38),
                            child: Column(
                              children: [
                                TextFormField(
                                  readOnly: true,
                                  decoration: labelDecor,
                                  initialValue: L.tr('Country'),
                                ),
                                TextFormField(
                                  decoration: formDecor,
                                  controller: l.editCountry
                                    ..addListener(() {
                                      l
                                          .buildColorLevel(
                                              l.editBrand.text,
                                              l.editModel.text,
                                              l.editCommesa.text,
                                              l.editCountry.text)
                                          .then((value) {
                                        if (l.colorLevel.length == 1) {
                                          l.editColor.text = l.colorLevel.first;
                                        }
                                      });
                                    }),
                                  onTap: () {
                                    valueOfList(
                                        context, l.countryLevel, l.editCountry,
                                        done: () {
                                      l
                                          .buildColorLevel(
                                              l.editBrand.text,
                                              l.editModel.text,
                                              l.editCommesa.text,
                                              l.editCountry.text)
                                          .then((value) {
                                        if (l.colorLevel.length == 1) {
                                          l.editColor.text = l.colorLevel.first;
                                        }
                                      });
                                    });
                                  },
                                )
                              ],
                            ),
                          )
                        ]))
                  ]
                ])
              ],
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
