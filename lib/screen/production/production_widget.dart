import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sartex/screen/plan_and_production/pp_bloc.dart';
import 'package:sartex/screen/production/production_model.dart';
import 'package:sartex/utils/consts.dart';
import 'package:sartex/utils/translator.dart';
import 'package:sartex/widgets/edit_widget.dart';
import 'package:sartex/widgets/svg_button.dart';

class ProductionWidget extends EditWidget {
  late final ProductionModel _model;

  final InputDecoration labelDecor = const InputDecoration(
      isDense: true,
      border: InputBorder.none,
      contentPadding: EdgeInsets.fromLTRB(3, 5, 3, 5));
  final InputDecoration formDecor = const InputDecoration(
      isDense: true,
      border: InputBorder.none,
      contentPadding: EdgeInsets.fromLTRB(5, 15, 5, 15));

  ProductionWidget({super.key, required String line}) {
    _model = ProductionModel(line: line);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Container(
            decoration: const BoxDecoration(border: Border.fromBorderSide(BorderSide(color: Color(0xffaabbff)))),
            margin: const EdgeInsets.fromLTRB(10, 0, 10, 2),
            height: MediaQuery.of(context).size.height * 0.39,
            child: BlocBuilder<PPBloc, PPState>(
                buildWhen: (previouse, current) => current is PSLine,
                builder: (contest, state) {
                  if (state is PSLine) {
                    if (state.open) {
                      _model.lines.name = state.line;
                      _model.open().then((value) {
                        BlocProvider.of<PPBloc>(context)
                            .add(PALine(line: state.line, open: false));
                      });
                    }
                  }
                  return Column(children: [
                    Container(
                        decoration:
                            const BoxDecoration(color: Colors.blueAccent),
                        child: Row(
                          children: [
                            const SizedBox(width: 10), Text(L.tr('Production line'), style: const TextStyle(color: Colors.white, fontSize: 18)),
                            const SizedBox(width: 10),
                            Expanded(child: Text(_model.lines.name, style: const TextStyle(color: Colors.white, fontSize: 18))),
                            SvgButton(
                                onTap: () {
                                  appDialogYesNo(
                                      context, L.tr('Save document?'), () {
                                    _model.save().then((value) {
                                      if (value.isNotEmpty) {
                                        appDialog(context, value);
                                        return;
                                      }
                                      BlocProvider.of<PPBloc>(context).add(PARefresh());
                                    });
                                  }, () {});
                                },
                                assetPath: 'svg/save.svg'),
                            SvgButton(
                                onTap: () {
                                  _model.lines.items.add(ProductionItem(true));
                                  _model.linesController.add(null);
                                },
                                assetPath: 'svg/plus.svg'),
                            const SizedBox(width: 10),
                          ],
                        )),
                    state is PSLine
                        ? (state as PSLine).open
                            ? const Center(
                                child: SizedBox(
                                    height: 30,
                                    width: 30,
                                    child: CircularProgressIndicator()))
                            : Expanded(
                                child: SingleChildScrollView(
                                    child: lines(context)))
                        : Container(),
                  ]);
                })));
  }

  @override
  String getTable() {
    return 'Production';
  }

  Widget lines(BuildContext context) {
    return StreamBuilder(
        stream: _model.linesController.stream,
        builder: (context, snapshot) {
          return Column(
            children: [
              Column(children: [
                for (var l in _model.lines.items) ...[
                  Container(
                      margin: const EdgeInsets.fromLTRB(5, 5, 5, 0),
                      decoration: const BoxDecoration(color: Colors.white),
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            //BRAND
                            Container(
                              width: 120,
                              decoration: const BoxDecoration(
                                  color: Colors.black12,
                                  border: Border.fromBorderSide(BorderSide(
                                      color: Colors.black26, width: 0.2))),
                              child: Column(
                                children: [
                                  Container(
                                      decoration: const BoxDecoration(
                                          color: Colors.black12,
                                          border: Border.fromBorderSide(
                                              BorderSide(
                                                  color: Colors.black26,
                                                  width: 0.2))),
                                      child: TextFormField(
                                        readOnly: true,
                                        decoration: labelDecor,
                                        initialValue: L.tr('Brand'),
                                      )),
                                  Container(
                                      decoration: const BoxDecoration(
                                          color: Colors.black12,
                                          border: Border.fromBorderSide(
                                              BorderSide(
                                                  color: Colors.black26,
                                                  width: 0.2))),
                                      child: TextFormField(
                                        decoration: formDecor,
                                        controller: l.editBrand,
                                        onTap: () {
                                          if (!l.canEditModel) {
                                            return;
                                          }
                                          valueOfList(context, l.brandLevel,
                                              l.editBrand, done: () {
                                            l.clearAfterBrand();
                                            l
                                                .buildModelLevel(
                                                    l.editBrand.text)
                                                .then((value) {
                                              if (l.modelLevel.length == 1) {
                                                l.editModel.text =
                                                    l.modelLevel.first;
                                              }
                                            });
                                          });
                                        },
                                      ))
                                ],
                              ),
                            ),
                            //MODEL
                            Container(
                              width: 200,
                              decoration: const BoxDecoration(
                                  color: Colors.black12,
                                  border: Border.fromBorderSide(BorderSide(
                                      color: Colors.black26, width: 0.2))),
                              child: Column(
                                children: [
                                  Container(
                                      decoration: const BoxDecoration(
                                          color: Colors.black12,
                                          border: Border.fromBorderSide(
                                              BorderSide(
                                                  color: Colors.black26,
                                                  width: 0.2))),
                                      child: TextFormField(
                                        readOnly: true,
                                        decoration: labelDecor,
                                        initialValue: L.tr('Model'),
                                      )),
                                  Container(
                                      decoration: const BoxDecoration(
                                          color: Colors.black12,
                                          border: Border.fromBorderSide(
                                              BorderSide(
                                                  color: Colors.black26,
                                                  width: 0.2))),
                                      child: TextFormField(
                                        decoration: formDecor,
                                        controller: l.editModel
                                          ..addListener(() {
                                            if (!l.canEditModel) {
                                              return;
                                            }
                                            l.clearAfterModel();
                                            if (l.editModel.text.isNotEmpty) {
                                              l
                                                  .buildCommesaLevel(
                                                      l.editBrand.text,
                                                      l.editModel.text)
                                                  .then((value) {
                                                if (l.commesaLevel.length ==
                                                    1) {
                                                  l.editCommesa.text =
                                                      l.commesaLevel.first;
                                                }
                                              });
                                            }
                                          }),
                                        onTap: () {
                                          if (!l.canEditModel) {
                                            return;
                                          }
                                          valueOfList(context, l.modelLevel,
                                              l.editModel, done: () {
                                            l.clearAfterModel();
                                            l
                                                .buildCommesaLevel(
                                                    l.editBrand.text,
                                                    l.editModel.text)
                                                .then((value) {
                                              if (l.commesaLevel.length == 1) {
                                                l.editCommesa.text =
                                                    l.commesaLevel.first;
                                              }
                                            });
                                          });
                                        },
                                      ))
                                ],
                              ),
                            ),
                            //COMMES
                            Container(
                              width: 100,
                              decoration: const BoxDecoration(
                                  color: Colors.black12,
                                  border: Border.fromBorderSide(BorderSide(
                                      color: Colors.black26, width: 0.2))),
                              child: Column(
                                children: [
                                  Container(
                                      decoration: const BoxDecoration(
                                          color: Colors.black12,
                                          border: Border.fromBorderSide(
                                              BorderSide(
                                                  color: Colors.black26,
                                                  width: 0.2))),
                                      child: TextFormField(
                                        readOnly: true,
                                        decoration: labelDecor,
                                        initialValue: L.tr('Order'),
                                      )),
                                  Container(
                                      decoration: const BoxDecoration(
                                          color: Colors.black12,
                                          border: Border.fromBorderSide(
                                              BorderSide(
                                                  color: Colors.black26,
                                                  width: 0.2))),
                                      child: TextFormField(
                                        decoration: formDecor,
                                        controller: l.editCommesa
                                          ..addListener(() {
                                            if (!l.canEditModel) {
                                              return;
                                            }
                                            l.clearAfterCommesa();
                                            if (l.editCommesa.text.isNotEmpty) {
                                              l
                                                  .buildCountryLevel(
                                                      l.editBrand.text,
                                                      l.editModel.text,
                                                      l.editCommesa.text)
                                                  .then((value) {
                                                if (l.countryLevel.length ==
                                                    1) {
                                                  l.editCountry.text =
                                                      l.countryLevel.first;
                                                }
                                              });
                                            }
                                          }),
                                        onTap: () {
                                          if (!l.canEditModel) {
                                            return;
                                          }
                                          valueOfList(context, l.commesaLevel,
                                              l.editCommesa, done: () {
                                            l.clearAfterCommesa();
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
                                      ))
                                ],
                              ),
                            ),
                            //COUNTRY
                            Container(
                              width: 100,
                              decoration: const BoxDecoration(
                                  color: Colors.black12,
                                  border: Border.fromBorderSide(BorderSide(
                                      color: Colors.black26, width: 0.2))),
                              child: Column(
                                children: [
                                  Container(
                                      decoration: const BoxDecoration(
                                          color: Colors.black12,
                                          border: Border.fromBorderSide(
                                              BorderSide(
                                                  color: Colors.black26,
                                                  width: 0.2))),
                                      child: TextFormField(
                                        readOnly: true,
                                        decoration: labelDecor,
                                        initialValue: L.tr('Country'),
                                      )),
                                  Container(
                                      decoration: const BoxDecoration(
                                          color: Colors.black12,
                                          border: Border.fromBorderSide(
                                              BorderSide(
                                                  color: Colors.black26,
                                                  width: 0.2))),
                                      child: TextFormField(
                                        decoration: formDecor,
                                        controller: l.editCountry
                                          ..addListener(() {
                                            if (!l.canEditModel) {
                                              return;
                                            }
                                            l.clearAfterCountry();
                                            if (l.editCountry.text.isNotEmpty) {
                                              l
                                                  .buildColorLevel(
                                                      l.editBrand.text,
                                                      l.editModel.text,
                                                      l.editCommesa.text,
                                                      l.editCountry.text)
                                                  .then((value) {
                                                if (l.colorLevel.length == 1) {
                                                  l.editColor.text =
                                                      l.colorLevel.first;
                                                }
                                              });
                                            }
                                          }),
                                        onTap: () {
                                          if (!l.canEditModel) {
                                            return;
                                          }
                                          valueOfList(context, l.countryLevel,
                                              l.editCountry, done: () {
                                            l.clearAfterCountry();
                                            l
                                                .buildColorLevel(
                                                    l.editBrand.text,
                                                    l.editModel.text,
                                                    l.editCommesa.text,
                                                    l.editCountry.text)
                                                .then((value) {
                                              if (l.colorLevel.length == 1) {
                                                l.editColor.text =
                                                    l.colorLevel.first;
                                              }
                                            });
                                          });
                                        },
                                      ))
                                ],
                              ),
                            ),
                            //COLOR
                            Container(
                              width: 100,
                              decoration: const BoxDecoration(
                                  color: Colors.black12,
                                  border: Border.fromBorderSide(BorderSide(
                                      color: Colors.black26, width: 0.2))),
                              child: Column(
                                children: [
                                  Container(
                                      decoration: const BoxDecoration(
                                          color: Colors.black12,
                                          border: Border.fromBorderSide(
                                              BorderSide(
                                                  color: Colors.black26,
                                                  width: 0.2))),
                                      child: TextFormField(
                                        readOnly: true,
                                        decoration: labelDecor,
                                        initialValue: L.tr('Color'),
                                      )),
                                  Container(
                                      decoration: const BoxDecoration(
                                          color: Colors.black12,
                                          border: Border.fromBorderSide(
                                              BorderSide(
                                                  color: Colors.black26,
                                                  width: 0.2))),
                                      child: TextFormField(
                                        decoration: formDecor,
                                        controller: l.editColor
                                          ..addListener(() {
                                            if (!l.canEditModel) {
                                              return;
                                            }
                                            l.clearAfterColor();
                                            if (l.editColor.text.isNotEmpty) {
                                              l
                                                  .buildVariantLevel(
                                                      l.editBrand.text,
                                                      l.editModel.text,
                                                      l.editCommesa.text,
                                                      l.editCountry.text,
                                                      l.editColor.text)
                                                  .then((value) {
                                                if (l.variantLevel.length ==
                                                    1) {
                                                  l.editVariant.text =
                                                      l.variantLevel.first;
                                                }
                                              });
                                            }
                                          }),
                                        onTap: () {
                                          if (!l.canEditModel) {
                                            return;
                                          }
                                          valueOfList(context, l.colorLevel,
                                              l.editColor, done: () {
                                            l.clearAfterColor();
                                            l
                                                .buildVariantLevel(
                                                    l.editBrand.text,
                                                    l.editModel.text,
                                                    l.editCommesa.text,
                                                    l.editCountry.text,
                                                    l.editColor.text)
                                                .then((value) {
                                              if (l.variantLevel.length == 1) {
                                                l.editVariant.text =
                                                    l.variantLevel.first;
                                              }
                                            });
                                          });
                                        },
                                      ))
                                ],
                              ),
                            ),
                            //VARIANT
                            Container(
                              width: 100,
                              decoration: const BoxDecoration(
                                  color: Colors.black12,
                                  border: Border.fromBorderSide(BorderSide(
                                      color: Colors.black26, width: 0.2))),
                              child: Column(
                                children: [
                                  Container(
                                      decoration: const BoxDecoration(
                                          color: Colors.black12,
                                          border: Border.fromBorderSide(
                                              BorderSide(
                                                  color: Colors.black26,
                                                  width: 0.2))),
                                      child: TextFormField(
                                        readOnly: true,
                                        decoration: labelDecor,
                                        initialValue: L.tr('Variant'),
                                      )),
                                  Container(
                                      decoration: const BoxDecoration(
                                          color: Colors.black12,
                                          border: Border.fromBorderSide(
                                              BorderSide(
                                                  color: Colors.black26,
                                                  width: 0.2))),
                                      child: TextFormField(
                                        decoration: formDecor,
                                        controller: l.editVariant
                                          ..addListener(() {
                                            if (!l.canEditModel) {
                                              return;
                                            }
                                            l.clearAfterVariant();
                                            if (l.editVariant.text.isNotEmpty) {
                                              l
                                                  .getSizes(
                                                      l.editBrand.text,
                                                      l.editModel.text,
                                                      l.editCommesa.text,
                                                      l.editCountry.text,
                                                      l.editColor.text,
                                                      l.editVariant.text)
                                                  .then((value) {});
                                            }
                                          }),
                                        onTap: () {
                                          if (!l.canEditModel) {
                                            return;
                                          }
                                          valueOfList(context, l.variantLevel,
                                              l.editVariant, done: () {
                                            l.clearAfterVariant();
                                            l
                                                .getSizes(
                                                    l.editBrand.text,
                                                    l.editModel.text,
                                                    l.editCommesa.text,
                                                    l.editCountry.text,
                                                    l.editColor.text,
                                                    l.editVariant.text)
                                                .then((value) {});
                                          });
                                        },
                                      ))
                                ],
                              ),
                            ),
                            //SIZES
                            for (int i = 0; i < 13; i++) ...[
                              Container(
                                width: i == 12 ? 100 : 60,
                                decoration: const BoxDecoration(
                                    color: Colors.black12,
                                    border: Border.fromBorderSide(BorderSide(
                                        color: Colors.black26, width: 0.2))),
                                child: Column(
                                  children: [
                                    Container(
                                        alignment: Alignment.center,
                                        width: i == 12 ? 100 : 60,
                                        decoration: const BoxDecoration(
                                            color: Colors.black12,
                                            border: Border.fromBorderSide(
                                                BorderSide(
                                                    color: Colors.black26,
                                                    width: 0.2))),
                                        child: TextFormField(
                                          readOnly: true,
                                          decoration: labelDecor,
                                          controller: l.sizes[i],
                                        )),
                                    Container(
                                        width: i == 12 ? 100 : 60,
                                        decoration: const BoxDecoration(
                                            color: Colors.yellow,
                                            border: Border.fromBorderSide(
                                                BorderSide(
                                                    color: Colors.black26,
                                                    width: 0.2))),
                                        child: MouseRegion(
                                            child: InkWell(
                                                onTap: () {
                                                  if (i < 12) {
                                                    l.newvalues[i].text =
                                                        l.remains[i].text;
                                                  } else {
                                                    for (int n = 0;
                                                        n < 12;
                                                        n++) {
                                                      l.newvalues[n].text =
                                                          l.remains[n].text;
                                                    }
                                                  }
                                                },
                                                child: IgnorePointer(
                                                    ignoring: true,
                                                    child: TextFormField(
                                                        readOnly: true,
                                                        decoration: formDecor,
                                                        controller:
                                                            l.remains[i]))))),
                                    Container(
                                        width: i == 12 ? 100 : 60,
                                        decoration: const BoxDecoration(
                                            color: Colors.white,
                                            border: Border.fromBorderSide(
                                                BorderSide(
                                                    color: Colors.black26,
                                                    width: 0.2))),
                                        child: TextFormField(
                                            readOnly: i > 11,
                                            decoration: formDecor,
                                            controller: l.newvalues[i]
                                              ..addListener(() {
                                                l
                                                    .newvalues[
                                                        l.newvalues.length - 1]
                                                    .text = l.sumOfNewValues();
                                                if ((int.tryParse(l.newvalues[i]
                                                            .text) ??
                                                        0) >
                                                    (int.tryParse(l
                                                            .remains[i].text) ??
                                                        0)) {
                                                  l.newvalues[i].clear();
                                                }
                                              })))
                                  ],
                                ),
                              )
                            ]
                          ]))
                ],
              ])
            ],
          );
        });
  }
}