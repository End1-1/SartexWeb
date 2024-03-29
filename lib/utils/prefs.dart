import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

import 'consts.dart';

extension Prefs on SharedPreferences {
  setRoleAction(String action, String read, String write) {
    setString('$key_role + $action + read', read);
    setString('$key_role + $action + write', write);
  }

  resetRoles() {
    final Map<String, Map<String, String>> rm = {};
    rm.addAll(roleMap);
    rm.forEach((key, value) {setRoleAction(key, '0', '0');});
  }

  bool roleRead(String action) {
    String value = getString('$key_role + $action + read') ?? '0';
    return value == '1';
  }

  bool roleWrite(String action) {
    String value = getString('$key_role + $action + write') ?? '0';
    return value == '1';
  }

  bool roleSuperAdmin() {
    return roleRead('9') || roleWrite('9');
  }

  String branch() {
    return getString(key_user_branch)!;
  }

  String session() {
    String? s = getString(key_session_id);
    if (s == null) {
      return _generateSession();
    }
    return s;
  }

  String _generateSession() {
    setString(key_session_id, Uuid().v1());
    return getString(key_session_id)!;
  }

  double readDirectoriesCount() {
    double c = 0;
    if (roleRead("5")) {
      c++;
    }
    if (roleRead("6")) {
      c++;
    }
    if (roleRead("7")) {
      c+= 5;
    }
    return c;
  }

}

late final SharedPreferences prefs;

