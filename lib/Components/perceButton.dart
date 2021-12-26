import 'package:flutter/material.dart';
import 'package:percemobile/Components/Basic/cinzelText.dart';

class PerceButton extends StatelessWidget {
  final Color color1;
  final Color color2;
  final Color color3;
  final String text;
  final Function function;

  const PerceButton({
    Key key,
    this.color1,
    this.color2,
    this.color3,
    this.text,
    this.function
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Stack(
        children: <Widget>[
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: <Color>[
                    color1,
                    color2,
                    color3,
                  ],
                ),
              ),
            ),
          ),
          TextButton(
            style: TextButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 2.0),
              primary: Colors.white,
              textStyle: TextStyle(fontSize: 16),
            ),
            onPressed: function,
            child: CinzelText(
              displayText: text,
            ),
          ),
        ],
      ),
    );
  }
}
