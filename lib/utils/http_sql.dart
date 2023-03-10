import 'dart:convert';

import 'package:http/http.dart' as http;

import 'consts.dart';

class HttpSqlQuery {
  static const String _user = 's6100';

  static Future<String> getString(String query) async {
    return '';
  }

  static Future<String> postString(Map<String, dynamic> body) async {
    try {
      body['user'] = _user;
      body['sl'] = 'j,Vasil,Vasil_2023,sql,${body['sl']}';
      print('HTTP query: ${body}');
      http.Response response = await http.post(server_uri, body: body);
      print(utf8.decode(response.bodyBytes));
      return utf8.decode(response.bodyBytes);
    } catch (e) {
      return 'error: ${e.toString()}';
    }
  }

  static Future<List<dynamic>> get(String query) async {
    try {
      print('HTTP query: $query');
      http.Response response = await http.get(Uri.parse(
          '$server_http_address/?user=$_user&sl=j,Vasil,Vasil_2023,sql,$query'));
      print(response.body);
      return jsonDecode(response.body);
    } catch (e) {
      return []..add(<String, dynamic>{key_error: e.toString()});
    }
  }

  static Future<List<dynamic>> post(Map<String, dynamic> body) async {
    try {
      String r = await postString(body);
      return jsonDecode(r);
    } catch (e) {
      return []..add(<String, dynamic>{key_error: e.toString()});
    }
  }
}