import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:async';

import 'package:intl/intl.dart';
import 'package:sartex/utils/consts.dart';
import 'package:sartex/utils/http_sql.dart';
import 'package:sartex/utils/prefs.dart';
import 'package:sartex/utils/text_editing_controller.dart';

part 'plan_model.freezed.dart';

part 'plan_model.g.dart';

@freezed
class PlanRow with _$PlanRow {
  factory PlanRow(
      {required String? remain,
      required String? brand,
      required String? model,
      required String? mo,
      required String? to,
      required String? we,
      required String? th,
      required String? fr,
      required String? sa,
      required String? su,
      required String? tot,
      required String? comesa}) = _PlanRow;

  factory PlanRow.fromJson(Map<String, Object?> json) =>
      _$PlanRowFromJson(json);
}

class PlanRowEdit {
  String line = '';
  final editRemain = STextEditingController();
  final editBrand = STextEditingController();
  final editModel = STextEditingController();
  //PLAN
  final editMo = STextEditingController();
  final editTo = STextEditingController();
  final editWe = STextEditingController();
  final editTh = STextEditingController();
  final editFr = STextEditingController();
  final editSa = STextEditingController();
  final editSu = STextEditingController();
  final editTot = STextEditingController();

  //OTK
  final editMoOtk = STextEditingController();
  final editToOtk = STextEditingController();
  final editWeOtk = STextEditingController();
  final editThOtk = STextEditingController();
  final editFrOtk = STextEditingController();
  final editSaOtk = STextEditingController();
  final editSuOtk = STextEditingController();
  final editTotOtk = STextEditingController();

  final editComesa  = STextEditingController();
  final List<STextEditingController> days = [];
  final List<STextEditingController> otks = [];
  bool editMode = false;

  PlanRowEdit() {
    days.add(editMo..addListener(() {countTotal();}));
    days.add(editTo..addListener(() {countTotal();}));
    days.add(editWe..addListener(() {countTotal();}));
    days.add(editTh..addListener(() {countTotal();}));
    days.add(editFr..addListener(() {countTotal();}));
    days.add(editSa..addListener(() {countTotal();}));
    days.add(editSu..addListener(() {countTotal();}));

    otks.add(editMoOtk..addListener(() {countTotalOtk();}));
    otks.add(editToOtk..addListener(() {countTotalOtk();}));
    otks.add(editWeOtk..addListener(() {countTotalOtk();}));
    otks.add(editThOtk..addListener(() {countTotalOtk();}));
    otks.add(editFrOtk..addListener(() {countTotalOtk();}));
    otks.add(editSaOtk..addListener(() {countTotalOtk();}));
    otks.add(editSuOtk..addListener(() {countTotalOtk();}));
  }

  void countTotal() {
    String total = (
            (int.tryParse(editMo.text) ?? 0) +
            (int.tryParse(editTo.text) ?? 0) +
            (int.tryParse(editWe.text) ?? 0) +
            (int.tryParse(editTh.text) ?? 0) +
            (int.tryParse(editFr.text) ?? 0) +
            (int.tryParse(editSu.text) ?? 0) +
            (int.tryParse(editSa.text) ?? 0))
        .toString();

    String totalOtk = (
        (int.tryParse(editMoOtk.text) ?? 0) +
            (int.tryParse(editToOtk.text) ?? 0) +
            (int.tryParse(editWeOtk.text) ?? 0) +
            (int.tryParse(editThOtk.text) ?? 0) +
            (int.tryParse(editFrOtk.text) ?? 0) +
            (int.tryParse(editSuOtk.text) ?? 0) +
            (int.tryParse(editSaOtk.text) ?? 0))
        .toString();

    editTot.text = '$total / $totalOtk';
  }

  void countTotalOtk() {
    String totalOtk = (
        (int.tryParse(editMoOtk.text) ?? 0) +
            (int.tryParse(editToOtk.text) ?? 0) +
            (int.tryParse(editWeOtk.text) ?? 0) +
            (int.tryParse(editThOtk.text) ?? 0) +
            (int.tryParse(editFrOtk.text) ?? 0) +
            (int.tryParse(editSuOtk.text) ?? 0) +
            (int.tryParse(editSaOtk.text) ?? 0))
        .toString();
  }
}

class PlanModel {
  final dateRangeController = StreamController();
  final tableHeaderController = StreamController();
  final tableDataController = StreamController.broadcast();
  DateTime date = DateTime.now();
  final List<String> lines = [];
  final Map<String, List<PlanRowEdit>> linesData = {};
  int rowOnEdit = -1;

  PlanModel() {
    int lc = prefs.branch() == 'Sartex' ? 18 : 24;
    for (int i = 0; i < lc; i++) {
      lines.add('L${i + 1}');
    }
    for (var l in lines) {
      linesData[l] = [];
    }
  }
  
  DateTime firstDate() {
    int d = date.weekday;
    return date.add(Duration(days: -1 * (d - 1)));
  }
  
  DateTime endDate() {
    int d = date.weekday;
    return date.add(Duration(days: 7 - d));
  }

  DateTime dateOfWeekDay(int day) {
    return firstDate().add(Duration(days: day - 1));
  }

  String weekRange() {
    return '${DateFormat('dd/MM/yyyy').format(firstDate())} - ${DateFormat('dd/MM/yyyy').format(endDate())}';
  }

  String dayOfRange(int i) {
    return DateFormat('dd/MM').format(dateOfWeekDay(i));
  }
  
  Future<String> getPlanIdForDate(DateTime d, String line, String model, String brand) async {
      var e = await HttpSqlQuery.post({'sl': "select id from Plan where plan>0 and date='${DateFormat('yyyy-MM-dd').format(d)}' "
          "and model='$model' and brand='$brand' and line='$line' and branch='${prefs.getString(key_user_branch)}'"});
      if (e.isEmpty) {
        return '';
      }
      return e[0]['id'];
  }
  
  Future<void> savePlan(PlanRowEdit e) async {
    String id = await getPlanIdForDate(dateOfWeekDay(1), e.line, e.editModel.text, e.editBrand.text);
    int qty = int.tryParse(e.editMo.text) ?? 0;
    int otk = int.tryParse(e.editMoOtk.text) ?? 0;
    if (id.isEmpty) {
      await HttpSqlQuery.post({'sl':"insert into Plan (branch, line, date, brand, model, plan, comesa, otk) values ('${prefs.getString(key_user_branch)}', "
          "'${e.line}', '${DateFormat('yyyy-MM-dd').format(dateOfWeekDay(1))}', '${e.editBrand.text}', '${e.editModel.text}', $qty, '${e.editComesa.text}', $otk)"});
    } else {
      await HttpSqlQuery.post({'sl':"update Plan set plan=$qty, otk=$otk, comesa='${e.editComesa.text}' where id=$id"});
    }

    id = await getPlanIdForDate(dateOfWeekDay(2),  e.line, e.editModel.text, e.editBrand.text);
    qty = int.tryParse(e.editTo.text) ?? 0;
    otk = int.tryParse(e.editToOtk.text) ?? 0;
    if (id.isEmpty) {
      await HttpSqlQuery.post({'sl':"insert into Plan (branch, line, date,brand, model, plan, comesa, otk) values ('${prefs.getString(key_user_branch)}', "
          "'${e.line}', '${DateFormat('yyyy-MM-dd').format(dateOfWeekDay(2))}', '${e.editBrand.text}', '${e.editModel.text}', $qty, '${e.editComesa.text}', $otk)"});
    } else {
      await HttpSqlQuery.post({'sl':"update Plan set plan=$qty, comesa='${e.editComesa.text}', otk=$otk where id=$id"});
    }

    id = await getPlanIdForDate(dateOfWeekDay(3),  e.line, e.editModel.text, e.editBrand.text);
    qty = int.tryParse(e.editWe.text) ?? 0;
    otk = int.tryParse(e.editWeOtk.text) ?? 0;
    if (id.isEmpty) {
      await HttpSqlQuery.post({'sl':"insert into Plan (branch, line, date, brand, model, plan, comesa, otk) "
          "values ('${prefs.getString(key_user_branch)}', '${e.line}', '${DateFormat('yyyy-MM-dd').format(dateOfWeekDay(3))}', "
          "'${e.editBrand.text}', '${e.editModel.text}', $qty, '${e.editComesa.text}', $otk)"});
    } else {
      await HttpSqlQuery.post({'sl':"update Plan set plan=$qty, comesa='${e.editComesa.text}', otk=$otk where id=$id"});
    }

    id = await getPlanIdForDate(dateOfWeekDay(4),  e.line, e.editModel.text, e.editBrand.text);
    qty = int.tryParse(e.editTh.text) ?? 0;
    otk = int.tryParse(e.editThOtk.text) ?? 0;
    if (id.isEmpty) {
      await HttpSqlQuery.post({'sl':"insert into Plan (branch, line, date, brand, model, plan, comesa, otk) "
          "values ('${prefs.getString(key_user_branch)}', '${e.line}', '${DateFormat('yyyy-MM-dd').format(dateOfWeekDay(4))}', "
          "'${e.editBrand.text}', '${e.editModel.text}', $qty, '${e.editComesa.text}', $otk)"});
    } else {
      await HttpSqlQuery.post({'sl':"update Plan set plan=$qty, comesa='${e.editComesa.text}', otk=$otk where id=$id"});
    }

    id = await getPlanIdForDate(dateOfWeekDay(5),  e.line, e.editModel.text, e.editBrand.text);
    qty = int.tryParse(e.editFr.text) ?? 0;
    otk = int.tryParse(e.editFrOtk.text) ?? 0;
    if (id.isEmpty) {
      await HttpSqlQuery.post({'sl':"insert into Plan (branch, line, date, brand, model, plan, comesa, otk) "
          "values ('${prefs.getString(key_user_branch)}', '${e.line}', '${DateFormat('yyyy-MM-dd').format(dateOfWeekDay(5))}', '${e.editBrand.text}', "
          "'${e.editModel.text}', $qty, '${e.editComesa.text}', $otk)"});
    } else {
      await HttpSqlQuery.post({'sl':"update Plan set plan=$qty, comesa='${e.editComesa.text}', otk=$otk where id=$id"});
    }

    id = await getPlanIdForDate(dateOfWeekDay(6),  e.line, e.editModel.text, e.editBrand.text);
    qty = int.tryParse(e.editSa.text) ?? 0;
    otk = int.tryParse(e.editSaOtk.text) ?? 0;
    if (id.isEmpty) {
      await HttpSqlQuery.post({'sl':"insert into Plan (branch, line, date, brand, model, plan, comesa, otk) "
          "values ('${prefs.getString(key_user_branch)}', '${e.line}', '${DateFormat('yyyy-MM-dd').format(dateOfWeekDay(6))}', '${e.editBrand.text}', "
          "'${e.editModel.text}', $qty, '${e.editComesa.text}', $otk)"});
    } else {
      await HttpSqlQuery.post({'sl':"update Plan set plan=$qty, comesa='${e.editComesa.text}', otk=$otk where id=$id"});
    }

    id = await getPlanIdForDate(dateOfWeekDay(7),  e.line, e.editModel.text, e.editBrand.text);
    qty = int.tryParse(e.editSu.text) ?? 0;
    otk = int.tryParse(e.editSuOtk.text) ?? 0;
    if (id.isEmpty) {
      await HttpSqlQuery.post({'sl':"insert into Plan (branch, line, date, brand, model, plan, comesa, otk) "
          "values ('${prefs.getString(key_user_branch)}', '${e.line}', '${DateFormat('yyyy-MM-dd').format(dateOfWeekDay(7))}', '${e.editBrand.text}', "
          "'${e.editModel.text}', $qty, '${e.editComesa.text}', $otk)"});
    } else {
      await HttpSqlQuery.post({'sl':"update Plan set plan=$qty, comesa='${e.editComesa.text}', otk=$otk where id=$id"});
    }
  }

  Future<void> open() async {
    var l = await HttpSqlQuery.post({
      'sl':
          "select pd.brand, pd.model, pr.line, sum(pr.RestQanak) as RestQanak "
              "from Production pr "
              "left join Apranq a on pr.apr_id=a.apr_id "
              "left join patver_data pd on pd.id=a.pid "
              "where pd.branch='${prefs.getString(key_user_branch)}'  "
              "group by 1, 2, 3 having sum(pr.RestQanak)>0"
    });
    for (var e in linesData.values) {
      e.clear();
    }
    for (var e in l) {
      PlanRowEdit pr = PlanRowEdit();
      pr.editRemain.text = e['RestQanak'];
      pr.editBrand.text = e['brand'];
      pr.editModel.text = e['model'];
      pr.line = e['line'];
      if (!linesData.containsKey(e['line'])) {
        linesData[e['line']] = [];
      }
      linesData[e['line']]!.add(pr);
    }
  }

  Future<void> loadQty() async {
    linesData.forEach((key, value) {
      for (var e in value) {
        e.editMo.clear();
        e.editTo.clear();
        e.editWe.clear();
        e.editTh.clear();
        e.editFr.clear();
        e.editSa.clear();
        e.editSu.clear();

        e.editMoOtk.clear();
        e.editToOtk.clear();
        e.editWeOtk.clear();
        e.editThOtk.clear();
        e.editFrOtk.clear();
        e.editSaOtk.clear();
        e.editSuOtk.clear();

        e.editComesa.clear();
      }
    });
    var l = await HttpSqlQuery.post({'sl': " select brand, model, plan, date, line, comesa, coalesce(otk, 0) as otk "
        "from Plan "
        "where plan>0 and branch='${prefs.getString(key_user_branch)}' "
        "and date between '${DateFormat('yyyy-MM-dd').format(firstDate())}' and '${DateFormat('yyyy-MM-dd').format(endDate())}'"});
    for (var e in l) {
      List<PlanRowEdit>? prl = linesData[e['line']];
      if (prl == null) {
        continue;
      }
      for (var pr in prl) {
        if ((pr.editModel.text == e['model']) && (pr.editBrand.text == e['brand'])) {
          pr.editComesa.text = e['comesa'];
          STextEditingController? t;
          STextEditingController? to;
          switch (DateFormat('yyyy-MM-dd').parse(e['date']).weekday) {
            case 1:
              t = pr.editMo;
              to = pr.editMoOtk;
              break;
            case 2:
              t = pr.editTo;
              to = pr.editToOtk;
              break;
            case 3:
              t = pr.editWe;
              to = pr.editWeOtk;
              break;
            case 4:
              t = pr.editTh;
              to = pr.editThOtk;
              break;
            case 5:
              t = pr.editFr;
              to = pr.editFrOtk;
              break;
            case 6:
              t = pr.editSa;
              to = pr.editSaOtk;
              break;
            case 7:
              t = pr.editSu;
              to = pr.editSuOtk;
              break;
          }
          if (t != null) {
            t.text = e['plan'];
          }
          if (to !=  null) {
            to.text = e['otk'];
          }
        }
      }
    }
  }
}
