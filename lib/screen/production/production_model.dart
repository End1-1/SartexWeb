import 'dart:async';

import 'package:flutter/cupertino.dart';

List<String> Lines = [
  '',
  'Line1',
  'Line2',
  'Line3',
  'Line4',
  'Line5',
  'Line6',
  'Line7',
  'Line8',
  'Line9',
  'Line10',
  'Line11',
  'Line12',
  'Line13',
  'Line14',
  'Line15',
  'Line16',
  'Alex'
];

class ProductionLine {
  String name = '';
}

class ProductionModel {
  String? DocN;
  final editDate = TextEditingController();
  final editDocN = TextEditingController();
  final StreamController linesController = StreamController();
  final List<ProductionLine> lines = [];

  Future<String> save() async {
    return '';
  }
}