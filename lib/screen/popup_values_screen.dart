import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PopupValuesScreen extends StatelessWidget {
  final List<String> values;
  const PopupValuesScreen({super.key, required this.values});
  @override
  Widget build(BuildContext context) {
    return SimpleDialog(

      children: _list(context),
    );
  }

  List<Widget> _list(BuildContext context) {
    List<Widget> l = [];
    for (var e in values) {
      l.add(InkWell(onTap:(){
        Navigator.pop(context, e);
      }, child: Container(
        padding: const EdgeInsets.all(10),
        width: 300,
        child: Text(e, style: const TextStyle(fontSize: 18),)
      )));
    }
    return l;
  }
}