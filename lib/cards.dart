import 'package:flutter/material.dart';
import 'package:test/functions.dart';

// ignore: must_be_immutable
class Cards extends StatefulWidget {
  Cards({super.key});
  int cardID = 0;
  Header header = Header();
  Color cardBorderColor = Colors.transparent;
  List<Mains> mains = [];
  double cardBottomMargin = 0.0;
  bool isCardHiding = false;
  Function cardTouched = () {};
  Function rebuildCards = () {};
  Function deleteCard = () {};

  void setCardID(int a) {
    cardID = a;
  }

  void setHeader(Header a) {
    header = a;
  }

  void setDeleteCard(Function a) {
    deleteCard = a;
  }

  void setCardBottomMargin(double a) {
    cardBottomMargin = a;
  }

  void setRebuildCards(Function a) {
    rebuildCards = a;
  }

  void setCardTouched(Function a) {
    cardTouched = a;
  }

  void setCardBorderColor(Color a) {
    cardBorderColor = a;
  }

  void setMainList(List<Mains> a) {
    mains = a;
  }

  void setIsCardHiding(bool a) {
    isCardHiding = a;
  }

  List<Mains> getMainsAsList() {
    return mains;
  }

  Column getMains() {
    if (isCardHiding == false) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: mains,
      );
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [],
      );
    }
  }

  @override
  State<Cards> createState() => _CardsState();
}

class _CardsState extends State<Cards> {
  UniqueKey x = UniqueKey();
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      movementDuration: Duration.zero,
      key: x,
      direction: DismissDirection.startToEnd,
      onUpdate: (details) {
        widget.header.focusNode.unfocus();
        for (int i = 0; i < widget.mains.length; i++) {
          widget.mains[i].focusNode.unfocus();
          for (int j = 0; j < widget.mains[i].points.length; j++) {
            widget.mains[i].points[j].focusNode.unfocus();
          }
        }
      },
      confirmDismiss: (direction) {
        widget.deleteCard(widget.cardID);
        return Future.value(false);
      },
      child: GestureDetector(
        onTap: () {
          widget.cardTouched(widget.cardID);
        },
        onLongPress: () {
          widget.cardTouched(widget.cardID);
        },
        child: Container(
          margin: EdgeInsets.only(bottom: widget.cardBottomMargin),
          decoration: BoxDecoration(
            color: const Color.fromRGBO(121, 85, 72, 1),
            border: Border.all(
              width: 2,
              color: widget.cardBorderColor,
            ),
          ),
          width: double.infinity,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            widget.header,
            widget.getMains(),
          ]),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class Header extends StatefulWidget {
  Header({super.key});
  TextEditingController controller = TextEditingController();
  FocusNode focusNode = FocusNode();
  double containerWidth = 0.0;
  int cardID = 0;
  String header = "";
  Function cardTouched = () {};
  Function hideCardContent = () {};
  Function rebuildCards = () {};

  void setRebuildCards(Function a) {
    rebuildCards = a;
  }

  void setCardID(int a) {
    cardID = a;
  }

  void setHeader(String a) {
    header = a;
  }

  void setCardTouched(Function a) {
    cardTouched = a;
  }

  void setHideCardContent(Function a) {
    hideCardContent = a;
  }

  void setController(TextEditingController a) {
    controller = a;
  }

  void setFocusNode(FocusNode a) {
    focusNode = a;
  }

  void setContainerWidth(double a) {
    containerWidth = a;
  }

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  @override
  void initState() {
    widget.controller.text = widget.header;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.containerWidth,
      decoration: const BoxDecoration(color: Color.fromRGBO(255, 193, 7, 1)),
      padding: const EdgeInsets.only(top: 0, bottom: 0, left: 10, right: 10),
      child: Theme(
        data: ThemeData(
          textSelectionTheme: const TextSelectionThemeData(
              cursorColor: Color.fromRGBO(255, 255, 255, 1),
              selectionColor: Color.fromRGBO(255, 255, 255, 0.5)),
        ),
        child: TextField(
            selectionControls: CustomColorSelectionHandle(
                const Color.fromRGBO(255, 255, 255, 1)),
            magnifierConfiguration: TextMagnifierConfiguration.disabled,
            onTap: () {
              widget.hideCardContent(widget.cardID);
              widget.cardTouched(widget.cardID);
            },
            enableInteractiveSelection: true,
            onTapOutside: (PointerDownEvent a) {
              widget.focusNode.unfocus();
            },
            decoration: const InputDecoration(
              enabledBorder: InputBorder.none,
              border: InputBorder.none,
              disabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              focusedErrorBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
            ),
            onChanged: (text) {
              double textWidth = getTextWidth(text);
              widget.containerWidth = textWidth > getTextWidth(widget.header)
                  ? textWidth
                  : getTextWidth(widget.header);
              widget.header = text;
              setState(() {});
            },
            keyboardType: TextInputType.multiline,
            controller: widget.controller,
            style: const TextStyle(
                fontSize: 20.0,
                color: Color.fromRGBO(0, 0, 0, 1),
                fontWeight: FontWeight.bold),
            focusNode: widget.focusNode,
            maxLines: null,
            readOnly: false),
      ),
    );
  }
}

// ignore: must_be_immutable
class Mains extends StatefulWidget {
  Mains({super.key});
  TextEditingController controller = TextEditingController();
  FocusNode focusNode = FocusNode();
  double containerWidth = 0.0;
  int cardID = 0;
  int mainID = 0;
  String main = "";
  Function cardTouched = () {};
  Function mainTouched = () {};
  Color mainColor = Colors.transparent;
  List<Points> points = [];
  bool isMainHiding = false;
  Function hideMain = () {};
  Function rebuildCards = () {};
  Function deleteMain = () {};

  void setDeleteMain(Function a) {
    deleteMain = a;
  }

  void setRebuildCards(Function a) {
    rebuildCards = a;
  }

  void setCardID(int a) {
    cardID = a;
  }

  void setMainID(int a) {
    mainID = a;
  }

  void setMain(String a) {
    main = a;
  }

  void setCardTouched(Function a) {
    cardTouched = a;
  }

  void setMainTouched(Function a) {
    mainTouched = a;
  }

  void setMainColor(Color a) {
    mainColor = a;
  }

  void setPoint(List<Points> a) {
    points = a;
  }

  void setIsMainHiding(bool a) {
    isMainHiding = a;
  }

  void setController(TextEditingController a) {
    controller = a;
  }

  void setFocusNode(FocusNode a) {
    focusNode = a;
  }

  void setContainerWidth(double a) {
    containerWidth = a;
  }

  Column getPoints() {
    if (isMainHiding == true) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [],
      );
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: points,
      );
    }
  }

  List<Points> getPointsAsList() {
    return points;
  }

  @override
  State<Mains> createState() => _MainsState();
}

class _MainsState extends State<Mains> {
  UniqueKey x = UniqueKey();
  @override
  void initState() {
    widget.controller.text = widget.main;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: x,
      direction: DismissDirection.startToEnd,
      movementDuration: Duration.zero,
      onUpdate: (details) {
        widget.focusNode.unfocus();
        for (int i = 0; i < widget.points.length; i++) {
          widget.points[i].focusNode.unfocus();
        }
      },
      confirmDismiss: (direction) {
        widget.deleteMain(widget.cardID, widget.mainID);
        return Future.value(false);
      },
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(
          width: widget.containerWidth,
          decoration: BoxDecoration(color: widget.mainColor),
          padding:
              const EdgeInsets.only(top: 0, bottom: 0, left: 10, right: 10),
          child: Theme(
            data: ThemeData(
              textSelectionTheme: const TextSelectionThemeData(
                cursorColor: Color.fromRGBO(255, 255, 255, 1),
                selectionColor: Color.fromRGBO(255, 255, 255, 0.5),
              ),
            ),
            child: TextField(
                selectionControls: CustomColorSelectionHandle(
                    const Color.fromRGBO(255, 255, 255, 1)),
                magnifierConfiguration: TextMagnifierConfiguration.disabled,
                onTap: () {
                  widget.cardTouched(widget.cardID);
                  widget.mainTouched(widget.mainID);
                },
                enableInteractiveSelection: true,
                onTapOutside: (PointerDownEvent a) {
                  widget.focusNode.unfocus();
                },
                decoration: const InputDecoration(
                  enabledBorder: InputBorder.none,
                  border: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  focusedErrorBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                ),
                onChanged: (text) {
                  double textWidth = getTextWidth(text);
                  widget.containerWidth = textWidth > getTextWidth(widget.main)
                      ? textWidth
                      : getTextWidth(widget.main);
                  widget.main = text;
                  setState(() {});
                },
                keyboardType: TextInputType.multiline,
                controller: widget.controller,
                style: const TextStyle(
                    fontSize: 20.0, color: Color.fromRGBO(255, 255, 255, 1)),
                focusNode: widget.focusNode,
                maxLines: null,
                readOnly: false),
          ),
        ),
        widget.getPoints(),
      ]),
    );
  }
}

// ignore: must_be_immutable
class Points extends StatefulWidget {
  Points({super.key});
  TextEditingController controller = TextEditingController();
  FocusNode focusNode = FocusNode();
  double containerWidth = 0.0;
  int cardID = 0;
  int mainID = 0;
  int pointID = 0;
  String point = "";
  Function cardTouched = () {};
  Function rebuildCards = () {};
  Function deletePoint = () {};
  Function mainTouched = () {};

  void setMainTouched(Function a) {
    mainTouched = a;
  }

  void setDeletePoint(Function a) {
    deletePoint = a;
  }

  void setRebuildCards(Function a) {
    rebuildCards = a;
  }

  void setCardID(int a) {
    cardID = a;
  }

  void setMainID(int a) {
    mainID = a;
  }

  void setPointID(int a) {
    pointID = a;
  }

  void setPoint(String a) {
    point = a;
  }

  void setCardTouched(Function a) {
    cardTouched = a;
  }

  void setController(TextEditingController a) {
    controller = a;
  }

  void setFocusNode(FocusNode a) {
    focusNode = a;
  }

  void setContainerWidth(double a) {
    containerWidth = a;
  }

  @override
  State<Points> createState() => _PointsState();
}

class _PointsState extends State<Points> {
  UniqueKey x = UniqueKey();
  @override
  void initState() {
    widget.controller.text = widget.point;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: x,
      direction: DismissDirection.startToEnd,
      movementDuration: Duration.zero,
      onUpdate: (details) {
        widget.focusNode.unfocus();
      },
      confirmDismiss: (direction) {
        widget.deletePoint(widget.cardID, widget.mainID, widget.pointID);
        return Future.value(false);
      },
      child: Container(
        width: widget.containerWidth,
        decoration: const BoxDecoration(color: Color.fromRGBO(63, 81, 181, 1)),
        padding: const EdgeInsets.only(top: 0, bottom: 0, left: 10, right: 10),
        child: Theme(
          data: ThemeData(
            textSelectionTheme: const TextSelectionThemeData(
              cursorColor: Color.fromRGBO(255, 255, 255, 1),
              selectionColor: Color.fromRGBO(255, 255, 255, 0.5),
            ),
          ),
          child: TextField(
              selectionControls: CustomColorSelectionHandle(
                  const Color.fromRGBO(255, 255, 255, 1)),
              magnifierConfiguration: TextMagnifierConfiguration.disabled,
              enableInteractiveSelection: true,
              onTapOutside: (PointerDownEvent a) {
                widget.focusNode.unfocus();
              },
              onTap: () {
                widget.cardTouched(widget.cardID);
                widget.mainTouched(widget.mainID);
              },
              decoration: const InputDecoration(
                enabledBorder: InputBorder.none,
                border: InputBorder.none,
                disabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                focusedErrorBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
              ),
              onChanged: (text) {
                double textWidth = getTextWidth(text);
                widget.containerWidth = textWidth > getTextWidth(widget.point)
                    ? textWidth
                    : getTextWidth(widget.point);
                widget.point = text;
                setState(() {});
              },
              keyboardType: TextInputType.multiline,
              controller: widget.controller,
              style: const TextStyle(
                  fontSize: 20.0, color: Color.fromRGBO(255, 255, 255, 1)),
              focusNode: widget.focusNode,
              maxLines: null,
              readOnly: false),
        ),
      ),
    );
  }
}
