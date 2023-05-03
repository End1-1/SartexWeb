import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class GridEditButton extends StatelessWidget {
  final BuildContext context;
  final Function(BuildContext, dynamic) onTap;

  GridEditButton(this.context, this.onTap, {super.key});

  final Widget editPic = SvgPicture.asset(
    'svg/edit.svg',
    width: 36,
    height: 36,
  );

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
        cursor: SystemMouseCursors.click,
        child: InkWell(
            onTap: () {
              onTap(context, 0);
            },
            child: editPic));
  }

  void edit(dynamic value) {

  }

}