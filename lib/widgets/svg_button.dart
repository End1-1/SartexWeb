import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SvgButton extends StatelessWidget {
  final GestureTapCallback onTap;
  final String assetPath;
  final String caption;
  final bool darkMode;

  const SvgButton(
      {super.key,
      required this.onTap,
      required this.assetPath,
      this.caption = "",
      this.darkMode = true});

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
                      height: 36,
                      width: 36,
                      child: SvgPicture.asset(assetPath,
                          colorFilter: darkMode
                              ? const ColorFilter.mode(
                                  Colors.white, BlendMode.srcIn)
                              : const ColorFilter.mode(
                                  Colors.black87, BlendMode.srcIn))),
                  caption.isEmpty
                      ? Container()
                      : Text(caption,
                          style: darkMode
                              ? const TextStyle(color: Colors.white)
                              : const TextStyle(color: Colors.black87))
                ]))));
  }
}
