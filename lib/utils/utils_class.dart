import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Utils {
  static DateTime firstDate(DateTime date) {
    return DateTime(date.year, date.month, 1);

  }

  static DateTime lastDate(DateTime date) {
    return DateTime(date.year, date.month, DateUtils.getDaysInMonth(date.year, date.month));
  }

  static String mysqlDateToHuman(String d) {
    return DateFormat('dd/MM/yyyy').format(DateFormat('yyyy-MM-dd').parse(d));
  }

  static String humanToMysqlDate(String d) {
    return DateFormat('yyyy-MM-dd').format(DateFormat('dd/MM/yyyy').parse(d));
  }
  
  static String mapKeyOfValue(Map<String, String> m, String v) {
    return m.keys.firstWhere((element) => m[element] == v) ?? '';
  }

}