import '../utils/http_sql.dart';

class DataSet {

  int _skip = 0;
  int _count = 100;
  late List<Map<String, dynamic>> _data;

  void loadData(String query) async {
    _data = await HttpSqlQuery.post({'sl':query});
  }
}