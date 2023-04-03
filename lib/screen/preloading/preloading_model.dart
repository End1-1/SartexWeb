import 'dart:convert';
import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'package:sartex/utils/http_sql.dart';

class PreloadingData {
  List<String> brandLevel = [];
  List<String> modelLevel = [];

  PreloadingData() {
    HttpSqlQuery.post({"sl":"select distinct(pd.brand) from patver_data pd where pd.status='inProgress'"}).then((value) {
      for (var e in value) {
        brandLevel.add(e['brand']);
      }
    });
  }

  void buildModelList(String brand) {
    HttpSqlQuery.post({"sl":"select distinct(pd.Model) from patver_data pd where pd.status='inProgress' and brand='$brand'"}).then((value) {
      for (var e in value) {
        modelLevel.add(e['Model']);
      }
    });
  }
}

class PreloadingItem {
  final TextEditingController brand = TextEditingController();
  final TextEditingController model = TextEditingController();
  final TextEditingController commesa = TextEditingController();
  final TextEditingController color = TextEditingController();
  final TextEditingController variant = TextEditingController();
  final TextEditingController country = TextEditingController();
}

class PreloadingFullItem {
  String prLine = '';
  List<PreloadingItem> items = [];
}

class PreloadingModel {
  final PreloadingData data = PreloadingData();
  List<String> lines = ['', 'Line1', 'Line2', 'Line3', 'Line4', 'Line5', 'Line6', 'Line7', 'Line8', 'Line9', 'Line10', 'Line11', 'Line12', 'Line13', 'Line14', 'Line15', 'Line16', 'Alex'];
  final TextEditingController editDate = TextEditingController();
  final TextEditingController editTruck = TextEditingController();
  final TextEditingController editReceipant = TextEditingController();

  //New PRELOADING
  PreloadingFullItem prLine = PreloadingFullItem();
}