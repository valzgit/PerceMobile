import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class CinzelText extends StatelessWidget {
  final String displayText;
  final FontWeight fontWeight;
  final double fontSize;
  final Color color;

  const CinzelText({Key key, this.displayText, this.fontWeight, this.fontSize, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      displayText,
      style: TextStyle(
        color: color == null ? Colors.white : color,
        fontWeight: fontWeight == null ? FontWeight.normal : fontWeight,
        fontSize: fontSize == null ? 30 : fontSize,
        fontFamily: 'Cinzel',
      ),
    );
  }
}
