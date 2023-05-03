import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sartex/data/data_product.dart';
import 'package:sartex/screen/orderdoc/orderdoc_bloc.dart';
import 'package:sartex/screen/orderdoc/orderdoc_screen.dart';
import 'package:sartex/utils/consts.dart';
import 'package:sartex/utils/http_sql.dart';
import 'package:sartex/utils/prefs.dart';
import 'package:sartex/widgets/svg_button.dart';

import 'orderdoc_event.dart';
import 'orderdoc_state.dart';

extension OrderDocHeader on OrderDocScreen {
  List<Widget> header(BuildContext context) {
    return [
      Row(children: [
        textFieldColumn(
            context: context,
            title: 'Order num',
            textEditingController: model.orderIdController,
            enabled: model.orderId!.isEmpty),
        textFieldColumn(
            context: context,
            title: 'Create date',
            textEditingController: model.dateCreateController,
            enabled: model.orderId!.isEmpty,
            onTap: model.orderId!.isEmpty
                ? () {
                    dateDialog(context, model.dateCreateController);
                  }
                : null),
        textFieldColumn(
          context: context,
          title: 'Execute date',
          textEditingController: model.dateForController,
          enabled: model.orderId!.isEmpty,
          onTap: model.orderId!.isEmpty
              ? () {
                  dateDialog(context, model.dateForController);
                }
              : null,
        )
      ]),
      Row(
        children: [
          textFieldColumn(
              context: context,
              title: 'Executor',
              textEditingController: model.executorController,
              enabled: model.orderId!.isEmpty,
              list: model.datasource.executors),
          textFieldColumn(
              context: context,
              title: 'Country',
              textEditingController: model.countryController,
              enabled: model.orderId!.isEmpty),
        ],
      ),
      Row(
        children: [
    BlocBuilder<OrderDocBloc, OrderDocState>(
    buildWhen: (previos, current) => current is OrderDocStateBrand,
    builder: (context, state) {
    return textFieldColumn(
            context: context,
            title: 'Brand',
            textEditingController: model.brandController
              ..addListener(model.orderId!.isEmpty
                  ? () {
                      model.modelController.clear();
                      model.modelCodeController.clear();
                      model.sizeStandartController.clear();
                      if (model.brandController.text.isNotEmpty) {
                        BlocProvider.of<OrderDocBloc>(context).add(
                            OrderDocBrandChanged(model.brandController.text));
                      }
                    }
                  : () {
                      print('NO BRAND LISTENER');
                    }),
            list: model.orderId!.isEmpty && state is OrderDocStateBrand ? state.brandList : null,
            enabled: model.orderId!.isEmpty,
          );}),
          BlocBuilder<OrderDocBloc, OrderDocState>(
              buildWhen: (previos, current) => current is OrderDocStateModel,
              builder: (context, state) {
                if (state is OrderDocStateModel) {
                  model.modelList.clear();
                  model.sizesList.clear();
                  model.modelList.addAll(state.modelList);
                  model.sizesList.addAll(state.sizeList);
                }
                return textFieldColumn(
                    context: context,
                    title: 'Model',
                    textEditingController: model.modelController
                      ..addListener(model.orderId!.isEmpty
                          ? () {
                            if (model.modelController.text.isNotEmpty) {
                              model.modelCodeController.text = model.modelList[model.modelController.text]!;
                              model.sizeStandartController.text = model.sizesList[model.modelController.text]!;
                            }
                              BlocProvider.of<OrderDocBloc>(context).add(OrderDocModelChanged(model.sizeStandartController.text));
                            }
                          : () {}),
                    list: model.orderId!.isEmpty ? model.modelList.keys.toList()
                        : null,
                    enabled: model.orderId!.isEmpty);
              }),
          textFieldColumn(
            enabled: false,
              context: context,
              title: 'Model code',
              textEditingController: model.modelCodeController,
              list: []),
          textFieldColumn(
            enabled: false,
              context: context,
              title: 'Size standart',
              textEditingController: model.sizeStandartController,
              list: []),
          if (model.orderId!.isEmpty)...[Container(margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),  child: Align(
              alignment: Alignment.centerLeft,
              child: SvgButton(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return SimpleDialog(children: [
                            ProductEditWidget(id: '')
                          ]);
                        }).then((value) async {
                          if (value != null) {
                            final val = await HttpSqlQuery.get(
                                "select brand, model, modelCode,  size_standart  from Products where brand='${value.brand}' and branch='${prefs.getString(key_user_branch)}'");
                            for (var e in val) {
                              model.modelList[e['model']] = e['modelCode'];
                              model.sizesList[e['model']] = e['size_standart'];
                            }
                            model.brandController.text = value.brand;
                            model.modelController.text = value.model;
                            model.modelCodeController.text = value.modelCode;
                            model.sizeStandartController.text =
                                value.size_standart;
                            BlocProvider.of<OrderDocBloc>(scaffoldKey.currentContext!).add(OrderDocModelChanged(model.sizeStandartController.text));
                          }
                    });
                  },
                  assetPath: 'svg/plus.svg',
                  darkMode: false)))]
        ],
      )
    ];
  }
}
