import 'dart:convert';

import 'package:http/http.dart' as http;

import 'consts.dart';

class HttpSqlQuery {
  static String userForQueries = 's6100';

  static Future<String> getString(String query) async {
    return '';
  }

  static Future<String> postString(Map<String, dynamic> body, {String type = 'sql'}) async {
    try {
      body['user'] = userForQueries;
      body['sl'] = 'j,Vasil,Vasil_2023,$type,${body['sl']}';
      print('HTTP query: ${body}');
      http.Response response = await http.post(server_uri, body: body);
      print(utf8.decode(response.bodyBytes));
      return utf8.decode(response.bodyBytes);
    } catch (e) {
      return 'error: ${e.toString()}';
    }
  }

  static Future<String> getStringT({String type = 'sql'}) async {
    try {
      print('$server_uri/?user=$userForQueries&sl=j,Vasil,Vasil_2023,$type');
      http.Response response = await http.get(Uri.parse('$server_uri/?user=$userForQueries&sl=j,Vasil,Vasil_2023,$type'));
      print(utf8.decode(response.bodyBytes));
      return utf8.decode(response.bodyBytes);
    } catch (e) {
      return 'error: ${e.toString()}';
    }
  }

  static Future<String> postSave(Map<String, dynamic> body) async {
    try {
      body['user'] = userForQueries;
      body['sl'] = 'j,Vasil,Vasil_2023,save,${body['sl']}';
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
          '$server_http_address/?user=$userForQueries&sl=j,Vasil,Vasil_2023,sql,$query'));
      print(utf8.decode(response.bodyBytes));
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

  static Future<List<String>> listOf(String table, String column) async {
    var query = 'select $column from $table order by 1';
    http.Response response = await http.get(Uri.parse(
        '$server_http_address/?user=$userForQueries&sl=j,Vasil,Vasil_2023,sql,$query'));
    print(utf8.decode(response.bodyBytes));
    List<String> l = [];
    jsonDecode(utf8.decode(response.bodyBytes)).forEach((k) {
      k.forEach((k1, v1) => l.add(v1));
    });
    return l;
  }

  static Future<List<String>> listOfQuery(String query) async {
    http.Response response = await http.get(Uri.parse(
        '$server_http_address/?user=$userForQueries&sl=j,Vasil,Vasil_2023,sql,$query'));
    print(utf8.decode(response.bodyBytes));
    List<String> l = [];
    jsonDecode(utf8.decode(response.bodyBytes)).forEach((k) {
      k.forEach((k1, v1) => l.add(v1));
    });
    return l;
  }

  static Future<List<String>> listDistinctOf(String table, String column) async {
    var query = 'select distinct($column)  from $table where $column is not null order by 1';
    http.Response response = await http.get(Uri.parse(
        '$server_http_address/?user=$userForQueries&sl=j,Vasil,Vasil_2023,sql,$query'));
    print(utf8.decode(response.bodyBytes));
    List<String> l = [];
    jsonDecode(utf8.decode(response.bodyBytes)).forEach((k) {
      k.forEach((k1, v1) => l.add(v1));
    });
    return l;
  }
}
