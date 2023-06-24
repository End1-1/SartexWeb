import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sartex/utils/consts.dart';
import 'package:sartex/utils/http_sql.dart';
import 'package:sartex/utils/prefs.dart';
import 'package:sartex/utils/text_editing_controller.dart';
import 'package:sartex/utils/translator.dart';
import 'package:uuid/uuid.dart';

class LoginPinScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginPinScreen();
}

class _LoginPinScreen extends State<LoginPinScreen> {
  final pinController = STextEditingController();
  var errorString = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(
          height: 20,
        ),
        Visibility(visible: errorString.isNotEmpty, child: Text(errorString)),
        const SizedBox(height: 20),
        Container(
            width: 200,
            child: TextFormField(
              maxLines: 1,
              controller: pinController,
            )),
        const SizedBox(height: 20),
        Container(
            height: 500,
            width: 200,
            child: Wrap(
              spacing: 10,
              runSpacing: 10,
              direction: Axis.horizontal,
              alignment: WrapAlignment.center,
              children: [
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                      fixedSize: const Size(40, 40),
                      side: BorderSide(color: Colors.black12)),
                  onPressed: () {
                    pint('1');
                  },
                  child: Text('1'),
                ),
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                      fixedSize: const Size(40, 40),
                      side: BorderSide(color: Colors.black12)),
                  onPressed: () {
                    pint('2');
                  },
                  child: Text('2'),
                ),
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                      fixedSize: const Size(40, 40),
                      side: BorderSide(color: Colors.black12)),
                  onPressed: () {
                    pint('3');
                  },
                  child: Text('3'),
                ),
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                      fixedSize: const Size(40, 40),
                      side: BorderSide(color: Colors.black12)),
                  onPressed: () {
                    pint('4');
                  },
                  child: Text('4'),
                ),
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                      fixedSize: const Size(40, 40),
                      side: BorderSide(color: Colors.black12)),
                  onPressed: () {
                    pint('5');
                  },
                  child: Text('5'),
                ),
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                      fixedSize: const Size(40, 40),
                      side: BorderSide(color: Colors.black12)),
                  onPressed: () {
                    pint('6');
                  },
                  child: Text('6'),
                ),
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                      fixedSize: const Size(40, 40),
                      side: BorderSide(color: Colors.black12)),
                  onPressed: () {
                    pint('7');
                  },
                  child: Text('7'),
                ),
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                      fixedSize: const Size(40, 40),
                      side: BorderSide(color: Colors.black12)),
                  onPressed: () {
                    pint('8');
                  },
                  child: Text('8'),
                ),
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                      fixedSize: const Size(40, 40),
                      side: BorderSide(color: Colors.black12)),
                  onPressed: () {
                    pint('9');
                  },
                  child: Text('9'),
                ),
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                      fixedSize: const Size(40, 40),
                      side: BorderSide(color: Colors.black12)),
                  onPressed: () {
                    pint('0');
                  },
                  child: Text('0'),
                ),
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                      fixedSize: const Size(80, 40),
                      side: BorderSide(color: Colors.black12)),
                  onPressed: () {
                    login();
                  },
                  child: Text(L.tr('Login')),
                ),
              ],
            ))
      ],
    )));
  }

  pint(String s) {
    pinController.text += s;
  }

  login() async {
    var map = <String, dynamic>{
      'sl': 'select * from Users where password=\'${pinController.text}\''
    };

    errorString = '';
    List<dynamic> userData = await HttpSqlQuery.post(map);
    if (userData.isEmpty) {
      errorString += '${L.tr('Invalid username or password')}\n';
      pinController.clear();
      setState(() {});
      return;
    }
    if (userData[0].containsKey(key_empty)) {
      errorString += '${L.tr('Invalid username or password')}\n';
      pinController.clear();
      setState(() {});
      return;
    }
    if (kDebugMode) {
      print(userData);
    }

    var uuid = (const Uuid().v1() + const Uuid().v1()).replaceAll("-", "");
    map['sl'] =
        'insert into Sesions (sesion_id, user_id, created, status) values '
        '(\'${uuid}\', ${userData[0]['id']}, current_timestamp(), 1);'
        'select * from Sesions where sesion_id=\'$uuid\'';
    List<dynamic> reply = await HttpSqlQuery.post(map);
    if (reply.isNotEmpty && reply[0].containsKey(key_error)) {
      errorString = map[key_error];
      pinController.clear();
      setState(() {});
      return;
    }
    await prefs.setString(key_session_id, uuid);

    await prefs.setInt(key_user_id, int.tryParse(userData[0]['id']) ?? 0);
    await prefs.setString(key_user_branch, userData[0]['branch']);
    await prefs.setBool(key_user_is_active, userData[0]['active'] == 'yes');
    await prefs.setString(key_user_position, userData[0]['position']);
    await prefs.setString(key_user_firstname, userData[0]['firstName']);
    await prefs.setString(key_user_lastname, userData[0]['lastName']);
    await prefs.setString(key_user_role, userData[0]['role_id'] ?? '');
    await prefs.setString(key_full_name,
        '${userData[0]['lastName']} ${userData[0]['firstName']}');
    HttpSqlQuery.userForQueries = userData[0]['user_id'];

    var result = await HttpSqlQuery.post({
      'sl': "select id from RoleNames where name='${userData[0]['role_id']}'"
    });
    if (result.isEmpty) {
      errorString = L.tr('Role not assigned');
      pinController.clear();
      return;
    }

    result = await HttpSqlQuery.post({
      'sl':
          "select action, read_flag, write_flag from RoleData where role_id=${result[0]['id']}"
    });
    for (var e in result) {
      prefs.setRoleAction(e['action'], e['read_flag'], e['write_flag']);
    }

    Navigator.pushNamedAndRemoveUntil(context, route_tv, (route) => false, arguments: true);
  }
}
