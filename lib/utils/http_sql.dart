import 'dart:convert';

import 'package:http/http.dart' as http;

import 'consts.dart';

class HttpSqlQuery {
  static const String _user = 's6100';

  static Future<Map<String,dynamic>> get(String query) async {
    try {
      print('HTTP query: $query');
      http.Response response = await http.get(Uri.parse(
          '$server_http_address/?user=$_user&sl=j,Vasil,Vasil_2023,sql,$query'));
      print(response.body);
      return jsonDecode(response.body)[0];
    } catch (e) {
      return <String, dynamic>{key_error: e.toString()};
    }
  }

  static Future<Map<String, dynamic>> post(Map<String, dynamic> body) async {
    try {
      Map<String, dynamic> result = <String, dynamic>{};
      body['user'] = _user;
      body['sl'] = 'j,Vasil,Vasil_2023,sql,${body['sl']}';
      print('HTTP query: ${body}');
      http.Response response = await http.post(server_uri, body: body);
      var vals = jsonDecode(response.body);
      if (vals.isEmpty) {
        result[key_empty] = true;
      } else {
        result = vals[0];
      }
      return result;
    } catch (e) {
      return <String, dynamic>{key_error: e.toString()};
    }
  }
}