import 'dart:async';

import 'dart:convert';
import 'package:sartex/screen/app/app_model.dart';
import 'package:sartex/utils/http_sql.dart';
import 'package:sartex/utils/prefs.dart';
import 'package:sartex/utils/text_editing_controller.dart';

class MessagesModel extends AppModel {
  final str = StreamController<String?>();
  final txt1 = STextEditingController();
  final txt2 = STextEditingController();
  final fontSizeController = STextEditingController();
  var enabled = false;
  var id = 0;

  @override
  createDatasource() {
    datasource = null;
  }

  @override
  String sql() {
    return "";
  }

  Future<void> getNotice() async {
    final r = await HttpSqlQuery.post({'sl':"select * from messages where branch='${prefs.branch()}'"});
    if (r.isEmpty) {
      await HttpSqlQuery.post({"sl": "insert into messages (branch, status, message) values ('${prefs.branch()}', 1, '')"});
      getNotice();
      return;
    }
    enabled = r[0]['status'] == '1';
    try {
      Map<String, dynamic> a = jsonDecode(utf8.decode(base64.decode(r[0]['message'] ?? '')));
      txt1.text = a["1"];
      txt2.text = a["2"];
      fontSizeController.text = a["fontsize"];

    }catch (e) {
      txt1.text = 'err';
      txt2.text = 'err';
    }
    fontSizeController.text = (double.tryParse(r[0]['fontsize'] ?? '0')).toString();
    id = int.tryParse(r[0]['id'] ?? '0') ?? 0;
    str.add('');
  }

  Future<void> saveNotice() async {
    Map<String, dynamic> d = {};
    d["1"] = txt1.text;
    d["2"] = txt2.text;
    d["fontsize"] = fontSizeController.text;
    String msg = base64.encode(utf8.encode(jsonEncode(d)));
    msg = base64.encode(utf8.encode(jsonEncode(d)));
    await HttpSqlQuery.post({"sl":"update messages set fontsize=${int.tryParse(fontSizeController.text) ?? 30}, message='$msg' where id=$id"});
    await getNotice();
  }

  Future<void> enableNotice() async {
    await HttpSqlQuery.post({"sl":"update messages set status='${enabled ? 0 : 1}' where id=$id"});
    await getNotice();
  }

}