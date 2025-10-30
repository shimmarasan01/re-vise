import 'package:flutter/material.dart';

// ignore: must_be_immutable
class HeaderForSelection extends StatefulWidget {
  HeaderForSelection({super.key});
  late TextEditingController controller;
  late int cardID;
  late String header;
  late double containerWidth;
  late double paddingBottom;
  late Color backgroundColor;
  late Color foregroundColor;
  late bool isSelected;

  void setBackgroundColor(Color a) {
    backgroundColor = a;
  }

  void setForegroundColor(Color a) {
    foregroundColor = a;
  }

  void setCardID(int a) {
    cardID = a;
  }

  void setHeader(String a) {
    header = a;
  }

  void setController(TextEditingController a) {
    controller = a;
  }

  void setContainerWidth(double a) {
    containerWidth = a;
  }

  void setPaddingBottom(double a) {
    paddingBottom = a;
  }

  void setIsSelected(bool a) {
    isSelected = a;
  }

  @override
  State<HeaderForSelection> createState() => _HeaderForSelectionState();
}

class _HeaderForSelectionState extends State<HeaderForSelection> {
  @override
  void initState() {
    widget.controller.text = widget.header;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: widget.paddingBottom),
      width: widget.containerWidth,
      decoration: BoxDecoration(color: widget.backgroundColor),
      padding: const EdgeInsets.only(top: 0, bottom: 0, left: 10, right: 10),
      child: TextField(
          onTap: () {
            if (widget.isSelected == true) {
              widget.backgroundColor = const Color.fromRGBO(255, 193, 7, 1);
              widget.foregroundColor = const Color.fromRGBO(0, 0, 0, 1);
              widget.isSelected = false;
            } else {
              widget.backgroundColor = const Color.fromRGBO(0, 150, 136, 1);
              widget.foregroundColor = const Color.fromRGBO(255, 255, 255, 1);
              widget.isSelected = true;
            }
            setState(() {});
          },
          enableInteractiveSelection: false,
          decoration: const InputDecoration(
            enabledBorder: InputBorder.none,
            border: InputBorder.none,
            disabledBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            focusedErrorBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
          ),
          controller: widget.controller,
          style: TextStyle(
              fontSize: 20.0,
              color: widget.foregroundColor,
              fontWeight: FontWeight.bold),
          maxLines: null,
          readOnly: true),
    );
  }
}
