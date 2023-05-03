import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextMouseButton extends StatelessWidget {
  final GestureTapCallback onTap;
  final String caption;

  const TextMouseButton({super.key, required this.onTap, required this.caption});

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: InkWell(
          onTap: onTap,
          child: Text(caption, maxLines: 1, overflow: TextOverflow.clip, style: const TextStyle(color: Colors.white))
        ),
      )
    );
  }

}