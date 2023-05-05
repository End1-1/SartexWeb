import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';

import '../../utils/consts.dart';
import '../../utils/http_sql.dart';
import '../../utils/prefs.dart';
import '../../utils/translator.dart';
import 'login_states.dart';

abstract class LoginAction {
  Future<void> proccesing();

  LoginState state = LoginStateDone();
}

class LoginActionAuth extends LoginAction {
  final String _username;
  final String _password;
  late String errorString = '';

  String get username => _username;

  String get password => _password;

  LoginActionAuth(this._username, this._password);

  @override
  Future<void> proccesing() async {
    if (_username.isEmpty) {
      errorString += '${L.tr('Username is empty')}\n';
    }
    if (_password.isEmpty) {
      errorString += '${L.tr('Password is empty')}\n';
    }
    if (errorString.isNotEmpty) {
      state = SartexAppStateError(errorString);
      return;
    }

    var map = <String, dynamic>{
      'sl':
          'select * from Users where email=\'$_username\' and password=\'$_password\''
    };

    List<dynamic> userData = await HttpSqlQuery.post(map);
    if (userData.isEmpty) {
      errorString += '${L.tr('Invalid username or password')}\n';
      state = SartexAppStateError(errorString);
      return;
    }
    if (userData[0].containsKey(key_empty)) {
      errorString += '${L.tr('Invalid username or password')}\n';
      state = SartexAppStateError(errorString);
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
      state = SartexAppStateError(map[key_error]);
      return;
    }
    await prefs.setString(key_session_id, uuid);

    await prefs.setInt(key_user_id, int.tryParse(userData[0]['id']) ?? 0);
    await prefs.setString(key_user_branch, userData[0]['branch']);
    await prefs.setBool(key_user_is_active, userData[0]['active'] == 'yes');
    await prefs.setString(key_user_position, userData[0]['position']);
    await prefs.setString(key_user_firstname, userData[0]['firstName']);
    await prefs.setString(key_user_lastname, userData[0]['lastName']);
    await prefs.setString(key_user_role, userData[0]['role']);
    await prefs.setString(
        key_full_name, '${userData[0]['lastName']} ${userData[0]['firstName']}');

    var result = await HttpSqlQuery.post({'sl': "select id from RoleNames where name='${userData[0]['role']}'"});
    if (result.isEmpty) {
      state = SartexAppStateError(L.tr('Role not assigned'));
      return;
    }

    result = await HttpSqlQuery.post({'sl': "select action, read_flag, write_flag from RoleData where role_id=${result[0]['id']}"});
    for (var e in result) {
      prefs.setRoleAction(e['action'], e['read_flag'], e['write_flag']);
    }

    state = LoginStateLoginComplete();
  }
}
