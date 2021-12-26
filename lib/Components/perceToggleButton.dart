import 'package:flutter/material.dart';
import 'package:percemobile/Components/Basic/cinzelText.dart';

class PerceToggleButton extends StatefulWidget {
  final String text1;
  final String text2;
  final Function function;
  bool firstChoice;

  PerceToggleButton({
    Key key,
    this.text1,
    this.text2,
    this.firstChoice,
    this.function
  }) : super(key: key);

  @override
  _PerceToggleButtonState createState() => _PerceToggleButtonState();
}

class _PerceToggleButtonState extends State<PerceToggleButton> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Stack(
            children: <Widget>[
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: <Color>[
                        widget.firstChoice ? Color(0xFF77B32B) : Color(0xFF4A3F3F),
                        widget.firstChoice ? Color(0xFF77B32B) : Color(0xFF4A3F3F),
                      ],
                    ),
                  ),
                ),
              ),
              TextButton(
                style: TextButton.styleFrom(
                  padding: EdgeInsets.all(16.0),
                  primary: Colors.white,
                  textStyle: TextStyle(fontSize: 20),
                ),
                onPressed: () {
                  widget.function();
                  setState(() => widget.firstChoice = !widget.firstChoice);
                },
                child: CinzelText(
                  displayText: widget.text1,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          width: 50,
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Stack(
            children: <Widget>[
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: <Color>[
                        widget.firstChoice ? Color(0xFF4A3F3F) : Color(0xFF77B32B),
                        widget.firstChoice ? Color(0xFF4A3F3F) : Color(0xFF77B32B),
                      ],
                    ),
                  ),
                ),
              ),
              TextButton(
                style: TextButton.styleFrom(
                  padding: EdgeInsets.all(16.0),
                  primary: Colors.white,
                  textStyle: TextStyle(fontSize: 20),
                ),
                onPressed: () {
                  widget.function();
                  setState(() => widget.firstChoice = !widget.firstChoice);
                },
                child: CinzelText(
                  displayText: widget.text2,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
