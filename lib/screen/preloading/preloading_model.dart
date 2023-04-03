import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:sartex/data/data_sizes.dart';
import 'package:sartex/data/sql.dart';
import 'package:sartex/utils/consts.dart';
import 'package:sartex/utils/http_sql.dart';
import 'package:sartex/utils/prefs.dart';
import 'package:sartex/utils/translator.dart';

class PreloadingSize {
  String? aprId01;
  String? aprId02;
  String? aprId03;
  String? aprId04;
  String? aprId05;
  String? aprId06;
  String? aprId07;
  String? aprId08;
  String? aprId09;
  String? aprId10;
  String? size01;
  String? size02;
  String? size03;
  String? size04;
  String? size05;
  String? size06;
  String? size07;
  String? size08;
  String? size09;
  String? size10;

  String valueOf(int index) {
    switch (index) {
      case 1:
        return size01 ?? '0';
      case 2:
        return size02 ?? '0';
      case 3:
        return size03 ?? '0';
      case 4:
        return size04 ?? '0';
      case 5:
        return size05 ?? '0';
      case 6:
        return size06 ?? '0';
      case 7:
        return size07 ?? '0';
      case 8:
        return size08 ?? '0';
      case 9:
        return size09 ?? '0';
      case 10:
        return size10 ?? '0';
      default:
        return '-';
    }
  }

  String? actualAprId() {
    if ((int.tryParse(size01 ?? '') ?? 0) > 0) {
      return aprId01;
    }
    if ((int.tryParse(size02 ?? '') ?? 0) > 0) {
      return aprId02;
    }
    if ((int.tryParse(size03 ?? '') ?? 0) > 0) {
      return aprId03;
    }
    if ((int.tryParse(size04 ?? '') ?? 0) > 0) {
      return aprId04;
    }
    if ((int.tryParse(size05 ?? '') ?? 0) > 0) {
      return aprId05;
    }
    if ((int.tryParse(size06 ?? '') ?? 0) > 0) {
      return aprId06;
    }
    if ((int.tryParse(size07 ?? '') ?? 0) > 0) {
      return aprId07;
    }
    if ((int.tryParse(size08 ?? '') ?? 0) > 0) {
      return aprId08;
    }
    if ((int.tryParse(size09 ?? '') ?? 0) > 0) {
      return aprId09;
    }
    if ((int.tryParse(size10 ?? '') ?? 0) > 0) {
      return aprId10;
    }
    return null;
  }

  String? actualQty() {
    if ((int.tryParse(size01 ?? '') ?? 0) > 0) {
      return size01;
    }
    if ((int.tryParse(size02 ?? '') ?? 0) > 0) {
      return size02;
    }
    if ((int.tryParse(size03 ?? '') ?? 0) > 0) {
      return size03;
    }
    if ((int.tryParse(size04 ?? '') ?? 0) > 0) {
      return size04;
    }
    if ((int.tryParse(size05 ?? '') ?? 0) > 0) {
      return size05;
    }
    if ((int.tryParse(size06 ?? '') ?? 0) > 0) {
      return size06;
    }
    if ((int.tryParse(size07 ?? '') ?? 0) > 0) {
      return size07;
    }
    if ((int.tryParse(size08 ?? '') ?? 0) > 0) {
      return size08;
    }
    if ((int.tryParse(size09 ?? '') ?? 0) > 0) {
      return size09;
    }
    if ((int.tryParse(size10 ?? '') ?? 0) > 0) {
      return size10;
    }
    return null;
  }
}

class PreloadingData {
  List<String> brandLevel = [];
  List<String> modelLevel = [];
  List<String> commesaLevel = [];
  List<String> colorLevel = [];
  List<String> variantLevel = [];
  Map<String, Size> sizeStandartList = {};
  String? country;
  String? sizeStandart;
  String? aprId;
  String? pid;

  PreloadingData() {
    HttpSqlQuery.post({
      "sl":
          "select distinct(pd.brand) from patver_data pd where pd.status='inProgress'"
    }).then((value) {
      brandLevel.clear();
      for (var e in value) {
        brandLevel.add(e['brand']);
      }
    });
    HttpSqlQuery.post({'sl': 'select * from Sizes'}).then((value) {
      SizeList sl = SizeList.fromJson({'sizes': value});
      for (var e in sl.sizes) {
        sizeStandartList[e.code] = e;
      }
    });
  }

  void buildModelList(String brand) {
    HttpSqlQuery.post({
      "sl":
          "select distinct(pd.Model) from patver_data pd where pd.status='inProgress' and brand='$brand'"
    }).then((value) {
      modelLevel.clear();
      for (var e in value) {
        modelLevel.add(e['Model']);
      }
    });
  }

  void buildCommesaLevel(String brand, String model) {
    HttpSqlQuery.post({
      "sl":
          "select distinct(pd.PatverN) from patver_data pd where pd.status='inProgress' and brand='$brand' and Model='$model'"
    }).then((value) {
      commesaLevel.clear();
      for (var e in value) {
        commesaLevel.add(e['PatverN']);
      }
    });
  }

  void buildColorLevel(String brand, String model, String commesa) {
    HttpSqlQuery.post({
      "sl":
          "select distinct(pd.Colore) from patver_data pd where pd.status='inProgress' and brand='$brand' and Model='$model' and PatverN='$commesa'"
    }).then((value) {
      colorLevel.clear();
      for (var e in value) {
        colorLevel.add(e['Colore']);
      }
    });
  }

  void buildVariantLevel(
      String brand, String model, String commesa, String color) {
    HttpSqlQuery.post({
      "sl":
          "select distinct(pd.variant_prod) from patver_data pd where pd.status='inProgress' and brand='$brand' and Model='$model' and PatverN='$commesa' and Colore='$color'"
    }).then((value) {
      variantLevel.clear();
      for (var e in value) {
        variantLevel.add(e['variant_prod']);
      }
    });
  }

  Future<void> getSizesAndCountry(
      String brand, String model, String commesa, PreloadingItem s) async {
    List<dynamic> l = await HttpSqlQuery.post({
      "sl":
          "select country, size_standart, id from patver_data pd where pd.status='inProgress' and brand='$brand' and Model='$model' and PatverN='$commesa'"
    });
    if (l.isNotEmpty) {
      Map<String, dynamic> m = l[0];
      sizeStandart = m['size_standart'];
      country = m['country'];
      pid = m['id'];
    }
    l = await HttpSqlQuery.post({
      "sl": "select apr_id, pat_mnac, size_number from Apranq where pid='$pid'"
    });
    s.preSize ??= PreloadingSize();
    for (var e in l) {
      switch (e['size_number']) {
        case 'size01':
          s.preSize!.aprId01 = e['apr_id'];
          s.preSize!.size01 = e['pat_mnac'];
          s.remains[0].text = e['pat_mnac'];
          break;
        case 'size02':
          s.preSize!.aprId02 = e['apr_id'];
          s.preSize!.size02 = e['pat_mnac'];
          s.remains[1].text = e['pat_mnac'];
          break;
        case 'size03':
          s.preSize!.aprId03 = e['apr_id'];
          s.preSize!.size03 = e['pat_mnac'];
          s.remains[2].text = e['pat_mnac'];
          break;
        case 'size04':
          s.preSize!.aprId04 = e['apr_id'];
          s.preSize!.size04 = e['pat_mnac'];
          s.remains[3].text = e['pat_mnac'];
          break;
        case 'size05':
          s.preSize!.aprId05 = e['apr_id'];
          s.preSize!.size05 = e['pat_mnac'];
          s.remains[4].text = e['pat_mnac'];
          break;
        case 'size06':
          s.preSize!.aprId06 = e['apr_id'];
          s.preSize!.size06 = e['pat_mnac'];
          s.remains[5].text = e['pat_mnac'];
          break;
        case 'size07':
          s.preSize!.aprId07 = e['apr_id'];
          s.preSize!.size07 = e['pat_mnac'];
          s.remains[6].text = e['pat_mnac'];
          break;
        case 'size08':
          s.preSize!.aprId08 = e['apr_id'];
          s.preSize!.size08 = e['pat_mnac'];
          s.remains[7].text = e['pat_mnac'];
          break;
        case 'size09':
          s.preSize!.aprId09 = e['apr_id'];
          s.preSize!.size09 = e['pat_mnac'];
          s.remains[8].text = e['pat_mnac'];
          break;
        case 'size10':
          s.preSize!.aprId10 = e['apr_id'];
          s.preSize!.size10 = e['pat_mnac'];
          s.remains[9].text = e['pat_mnac'];
          break;
      }
    }
  }

  Future<void> getQuantities() async {}
}

class PreloadingItem {
  final TextEditingController brand = TextEditingController();
  final TextEditingController model = TextEditingController();
  final TextEditingController commesa = TextEditingController();
  final TextEditingController color = TextEditingController();
  final TextEditingController variant = TextEditingController();
  final TextEditingController country = TextEditingController();

  final List<TextEditingController> sizes = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
  ];
  final List<TextEditingController> remains = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
  ];
  final List<TextEditingController> newvalues = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
  ];
  final List<TextEditingController> diffvalues = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
  ];
  Size? size;
  PreloadingSize? preSize;
}

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
      err += L.tr('Date is not selected') + '\r\n';
    }
    if (editTruck.text.isEmpty) {
      err += L.tr('The truck is not selected') + '\r\n';
    }
    if (editStore.text.isEmpty) {
      err += L.tr('The store is not selected') + '\r\n';
    }
    if (editReceipant.text.isEmpty) {
      err += L.tr('The receipant is not selected') + '\r\n';
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
        String? aprid = item.preSize?.actualAprId();
        String? qty = item.preSize?.actualQty();
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
        bind['qanak'] = qty;
        bind['status'] = 'draft';
        bind['avto'] = editTruck.text;
        bind['ditox'] = pr.prLine;
        String insertSql = Sql.insert('Docs', bind);
        await HttpSqlQuery.post({'sl': insertSql});
      }
    }
    return err;
  }
}
