import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:sartex/data/data_sizes.dart';
import 'package:sartex/data/sql.dart';
import 'package:sartex/screen/preloading/preloading_data.dart';
import 'package:sartex/screen/preloading/preloading_item.dart';
import 'package:sartex/screen/preloading/preloading_size.dart';
import 'package:sartex/utils/consts.dart';
import 'package:sartex/utils/http_sql.dart';
import 'package:sartex/utils/prefs.dart';
import 'package:sartex/utils/translator.dart';

class PreloadingFullItem {
  String prLine = '';
  List<PreloadingItem> items = [];
}

class PreloadingModel {
  final PreloadingData data = PreloadingData();
  List<String> lines = [
    '',
    'Line1',
    'Line2',
    'Line3',
    'Line4',
    'Line5',
    'Line6',
    'Line7',
    'Line8',
    'Line9',
    'Line10',
    'Line11',
    'Line12',
    'Line13',
    'Line14',
    'Line15',
    'Line16',
    'Alex'
  ];
  final TextEditingController editDate = TextEditingController();
  final TextEditingController editTruck = TextEditingController();
  final TextEditingController editStore = TextEditingController();
  final TextEditingController editReceipant = TextEditingController();

  //New PRELOADING
  PreloadingFullItem prLine = PreloadingFullItem();
  final List<PreloadingFullItem> prReadyLines = [];
  String? docNumber;

  Future<String> save() async {
    String err = '';
    if (editDate.text.isEmpty) {
      err += '${L.tr('Date is not selected')}\r\n';
    }
    if (editTruck.text.isEmpty) {
      err += '${L.tr('The truck is not selected')}\r\n';
    }
    if (editStore.text.isEmpty) {
      err += '${L.tr('The store is not selected')}\r\n';
    }
    if (editReceipant.text.isEmpty) {
      err += '${L.tr('The receipant is not selected')}\r\n';
    }
    if (prReadyLines.isEmpty) {
      err += L.tr('No data for saving') + '\r\n';
    }
    if (err.isNotEmpty) {
      return err;
    }
    late List<dynamic> httpData;
    if (docNumber == null) {
      httpData =
          await HttpSqlQuery.post({'sl': "select max(id) as maxid from Docs"});
      docNumber = 'Doc23-${httpData[0]['maxid']}';
    }
    for (var pr in prReadyLines) {
      for (var item in pr.items) {
        for (int i = 0; i < 10; i++) {
          int qty = int.tryParse(item.newvalues[i].text) ?? 0;
          if (qty == 0) {
            continue;
          }

          String? aprid = item.preSize?.aprIdOfIndex(i);
          if (aprid == null || qty == null) {
            continue;
          }
          Map<String, String> bind = {};
          bind['branch'] = prefs.getString(key_user_branch)!;
          bind['type'] = 'OUT';
          bind['date'] = DateFormat('yyyy-MM-dd')
              .format(DateFormat('dd/MM/yyyy').parse(editDate.text));
          bind['docnum'] = docNumber!;
          bind['apr_id'] = aprid;
          bind['pahest'] = editStore.text;
          bind['qanak'] = qty.toString();
          bind['status'] = 'draft';
          bind['avto'] = editTruck.text;
          bind['ditox'] = pr.prLine;
          bind['partner'] = editReceipant.text;
          String insertSql = Sql.insert('Docs', bind);
          await HttpSqlQuery.post({'sl': insertSql});
        }
      }
    }
    return err;
  }

  void open(String docNum) {
    HttpSqlQuery.post({'sl':"select pd.brand, pd.Model, pd.PatverN, pd.Colore, pd.variant_prod, pd.country, a.pat_mnac, d.qanak from Docs d left join Apranq a on a.apr_id=d.apr_id left join patver_data pd on pd.id=a.pid where d.docnum='$docNum'"}).then((value) {
      for (var e in value) {

      }
    });
  }
}
