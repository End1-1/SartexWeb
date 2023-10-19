import 'package:flutter/cupertino.dart';
import 'package:sartex/screen/app/app_model.dart';
import 'package:sartex/utils/consts.dart';
import 'package:sartex/utils/http_sql.dart';

class ReturnModel extends AppModel {
  final Map<String, TextEditingController> tc = {};

  ReturnModel() {
    for (final e in PLines['Itex']!) {
      tc[e] = TextEditingController();
    }
  }

  @override
  createDatasource() {
    datasource = null;
  }

  @override
  String sql() {
    return "";
  }

  Future<void> saveReturning() async {
    tc.forEach((key, value) async {
      await HttpSqlQuery.post({"sl": "update tvadd set cnt='${value.text}' where line='${key}'"});
    });
  }

}