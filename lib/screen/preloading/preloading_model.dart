import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:sartex/data/sql.dart';
import 'package:sartex/screen/preloading/preloading_data.dart';
import 'package:sartex/screen/preloading/preloading_item.dart';
import 'package:sartex/utils/consts.dart';
import 'package:sartex/utils/http_sql.dart';
import 'package:sartex/utils/prefs.dart';
import 'package:sartex/utils/translator.dart';

class PreloadingFullItem {
  String prLine = '';
  List<PreloadingItem> items = [];
}

class PreloadingModel {
  bool showMnac = false;
  final PreloadingData data = PreloadingData();
  static List<String> lines = [
    '',
    'L1',
    'L2',
    'L3',
    'L4',
    'L5',
    'L6',
    'L7',
    'L8',
    'L9',
    'L10',
    'L11',
    'L12',
    'L13',
    'L14',
    'L15',
    'L16',
    'Alex'
  ];
  final TextEditingController editDate = TextEditingController();
  final TextEditingController editDocNum = TextEditingController();
  final TextEditingController editTruck = TextEditingController();
  final TextEditingController editStore = TextEditingController();
  final TextEditingController editReceipant = TextEditingController();

  //New PRELOADING
  PreloadingFullItem prLine = PreloadingFullItem();
  final List<String> storeNames = ['P1', 'P2', 'P3', 'P4'];
  final List<PreloadingFullItem> prReadyLines = [];
  String? docNumber;

  Future<String> save(PreloadingItem? onlyItem) async {
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
    if (docNumber == null || docNumber!.isEmpty) {
      httpData =
          await HttpSqlQuery.post({'sl': "select coalesce(max(id), 0) + 1 as maxid from Docs"});
      docNumber = 'Doc23-${httpData[0]['maxid']}';
    }
    for (var pr in prReadyLines) {
      for (var item in pr.items) {
        if (onlyItem != null) {
          if (onlyItem != item) {
            continue;
          }
        }
        for (int i = 0; i < 12; i++) {
          int qty = int.tryParse(item.newvalues[i].text) ?? 0;

          String? aprid = item.preSize?.aprIdOf(i);
          if (aprid == null || aprid.isEmpty || aprid == '0') {
            continue;
          }
          if (item.preSize!.prodIdOf(i).isNotEmpty) {
            if (onlyItem == null) {
              continue;
            }
            await HttpSqlQuery.post({'sl' : "update Docs set qanak=$qty where id=${item.preSize!.prodIdOf(i)}"});
            continue;
          }

          Map<String, String> bind = {};
          bind['branch'] = prefs.getString(key_user_branch)!;
          bind['type'] = 'OUT';
          bind['mutq_elq'] = 'elq';
          bind['date'] = DateFormat('yyyy-MM-dd')
              .format(DateFormat('dd/MM/yyyy').parse(editDate.text));
          bind['docnum'] = docNumber!;
          bind['apr_id'] = aprid;
          bind['pahest'] = editStore.text;
          bind['qanak'] = qty.toString();
          bind['status'] = 'draft';
          bind['avto'] = editTruck.text;
          bind['line'] = pr.prLine;
          bind['partner'] = editReceipant.text;
          String insertSql = Sql.insert('Docs', bind);
          await HttpSqlQuery.post({'sl': insertSql});
        }
      }
    }
    return err;
  }

  void open(String docNum) {
    HttpSqlQuery.post({'sl':"select pd.brand, pd.Model, pd.PatverN, pd.Colore, pd.variant_prod, pd.country, a.pat_mnac, d.qanak from Docs d "
        + "left join Apranq a on a.apr_id=d.apr_id left join patver_data pd on pd.id=a.pid where d.docnum='$docNum' "}).then((value) {
      for (var e in value) {

      }
    });
  }
}
