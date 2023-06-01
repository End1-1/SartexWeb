import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sartex/utils/consts.dart';

class SvgButton extends StatelessWidget {
  final GestureTapCallback onTap;
  final String assetPath;
  final String caption;
  final bool darkMode;
  late double h;
  late double w;

  SvgButton(
      {super.key,
      required this.onTap,
      required this.assetPath,
      this.caption = "",
      this.darkMode = true,
        double width = 36.0,
        double height = 36.0,
      }) {
    h = width * scale_factor;
    w = width * scale_factor;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width:  w + (10 * scale_factor),
        padding: EdgeInsets.all(5 * scale_factor),
        child: MouseRegion(
            cursor: SystemMouseCursors.click,
            child: InkWell(
                onTap: onTap,
                child: Row(children: [
                  SizedBox(
                      height: h,
                      width: w,
                      child: SvgPicture.asset(assetPath,
                          colorFilter: darkMode
                              ? const ColorFilter.mode(
                                  Colors.white, BlendMode.srcIn)
                              : const ColorFilter.mode(
                                  Colors.black87, BlendMode.dstIn))),
                  caption.isEmpty
                      ? Container(width: 0)
                      : Text(caption,
                          style: darkMode
                              ? const TextStyle(color: Colors.white)
                              : const TextStyle(color: Colors.black87))
                ]))));
  }
}
