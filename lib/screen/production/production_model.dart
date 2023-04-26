import 'dart:async';
import 'dart:html';

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
  String name = '';
  final bool canEditModel;
  var canEditQty = true;
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
  final List<TextEditingController> oldvalues = [
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
  final List<TextEditingController> restQanak = [
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
  final List<TextEditingController> oldRestQanak = [
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

  ProductionItem(this.canEditModel, this.name) {
    if (canEditModel) {
      canEditQty = false;
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
  }

  Future<void> buildModelLevel(String brand) async {
    if (!canEditModel) {
      return;
    }
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
    if (!canEditModel) {
      return;
    }
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
    if (!canEditModel) {
      return;
    }
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
    if (!canEditModel) {
      return;
    }
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
    if (!canEditModel) {
      return;
    }
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
    if (!canEditModel) {
      return;
    }
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
          "select a.apr_id, m.mnacord as pahest_mnac, a.patver-coalesce(pr.LineQanak, 0) as pat_mnac, a.size_number from Apranq a left join Mnacord m on m.apr_id=a.apr_id left join (select apr_id, sum(LineQanak) as LineQanak from Production group by 1) as pr on pr.apr_id=a.apr_id where pid='$pid'"
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
      "select a.apr_id, a.patver as pat_mnac, a.size_number, sum(pr.LineQanak) as LineQanak, sum(pr.RestQanak) as RestQanak from Production pr left join Apranq a on pr.apr_id=a.apr_id  where pid='$pid' group by 1"
    });
    for (var e in l) {
      int index = int.tryParse(
          e['size_number'].substring(e['size_number'].length - 2)) ??
          -1;
      index--;
      remains[index].text = ((int.tryParse(remains[index].text) ?? 0) - (int.tryParse(e['LineQanak']) ?? 0)).toString();
      restQanak[index].text = ((int.tryParse(e['RestQanak']) ?? 0)).toString();
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

  bool error(int index) {
    if (canEditModel) {
      return false;
    } else {
      if (canEditQty) {
        if (index == 12) {
          return false;
        }
        int diff = (int.tryParse(oldvalues[index].text) ?? 0) - (int.tryParse(newvalues[index].text) ?? 0);
        if (diff > (int.tryParse(restQanak[index].text) ?? 0)) {
          return true;
        }

      }
    }
    return false;
  }

  Future<void> save() async {
      for (int i = 0; i < 12; i++) {
        if (preSize.prodId[i].isEmpty) {
          // if (newvalues[i].text.isNotEmpty) {
          //   await HttpSqlQuery.post({
          //     'sl': "insert into Production (branch, date, line, apr_id, LineQanak, RestQanak) values (" +
          //         "'${prefs.getString(key_user_branch)}', '${DateFormat('yyyy-MM-dd').format(DateTime.now())}', '$name', '${preSize.aprId[i]}', '${newvalues[i]
          //             .text}', '${newvalues[i].text}')"
          //   });
          // }
        } else {
          int diff = (int.tryParse(oldvalues[i].text) ?? 0) - (int.tryParse(newvalues[i].text) ?? 0);
          await HttpSqlQuery.post({'sl': "update Production set LineQanak=LineQanak-$diff, RestQanak=RestQanak-$diff where id='${preSize.prodId[i]}'"});
        }
      }

  }

}

class ProductionLine {
  String name = '';
  final List<ProductionItem> items = [];

  ProductionLine() {}
}

class ProductionModel {
  final StreamController linesController = StreamController.broadcast();
  final ProductionLine lines = ProductionLine();

  ProductionModel({required String line}) {
    lines.name = line;
  }

  Future<String> save() async {
    String err = '';
    bool totalEmpty = false;

      for (var f in lines.items) {
        if (!totalEmpty && (int.tryParse(f.sumOfNewValues()) ?? 0) == 0) {
          totalEmpty = true;
          err += '${L.tr('Check quantity')}\r\n';
        }
      }

    if (err.isNotEmpty) {
      return err;
    }
    late List<dynamic> l;
      for (var f in lines.items) {
        for (int i = 0; i < 12; i++) {
          if (f.preSize.prodId[i].isEmpty) {
            if (f.newvalues[i].text.isNotEmpty) {
              await HttpSqlQuery.post({
                'sl': "insert into Production (branch, date, line, apr_id, LineQanak, RestQanak) values (" +
                    "'${prefs.getString(key_user_branch)}', '${DateFormat('yyyy-MM-dd').format(DateTime.now())}', '${lines
                        .name}', '${f.preSize.aprId[i]}', '${f.newvalues[i]
                        .text}', '${f.newvalues[i].text}')"
              });
            }
          } else {
            //await HttpSqlQuery.post({'sl': "update Production set LineQanak='${f.newvalues[i].text}' where id='${f.preSize.prodId[i]}'"});
          }
        }
      }

    return err;
  }

  Future<void> open() async {
    lines.items.clear();
    // List<dynamic> l = await HttpSqlQuery.post({'sl': "select pr.id as prodId, pd.brand,pd.model,pd.modelCod,pd.PatverN, pd.country, pd.Colore,pd.variant_prod, a.apr_id, a.patver as pat_mnac, a.size_number, sum(pr.LineQanak-(pr.LineQanak-pr.RestQanak)) as LineQanak, sum(pr.RestQanak) as RestQanak, a.pid from Production pr left join Apranq a on pr.apr_id=a.apr_id left join patver_data pd on pd.id=a.pid where pr.line='${lines.name}'  and pd.branch='${prefs.getString(key_user_branch)}' group by a.apr_id having sum(pr.LineQanak-(pr.LineQanak-pr.RestQanak))>0 "});
    List<dynamic> l = await HttpSqlQuery.post({'sl': "select pr.id as prodId, pd.brand,pd.model,pd.modelCod,pd.PatverN, pd.country, pd.Colore,pd.variant_prod, a.apr_id, a.patver as pat_mnac, a.size_number, sum(pr.LineQanak) as LineQanak, sum(pr.RestQanak) as RestQanak, a.pid from Production pr left join Apranq a on pr.apr_id=a.apr_id left join patver_data pd on pd.id=a.pid where pr.line='${lines.name}'  and pd.branch='${prefs.getString(key_user_branch)}' group by a.apr_id having sum(pr.LineQanak-(pr.LineQanak-pr.RestQanak))>0 "});
    Map<String, ProductionItem> pidRow = {};
    for (var e in l) {
      if (!pidRow.containsKey(e['pid'])) {
        var pi = ProductionItem(false, lines.name);
        pi.canEditQty = false;
        pi.editBrand.text = e['brand'];
        pi.editModel.text = e['model'];
        pi.editCommesa.text = e['PatverN'];
        pi.editCountry.text = e['country'];
        pi.editColor.text = e['Colore'];
        pi.editVariant.text = e['variant_prod'];
        lines.items.add(pi);

        var ll = await HttpSqlQuery.post({
          'sl': "select * from Sizes where code in (select size_standart from patver_data where id='${e['pid']}')"
        });
        if (ll.isNotEmpty) {
          for (int i = 0; i < 12; i++) {
            pi.sizes[i].text =
                ll[0]['size${(i + 1).toString().padLeft(2, '0')}'] ?? '';
          }
        }
        pidRow[e['pid']] = pi;
      } 
      var pi = pidRow[e['pid']]!;
      int index = int.tryParse(e['size_number'].substring(e['size_number'].length -  2)) ?? 0;
      pi.preSize.prodId[index] = e['prodId'];
      pi.preSize.aprId[index] = e['apr_id'];
      pi.remains[index].text = e['pat_mnac'];
      pi.newvalues[index].text = e['LineQanak'];
      pi.oldvalues[index].text = e['LineQanak'];
      pi.restQanak[index].text = e['RestQanak'];
      pi.oldRestQanak[index].text = e['RestQanak'];
    }
    for (var e in lines.items) {
      e.newvalues[e.newvalues.length - 1].text = e.sumOfNewValues();
      e.restQanak[e.restQanak.length - 1].text = e.sumOfList(e.restQanak);
      e.remains[e.remains.length - 1].text = e.sumOfList(e.remains);
      e.pahest[e.pahest.length - 1].text = e.sumOfList(e.pahest);
    }
  }
}
