import 'package:flutter/material.dart';

class CommonText extends StatelessWidget {
  final String text;
  final Color color;
  final FontWeight fontWeight;
  final double fontSize;
  final TextAlign textAlign;
  final int maxLines;
  final double? lineHeight;

  const CommonText({
    Key? key,
    required this.text,
    this.color = Colors.white,
    this.fontWeight = FontWeight.normal,
    required this.fontSize,
    this.textAlign = TextAlign.center,
    this.maxLines = 1,
    this.lineHeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        color: color,
        fontWeight: fontWeight,
        fontSize: fontSize,
        height: lineHeight,
      ),
    );
  }
}
