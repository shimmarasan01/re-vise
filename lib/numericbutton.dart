import 'package:flutter/material.dart';

// ignore: must_be_immutable
class NumericButton extends StatefulWidget {
  NumericButton({super.key});
  late int numericButtonIndex;
  late int numeric;
  late double bottomMargin;
  late Color borderColor;
  late Function buildNumericButtons;

  void setNumericButtonIndex(int a) {
    numericButtonIndex = a;
    numeric = a + 1;
  }

  void setBottomMargin(double a) {
    bottomMargin = a;
  }

  void setBorderColor(Color a) {
    borderColor = a;
  }

  void setBuildNumericButtons(Function a) {
    buildNumericButtons = a;
  }

  @override
  State<NumericButton> createState() => _NumericButtonState();
}

class _NumericButtonState extends State<NumericButton> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: widget.bottomMargin),
      height: 55,
      width: 55,
      child: ElevatedButton(
        onPressed: () {
          widget.buildNumericButtons(widget.numericButtonIndex);
          setState(() {});
        },
        style: ElevatedButton.styleFrom(
          side: BorderSide(width: 2, color: widget.borderColor),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          backgroundColor: const Color.fromRGBO(0, 150, 136, 1),
        ),
        child: Text(
          widget.numeric.toString(),
          style: const TextStyle(
            color: Color.fromRGBO(255, 255, 255, 1),
            fontSize: 16.0,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
