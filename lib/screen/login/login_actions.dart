import 'dart:convert';
import 'dart:html';
import 'dart:io';
import 'package:http/http.dart' as http;
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

class LoginActionStartApp extends LoginAction {
  @override
  Future<void> proccesing() async {
    if (prefs.getString(key_session_id) != null &&
        prefs.getString(key_session_id)!.isNotEmpty) {
      List<Map<String, dynamic>> response = await HttpSqlQuery.get(
          'select * from Sesions where sesion_id=\'${prefs.getString(key_session_id)!}\'');
      if (response.isNotEmpty && !response[0].containsKey(key_error)) {
        state = LoginStateLoginComplete();
        return;
      }
    }
    state = LoginStateDone();
  }
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

    List<Map<String, dynamic>> userData = await HttpSqlQuery.post(map);
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
    print(userData);

    var uuid = (const Uuid().v1() + const Uuid().v1()).replaceAll("-", "");
    map['sl'] =
        'insert into Sesions (sesion_id, user_id, created, status) values '
        '(\'${uuid}\', ${userData[0]['id']}, current_timestamp(), 1);'
        'select * from Sesions where sesion_id=\'$uuid\'';
    List<Map<String,dynamic>> reply = await HttpSqlQuery.post(map);
    if (reply.isNotEmpty && reply[0].containsKey(key_error)) {
      state = SartexAppStateError(map[key_error]);
      return;
    }
    await prefs.setString(key_session_id, uuid);

    await prefs.setString(key_user_branch, userData[0]['branch']);
    await prefs.setBool(key_user_is_active, userData[0]['active'] == 'yes');
    await prefs.setString(key_user_position, userData[0]['position']);
    await prefs.setString(key_user_firstname, userData[0]['firstName']);
    await prefs.setString(key_user_lastname, userData[0]['lastName']);
    await prefs.setString(key_user_role, userData[0]['role']);
    await prefs.setString(
        key_full_name, '${userData[0]['lastName']} ${userData[0]['firstName']}');

    state = LoginStateLoginComplete();
  }
}
