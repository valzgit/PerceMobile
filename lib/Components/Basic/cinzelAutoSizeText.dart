import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class CinzelAutoSizeText extends StatelessWidget {
  final String displayText;
  final FontWeight fontWeight;
  final Color color;
  final double fontSize;

  const CinzelAutoSizeText({
    Key key,
    this.displayText,
    this.fontWeight,
    this.color,
    this.fontSize
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AutoSizeText(
      displayText,
      style: TextStyle(
        color: color==null ? Colors.black : color,
        fontWeight: fontWeight,
        fontFamily: 'Cinzel',
        fontSize: fontSize
      ),
    );
  }
}
