import 'package:flutter/material.dart';

class PerceDropdownButton extends StatefulWidget {
  final Function function;

  const PerceDropdownButton({Key key, this.function}) : super(key: key);

  @override
  _PerceDropdownButtonState createState() => _PerceDropdownButtonState();
}

class _PerceDropdownButtonState extends State<PerceDropdownButton> {
  String dropdownValue = "Svaki";

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      value: dropdownValue,
      icon: const Icon(Icons.arrow_downward),
      iconSize: 24,
      elevation: 16,
      onChanged: (String newValue) {
        widget.function(newValue);
        setState(() {
          dropdownValue = newValue;
        });
      },
      items: ["Svaki", "Triler", "Istorijski", "Avanturistički", "Ljubavni", "Psihološki", "Naučna fantastika"].map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
