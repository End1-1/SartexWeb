import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:sartex/screen/preloading/preloading_size.dart';
import 'package:sartex/utils/consts.dart';
import 'package:sartex/utils/http_sql.dart';
import 'package:sartex/utils/prefs.dart';
import 'package:sartex/utils/text_editing_controller.dart';
import 'package:sartex/utils/translator.dart';

List<String> Lines = [
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

class ProductionItem {
  final editBrand = STextEditingController();
  final editModel = STextEditingController();
  final editCommesa = STextEditingController();
  final editCountry = STextEditingController();
  final editColor = STextEditingController();
  final editVariant = STextEditingController();
  final List<String> brandLevel = [];
  final List<String> modelLevel = [];
  final List<String> commesaLevel = [];
  final List<String> countryLevel = [];
  final List<String> colorLevel = [];
  final List<String> variantLevel = [];
  final preSize = PreloadingSize();

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
    TextEditingController(),
    TextEditingController(),
    //total
    TextEditingController(text: L.tr('Total')),
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
    TextEditingController(),
    TextEditingController(),
    //total
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
    TextEditingController(),
    TextEditingController(),
    //total
    TextEditingController(),
  ];
  final List<TextEditingController> pahest = [
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
    TextEditingController(),
    TextEditingController(),
    //total
    TextEditingController(),
  ];

  ProductionItem() {
    HttpSqlQuery.post({
      "sl":
          "select distinct(pd.brand) from Apranq a left join patver_data pd on pd.id=a.pid where pd.status='inProgress'"
    }).then((value) {
      brandLevel.clear();
      for (var e in value) {
        brandLevel.add(e['brand']);
      }
    });
  }

  Future<void> buildModelLevel(String brand) async {
    HttpSqlQuery.post({
      "sl":
          "select distinct(pd.Model) from Apranq a left join patver_data pd on pd.id=a.pid where pd.status='inProgress' and brand='$brand'"
    }).then((value) {
      modelLevel.clear();
      for (var e in value) {
        modelLevel.add(e['Model']);
      }
    });
  }

  Future<void> buildCommesaLevel(String brand, String model) async {
    var value = await HttpSqlQuery.post({
      "sl":
          "select distinct(pd.PatverN) from Apranq a left join patver_data pd on pd.id=a.pid where pd.status='inProgress' and brand='$brand' and Model='$model'"
    });
    commesaLevel.clear();
    for (var e in value) {
      commesaLevel.add(e['PatverN']);
    }
  }

  Future<void> buildCountryLevel(
      String brand, String model, String commesa) async {
    var value = await HttpSqlQuery.post({
      "sl":
          "select distinct(pd.country) from Apranq a left join patver_data pd on pd.id=a.pid where pd.status='inProgress' and brand='$brand' and Model='$model' and PatverN='$commesa'"
    });
    countryLevel.clear();
    for (var e in value) {
      countryLevel.add(e['country']);
    }
  }

  Future<void> buildColorLevel(
      String brand, String model, String commesa, String country) async {
    var value = await HttpSqlQuery.post({
      "sl": "select distinct(pd.Colore) from Apranq a left join patver_data pd on pd.id=a.pid where pd.status='inProgress' " +
          "and brand='$brand' and Model='$model' and PatverN='$commesa' and country='$country'"
    });
    colorLevel.clear();
    for (var e in value) {
      colorLevel.add(e['Colore']);
    }
  }

  Future<void> buildVariantLevel(String brand, String model, String commesa,
      String country, String color) async {
    var value = await HttpSqlQuery.post({
      "sl": "select distinct(pd.variant_prod) from Apranq a left join patver_data pd on pd.id=a.pid where pd.status='inProgress' " +
          "and brand='$brand' and Model='$model' and PatverN='$commesa' and Colore='$color' and country='$country'"
    });
    variantLevel.clear();
    for (var e in value) {
      variantLevel.add(e['variant_prod']);
    }
  }

  Future<void> getSizes(String brand, String model, String commesa,
      String country, String color, String variant) async {
    List<dynamic> l = await HttpSqlQuery.post({
      "sl": "select pd.size_standart, pd.id from Apranq a left join patver_data pd on pd.id=a.pid where pd.status='inProgress' " +
          "and brand='$brand' and Model='$model' and PatverN='$commesa' and country='$country' and Colore='$color' and variant_prod='$variant'"
    });
    String sizeStandart = '';
    String pid = '';
    if (l.isNotEmpty) {
      Map<String, dynamic> m = l[0];
      sizeStandart = m['size_standart'];
      pid = m['id'];
    }
    l = await HttpSqlQuery.post(
        {'sl': "select * from Sizes where code='$sizeStandart'"});
    for (int i = 1; i < 13; i++) {
      sizes[i - 1].text = l[0]['size${i.toString().padLeft(2, '0')}'];
    }
    l = await HttpSqlQuery.post({
      "sl":
          "select a.apr_id, m.mnacord as pahest_mnac, a.patver as pat_mnac, a.size_number from Apranq a left join Mnacord m on m.apr_id=a.apr_id where pid='$pid'"
    });
    for (var e in l) {
      int index = int.tryParse(
              e['size_number'].substring(e['size_number'].length - 2)) ??
          -1;
      index--;
      preSize!.aprId[index] = e['apr_id'];
      preSize!.size[index] = e['pat_mnac'] ?? '0';
      remains[index].text = e['pat_mnac'] ?? '0';
      pahest[index].text = e['pahest_mnac'] ?? '0';
    }
    l = await HttpSqlQuery.post({
      "sl":
      "select a.apr_id, a.patver as pat_mnac, a.size_number, sum(pr.LineQanak) as LineQanak from Production pr left join Apranq a on pr.apr_id=a.apr_id  where pid='$pid' group by 1"
    });
    for (var e in l) {
      int index = int.tryParse(
          e['size_number'].substring(e['size_number'].length - 2)) ??
          -1;
      index--;
      remains[index].text = ((int.tryParse(remains[index].text) ?? 0) - (int.tryParse(e['LineQanak']) ?? 0)).toString();
    }
    remains[remains.length - 1].text = sumOfMnacord();
    pahest[pahest.length - 1].text = sumOfPahest();
  }

  String sumOfList(List<TextEditingController> l) {
    int total = 0;
    for (int i = 0; i < l.length - 1; i++) {
      total += int.tryParse(l[i].text) ?? 0;
    }
    return total.toString();
  }

  String sumOfMnacord() {
    return sumOfList(remains);
  }

  String sumOfPahest() {
    return sumOfList(pahest);
  }

  String sumOfNewValues() {
    return sumOfList(newvalues);
  }

  void clearAfterBrand() {
    modelLevel.clear;
    editModel.clear();
    clearAfterModel();
  }

  void clearAfterModel() {
    commesaLevel.clear();
    editCommesa.clear();
    clearAfterCommesa();
  }

  void clearAfterCommesa() {
    countryLevel.clear();
    editCountry.clear();
    clearAfterCountry();
  }

  void clearAfterCountry() {
    colorLevel.clear();
    editColor.clear();
    clearAfterColor();
  }

  void  clearAfterColor() {
    variantLevel.clear();
    editVariant.clear();
    clearAfterVariant();
  }

  void clearAfterVariant() {
    for (int i = 0; i < 13; i++) {
      sizes[i].clear();
      remains[i].clear();
      newvalues[i].clear();
    }
  }
}

class ProductionLine {
  String name = '';
  final List<ProductionItem> items = [];

  ProductionLine() {}
}

class ProductionModel {
  final editDate = TextEditingController();
  final editDocN = TextEditingController();
  final StreamController linesController = StreamController();
  final List<ProductionLine> lines = [];

  ProductionModel() {}

  Future<String> save() async {
    String err = '';
    bool totalEmpty = false;
    bool lineName = false;
    if (editDate.text.isEmpty) {
      err += '${L.tr('Select date')}\r\n';
    }
    for (var e in lines) {
      if (!lineName && e.name.isEmpty) {
        lineName = true;
        err += '${L.tr('Select line')}\r\n';
      }
      for (var f in e.items) {
        if (!totalEmpty && (int.tryParse(f.sumOfNewValues()) ?? 0) == 0) {
          totalEmpty = true;
          err += '${L.tr('Check quantity')}\r\n';
        }
      }
    }
    if (err.isNotEmpty) {
      return err;
    }
    late List<dynamic> l;
    String date = DateFormat('yyyy-MM-dd')
        .format(DateFormat('dd/MM/yyyy').parse(editDate.text));
    for (var e in lines) {
      for (var f in e.items) {
        for (int i = 0; i < 12; i++) {
          if (f.newvalues[i].text.isNotEmpty) {
            await HttpSqlQuery.post({
              'sl': "insert into Production (branch, date, line, apr_id, LineQanak, RestQanak) values (" +
                  "'${prefs.getString(key_user_branch)}', '$date', '${e.name}', '${f.preSize.aprId[i]}', '${f.newvalues[i].text}', '${f.newvalues[i].text}')"
            });
          }
        }
      }
    }
    return err;
  }
}
