import 'package:flutter/material.dart';

class KeyValueDropDown extends StatefulWidget {
  final Map<dynamic, String> values;
  final String title;
  final dynamic initialValue;
  final Function (dynamic) onSelected;

  const KeyValueDropDown(
      {super.key,
        required this.title,
        required this.values,
        required this.initialValue,
        required this.onSelected});

  @override
  State<StatefulWidget> createState() => _KeyValueDropDown();
}

class _KeyValueDropDown extends State<KeyValueDropDown> {
  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.fromLTRB(0, 30, 0, 0), child: DropdownMenu<dynamic>(
        label: Text(widget.title),
        width: 200,
        onSelected: widget.onSelected,
        initialSelection: widget.initialValue,
        dropdownMenuEntries: widget.values.entries
            .map((e) => DropdownMenuEntry(value: e.key, label: e.value))
            .toList()));
  }
}
