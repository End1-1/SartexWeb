import 'package:sartex/data/sql.dart';

import '../utils/http_sql.dart';

class DataSet {

  int _skip = 0;
  int _count = 100;
  late List<List<dynamic>> _data;

  void addData(Map<String, dynamic> data) {
    //_data.addAll(data);
  }
}