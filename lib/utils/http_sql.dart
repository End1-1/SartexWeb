import 'dart:convert';

import 'package:http/http.dart' as http;

import 'consts.dart';

class HttpSqlQuery {
  static const String _user = 's6100';

  static Future<List<Map<String,dynamic>>> get(String query) async {
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

  static Future<List<Map<String, dynamic>>> post(Map<String, dynamic> body) async {
    try {
      body['user'] = _user;
      body['sl'] = 'j,Vasil,Vasil_2023,sql,${body['sl']}';
      print('HTTP query: ${body}');
      http.Response response = await http.post(server_uri, body: body);
      return jsonDecode(response.body);
    } catch (e) {
      return []..add(<String, dynamic>{key_error: e.toString()});
    }
  }
}