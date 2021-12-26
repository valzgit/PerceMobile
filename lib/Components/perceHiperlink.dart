import 'package:flutter/material.dart';

class PerceHyperlink extends StatelessWidget {
  final Function() function;
  final String text;
  const PerceHyperlink({
    Key key,
    this.function,
    this.text
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        child: Text(
          text,
          style: TextStyle(
            decoration: TextDecoration.underline,
            color: Colors.white,
            fontSize: 22,
          ),
        ),
        onTap: function
    );
  }
}
