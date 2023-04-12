import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:sartex/utils/http_sql.dart';
import 'package:sartex/utils/text_editing_controller.dart';

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
  final List<String> brandLevel = [];
  final List<String> modelLevel = [];
  final List<String> commesaLevel = [];
  final List<String> countryLevel = [];
  final List<String> colorLevel = [];

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

  Future<void> buildCountryLevel(String brand, String model, String commesa) async {
    var value = await HttpSqlQuery.post({
      "sl":
      "select distinct(pd.country) from Apranq a left join patver_data pd on pd.id=a.pid where pd.status='inProgress' and brand='$brand' and Model='$model' and PatverN='$commesa'"
    });
    countryLevel.clear();
    for (var e in value) {
      countryLevel.add(e['country']);
    }
  }

  Future<void> buildColorLevel(String brand, String model, String commesa, String country) async {
    var value = await HttpSqlQuery.post({
      "sl":
      "select distinct(pd.Colore) from Apranq a left join patver_data pd on pd.id=a.pid where pd.status='inProgress' " +
          "and brand='$brand' and Model='$model' and PatverN='$commesa' and country='$country'"
    });
    colorLevel.clear();
    for (var e in value) {
      colorLevel.add(e['Colore']);
    }
  }
}

class ProductionLine {
  String name = '';
  final List<ProductionItem> items = [];

  ProductionLine() {}
}

class ProductionModel {
  String? DocN;
  final editDate = TextEditingController();
  final editDocN = TextEditingController();
  final StreamController linesController = StreamController();
  final List<ProductionLine> lines = [];

  ProductionModel() {}

  Future<String> save() async {
    return '';
  }
}
