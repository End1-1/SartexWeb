import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SvgButton extends StatelessWidget {
  final GestureTapCallback onTap;
  final String assetPath;
  final String caption;
  final bool darkMode;
  final double height;
  final double width;

  const SvgButton(
      {super.key,
      required this.onTap,
      required this.assetPath,
      this.caption = "",
      this.darkMode = true,
      this.height = 36,
      this.width = 36});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(5),
        child: MouseRegion(
            cursor: SystemMouseCursors.click,
            child: InkWell(
                onTap: onTap,
                child: Row(children: [
                  SizedBox(
                      height: height,
                      width: width,
                      child: SvgPicture.asset(assetPath,
                          colorFilter: darkMode
                              ? const ColorFilter.mode(
                                  Colors.white, BlendMode.srcIn)
                              : const ColorFilter.mode(
                                  Colors.black87, BlendMode.dstIn))),
                  caption.isEmpty
                      ? Container()
                      : Text(caption,
                          style: darkMode
                              ? const TextStyle(color: Colors.white)
                              : const TextStyle(color: Colors.black87))
                ]))));
  }
}
