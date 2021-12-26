import 'package:flutter/material.dart';

class RobotoText extends StatelessWidget {
  final String displayText;
  final FontWeight fontWeight;
  final Color color;
  const RobotoText({
    Key key,
    this.displayText,
    this.fontWeight,
    this.color
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      displayText,
      style: TextStyle(
        color: color == null? Colors.white : color,
        fontWeight: fontWeight,
        fontSize: 24,
        fontFamily: 'Roboto',
      ),
    );
  }
}
