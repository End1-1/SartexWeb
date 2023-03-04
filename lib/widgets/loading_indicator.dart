import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/translator.dart';

class SartexLoadingIndicator extends StatefulWidget {
  const SartexLoadingIndicator({super.key});

  @override
  State<StatefulWidget> createState() => _SartexLoadingIndicator();
}

class _SartexLoadingIndicator extends State<SartexLoadingIndicator> with TickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..addListener(() {
      setState(() {});
    });
    _controller.repeat(reverse: false);
    _controller.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String points = '';
    for (int i = 0; i < _controller.value % 4; i++) {
      points += '.';
    }
    return CircularProgressIndicator(
      value: _controller.value,
      semanticsLabel: L.tr('loading') + points,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}