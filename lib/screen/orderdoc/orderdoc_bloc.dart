import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:sartex/screen/patver_data/order_row.dart';
import 'package:sartex/data/sql.dart';
import 'package:sartex/utils/consts.dart';
import 'package:sartex/utils/http_sql.dart';
import 'package:sartex/utils/prefs.dart';

import 'orderdoc_event.dart';
import 'orderdoc_state.dart';

class OrderDocBloc extends Bloc<OrderDocEvent, OrderDocState> {
  OrderDocBloc(super.initialState) {
    on<OrderDocEventIdle>((event, emit) => brandList());
    on<OrderDocBrandChanged>((event, emit) => modelList(event));
    on<OrderDocModelChanged>((event, emit) => sizeList(event));
    on<OrderDocNewRow>((event, emit) => emit(OrderDocStateNewRow()));
    on<OrderDocEventOpen>((event, emit) => openOrder(event));
    on<OrderDocSubRow>(
        (event, emit) => emit(OrderDocSubRowState(row: event.row)));
  }

  Future<void> brandList() async {
    List<String> l = [];
    final value = await HttpSqlQuery.post({
      'sl':
          "select distinct(brand) as brand from Products where branch='${prefs.getString(key_user_branch)}'"
    });
    for (final e in value) {
      l.add(e['brand']);
    }
    emit(OrderDocStateBrand(l));
  }

  Future<void> modelList(OrderDocBrandChanged o) async {
    Map<String, String> l = {};
    Map<String, String> s = {};
    final value = await HttpSqlQuery.get(
        "select brand, model, modelCode,  size_standart  from Products where brand='${o.brand}' and branch='${prefs.getString(key_user_branch)}'");
    for (var e in value) {
      l[e['model']] = e['modelCode'];
      s[e['model']] = e['size_standart'];
    }
    emit(OrderDocStateModel(l, s));
  }

  Future<void> sizeList(OrderDocModelChanged o) async {
    if (o.size.isEmpty) {
      emit(OrderDocStateSizes([]));
      return;
    }
    var value =
        await HttpSqlQuery.get("select * from Sizes where code='${o.size}'");
    var e = value[0];
    emit(OrderDocStateSizes([
      e['size01'],
      e['size02'],
      e['size03'],
      e['size04'],
      e['size05'],
      e['size06'],
      e['size07'],
      e['size08'],
      e['size09'],
      e['size10'],
      e['size11'],
      e['size12']
    ]));
  }

  Future<void> openOrder(OrderDocEventOpen o) async {
    var value = await HttpSqlQuery.postString({
      'sl':
          "${sqlList['open_patver_data'].toString().replaceAll('%where1%', "where IDPatver='${o.id}' ").replaceAll('%where2%', " where IDPatver='${o.id}' ")}"
    });
    List<OrderRow> l = [];
    OrderRowList orl = OrderRowList.fromJson({'list': jsonDecode(value)});
    for (var e in orl.list) {
      l.add(e);
    }
    emit(OrderDocStateLoaded(l));
  }
}
