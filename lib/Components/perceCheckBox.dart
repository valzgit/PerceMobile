import 'package:flutter/material.dart';

class PerceCheckBox extends StatefulWidget {
  final Function function;
  final bool isChecked;
  const PerceCheckBox({Key key,this.function, this.isChecked}) : super(key: key);

  @override
  _PerceCheckBoxState createState() => _PerceCheckBoxState();
}

class _PerceCheckBoxState extends State<PerceCheckBox> {
  bool isChecked = false;
  bool firstTime = true;
  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.selected
    };
    if (states.any(interactiveStates.contains)) {
      return Colors.green;
    }
    return Colors.black;
  }

  @override
  Widget build(BuildContext context) {
    if(firstTime && widget.isChecked!=null){firstTime = false; isChecked=widget.isChecked;}
    return Container(
      child: Checkbox(
        checkColor: Colors.white,
        fillColor: MaterialStateProperty.resolveWith(getColor),
        value: isChecked,
        onChanged: (bool value) {
          widget.function();
          setState(
            () {
              isChecked = value;
            },
          );
        },
      ),
    );
  }
}
