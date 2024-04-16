import 'package:flutter/material.dart';
import 'package:test/headerforselection.dart';
import 'package:test/cards.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

// ignore: must_be_immutable
class MainOverlay extends StatefulWidget {
  MainOverlay({super.key});
  late Function hideMainOverlay;
  late Function showNextOverlay;
  late bool isSequentialSelected;
  late bool isRandomisedSelected;
  late Color sequentialBackgroundColor;
  late Color sequentialForegroundColor;
  late Color randomisedBackgroundColor;
  late Color randomisedForegroundColor;
  late List<HeaderForSelection> headersForSelection;
  late List<Cards> cards;
  late String taskName;

  void setIsSequentialSelected(bool a) {
    isSequentialSelected = a;
  }

  void setIsRandomisedSelected(bool a) {
    isRandomisedSelected = a;
  }

  void setSequentialBackgroundColor(Color a) {
    sequentialBackgroundColor = a;
  }

  void setSequentialForegroundColor(Color a) {
    sequentialForegroundColor = a;
  }

  void setRandomisedBackgroundColor(Color a) {
    randomisedBackgroundColor = a;
  }

  void setRandomisedForegroundColor(Color a) {
    randomisedForegroundColor = a;
  }

  void setTaskName(String a) {
    taskName = a;
  }

  void setCards(List<Cards> a) {
    cards = a;
  }

  void setHeadersForSelection() {
    headersForSelection = [];
    for (int i = 0; i < cards.length; i++) {
      HeaderForSelection headerForSelection = HeaderForSelection();
      if (cards[i].mains.isEmpty) {
      } else {
        bool huh = false;
        for (int d = 0; d < cards[i].mains.length; d++) {
          if (cards[i].mains[d].points.isEmpty) {
            huh = true;
          }
        }
        if (huh == true) {
        } else {
          headerForSelection.setCardID(cards[i].cardID);
          headerForSelection.setContainerWidth(cards[i].header.containerWidth);
          headerForSelection.setController(TextEditingController());
          headerForSelection
              .setBackgroundColor(const Color.fromRGBO(255, 193, 7, 1));
          headerForSelection
              .setForegroundColor(const Color.fromRGBO(0, 0, 0, 1));
          headerForSelection.setHeader(cards[i].header.header);
          headerForSelection.setIsSelected(false);
          if (i == cards.length - 1) {
            headerForSelection.setPaddingBottom(0);
          } else {
            headerForSelection.setPaddingBottom(21.7);
          }
          headersForSelection.add(headerForSelection);
        }
      }
    }
  }

  void setHideMainOverlay(Function a) {
    hideMainOverlay = a;
  }

  void setShowNextOverlay(Function a) {
    showNextOverlay = a;
  }

  List<HeaderForSelection> getHeadersForSelection() {
    return headersForSelection;
  }

  bool getSequentialMode() {
    return isSequentialSelected;
  }

  @override
  State<MainOverlay> createState() => _MainOverlayState();
}

class _MainOverlayState extends State<MainOverlay> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(builder: (context, orientation) {
      return orientation == Orientation.landscape
          ? Material(
              color: const Color.fromRGBO(0, 0, 0, 0.9),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(
                          top: 100, bottom: 100, left: 100, right: 100),
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(121, 85, 72, 1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Material(
                                    textStyle: const TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.w500),
                                    color: const Color.fromRGBO(121, 85, 72, 1),
                                    child: Text(widget.taskName)),
                                SizedBox(
                                  width: 45,
                                  child: FloatingActionButton(
                                      elevation: 0,
                                      backgroundColor:
                                          const Color.fromRGBO(0, 150, 136, 1),
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10))),
                                      onPressed: () {
                                        widget.hideMainOverlay();
                                      },
                                      child: const Icon(
                                          color:
                                              Color.fromRGBO(255, 255, 255, 1),
                                          size: 25,
                                          MaterialCommunityIcons.close)),
                                )
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 10,
                            child: Container(
                                margin:
                                    const EdgeInsets.only(top: 20, bottom: 20),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      flex: 7,
                                      child: SizedBox(
                                        height: double.infinity,
                                        child: SingleChildScrollView(
                                          scrollDirection: Axis.vertical,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children:
                                                widget.headersForSelection,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          SizedBox(
                                            width: 200,
                                            child: ElevatedButton(
                                              onPressed: () {
                                                if (widget
                                                        .isSequentialSelected ==
                                                    true) {
                                                  widget.sequentialBackgroundColor =
                                                      const Color.fromRGBO(
                                                          255, 255, 255, 1);
                                                  widget.sequentialForegroundColor =
                                                      const Color.fromRGBO(
                                                          121, 85, 72, 1);
                                                  widget.isSequentialSelected =
                                                      true;
                                                  widget.randomisedBackgroundColor =
                                                      const Color.fromRGBO(
                                                          121, 85, 72, 1);
                                                  widget.randomisedForegroundColor =
                                                      const Color.fromRGBO(
                                                          255, 255, 255, 1);
                                                  widget.isRandomisedSelected =
                                                      false;
                                                } else {
                                                  widget.sequentialBackgroundColor =
                                                      const Color.fromRGBO(
                                                          255, 255, 255, 1);
                                                  widget.sequentialForegroundColor =
                                                      const Color.fromRGBO(
                                                          121, 85, 72, 1);
                                                  widget.isSequentialSelected =
                                                      true;
                                                  widget.randomisedBackgroundColor =
                                                      const Color.fromRGBO(
                                                          121, 85, 72, 1);
                                                  widget.randomisedForegroundColor =
                                                      const Color.fromRGBO(
                                                          255, 255, 255, 1);
                                                  widget.isRandomisedSelected =
                                                      false;
                                                }
                                                setState(() {});
                                              },
                                              style: ElevatedButton.styleFrom(
                                                shape:
                                                    const RoundedRectangleBorder(
                                                  side: BorderSide(
                                                    color: Color.fromRGBO(
                                                        255, 255, 255, 1),
                                                    width: 2.0,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.all(
                                                    Radius.zero,
                                                  ),
                                                ),
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 16.0,
                                                        vertical: 12.0),
                                                backgroundColor: widget
                                                    .sequentialBackgroundColor,
                                              ),
                                              child: Text(
                                                'Sequential',
                                                style: TextStyle(
                                                  color: widget
                                                      .sequentialForegroundColor,
                                                  fontSize: 16.0,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(height: 5),
                                          SizedBox(
                                            width: 200,
                                            child: ElevatedButton(
                                              onPressed: () {
                                                if (widget
                                                        .isRandomisedSelected ==
                                                    true) {
                                                  widget.sequentialBackgroundColor =
                                                      const Color.fromRGBO(
                                                          121, 85, 72, 1);
                                                  widget.sequentialForegroundColor =
                                                      const Color.fromRGBO(
                                                          255, 255, 255, 1);
                                                  widget.isSequentialSelected =
                                                      false;
                                                  widget.randomisedBackgroundColor =
                                                      const Color.fromRGBO(
                                                          255, 255, 255, 1);
                                                  widget.randomisedForegroundColor =
                                                      const Color.fromRGBO(
                                                          121, 85, 72, 1);
                                                  widget.isRandomisedSelected =
                                                      true;
                                                } else {
                                                  widget.sequentialBackgroundColor =
                                                      const Color.fromRGBO(
                                                          121, 85, 72, 1);
                                                  widget.sequentialForegroundColor =
                                                      const Color.fromRGBO(
                                                          255, 255, 255, 1);
                                                  widget.isSequentialSelected =
                                                      false;
                                                  widget.randomisedBackgroundColor =
                                                      const Color.fromRGBO(
                                                          255, 255, 255, 1);
                                                  widget.randomisedForegroundColor =
                                                      const Color.fromRGBO(
                                                          121, 85, 72, 1);
                                                  widget.isRandomisedSelected =
                                                      true;
                                                }
                                                setState(() {});
                                              },
                                              style: ElevatedButton.styleFrom(
                                                shape:
                                                    const RoundedRectangleBorder(
                                                  side: BorderSide(
                                                    color: Color.fromRGBO(
                                                        255, 255, 255, 1),
                                                    width: 2.0,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.all(
                                                    Radius.zero,
                                                  ),
                                                ),
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 16.0,
                                                        vertical: 12.0),
                                                backgroundColor: widget
                                                    .randomisedBackgroundColor,
                                              ),
                                              child: Text(
                                                'Randomised',
                                                style: TextStyle(
                                                  color: widget
                                                      .randomisedForegroundColor,
                                                  fontSize: 16.0,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                )),
                          ),
                          Expanded(
                            flex: 1,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                SizedBox(
                                  width: 200,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      bool noHeadersSelected = true;
                                      for (int e = 0;
                                          e < widget.headersForSelection.length;
                                          e++) {
                                        if (widget.headersForSelection[e]
                                                .isSelected ==
                                            true) {
                                          noHeadersSelected = false;
                                        }
                                      }
                                      if (noHeadersSelected == true) {
                                      } else {
                                        widget.hideMainOverlay();
                                        widget.showNextOverlay(context);
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16.0, vertical: 12.0),
                                      backgroundColor:
                                          const Color.fromRGBO(0, 150, 136, 1),
                                    ),
                                    child: const Text(
                                      'Start',
                                      style: TextStyle(
                                        color: Color.fromRGBO(255, 255, 255, 1),
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          : Material(
              color: const Color.fromRGBO(0, 0, 0, 0.9),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                      //height: 500.0,
                      //width: 800,
                      //margin: const EdgeInsets.only(top: 85),
                      margin: const EdgeInsets.only(
                          top: 100, bottom: 100, left: 100, right: 100),
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(121, 85, 72, 1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Material(
                                    textStyle: const TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.w500),
                                    color: const Color.fromRGBO(121, 85, 72, 1),
                                    child: Text(widget.taskName)),
                                SizedBox(
                                  width: 45,
                                  child: FloatingActionButton(
                                      elevation: 0,
                                      backgroundColor:
                                          const Color.fromRGBO(0, 150, 136, 1),
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10))),
                                      onPressed: () {
                                        widget.hideMainOverlay();
                                      },
                                      child: const Icon(
                                          color:
                                              Color.fromRGBO(255, 255, 255, 1),
                                          size: 25,
                                          MaterialCommunityIcons.close)),
                                )
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 20,
                            child: Container(
                                margin:
                                    const EdgeInsets.only(top: 20, bottom: 20),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      flex: 3,
                                      child: SizedBox(
                                        height: double.infinity,
                                        child: SingleChildScrollView(
                                          scrollDirection: Axis.vertical,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children:
                                                widget.headersForSelection,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          SizedBox(
                                            width: 200,
                                            child: ElevatedButton(
                                              onPressed: () {
                                                if (widget
                                                        .isSequentialSelected ==
                                                    true) {
                                                  widget.sequentialBackgroundColor =
                                                      const Color.fromRGBO(
                                                          255, 255, 255, 1);
                                                  widget.sequentialForegroundColor =
                                                      const Color.fromRGBO(
                                                          121, 85, 72, 1);
                                                  widget.isSequentialSelected =
                                                      true;
                                                  widget.randomisedBackgroundColor =
                                                      const Color.fromRGBO(
                                                          121, 85, 72, 1);
                                                  widget.randomisedForegroundColor =
                                                      const Color.fromRGBO(
                                                          255, 255, 255, 1);
                                                  widget.isRandomisedSelected =
                                                      false;
                                                } else {
                                                  widget.sequentialBackgroundColor =
                                                      const Color.fromRGBO(
                                                          255, 255, 255, 1);
                                                  widget.sequentialForegroundColor =
                                                      const Color.fromRGBO(
                                                          121, 85, 72, 1);
                                                  widget.isSequentialSelected =
                                                      true;
                                                  widget.randomisedBackgroundColor =
                                                      const Color.fromRGBO(
                                                          121, 85, 72, 1);
                                                  widget.randomisedForegroundColor =
                                                      const Color.fromRGBO(
                                                          255, 255, 255, 1);
                                                  widget.isRandomisedSelected =
                                                      false;
                                                }
                                                setState(() {});
                                              },
                                              style: ElevatedButton.styleFrom(
                                                shape:
                                                    const RoundedRectangleBorder(
                                                  side: BorderSide(
                                                    color: Color.fromRGBO(
                                                        255, 255, 255, 1),
                                                    width: 2.0,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.all(
                                                    Radius.zero,
                                                  ),
                                                ),
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 16.0,
                                                        vertical: 12.0),
                                                backgroundColor: widget
                                                    .sequentialBackgroundColor,
                                              ),
                                              child: Text(
                                                'Sequential',
                                                style: TextStyle(
                                                  color: widget
                                                      .sequentialForegroundColor,
                                                  fontSize: 16.0,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(height: 5),
                                          SizedBox(
                                            width: 200,
                                            child: ElevatedButton(
                                              onPressed: () {
                                                if (widget
                                                        .isRandomisedSelected ==
                                                    true) {
                                                  widget.sequentialBackgroundColor =
                                                      const Color.fromRGBO(
                                                          121, 85, 72, 1);
                                                  widget.sequentialForegroundColor =
                                                      const Color.fromRGBO(
                                                          255, 255, 255, 1);
                                                  widget.isSequentialSelected =
                                                      false;
                                                  widget.randomisedBackgroundColor =
                                                      const Color.fromRGBO(
                                                          255, 255, 255, 1);
                                                  widget.randomisedForegroundColor =
                                                      const Color.fromRGBO(
                                                          121, 85, 72, 1);
                                                  widget.isRandomisedSelected =
                                                      true;
                                                } else {
                                                  widget.sequentialBackgroundColor =
                                                      const Color.fromRGBO(
                                                          121, 85, 72, 1);
                                                  widget.sequentialForegroundColor =
                                                      const Color.fromRGBO(
                                                          255, 255, 255, 1);
                                                  widget.isSequentialSelected =
                                                      false;
                                                  widget.randomisedBackgroundColor =
                                                      const Color.fromRGBO(
                                                          255, 255, 255, 1);
                                                  widget.randomisedForegroundColor =
                                                      const Color.fromRGBO(
                                                          121, 85, 72, 1);
                                                  widget.isRandomisedSelected =
                                                      true;
                                                }
                                                setState(() {});
                                              },
                                              style: ElevatedButton.styleFrom(
                                                shape:
                                                    const RoundedRectangleBorder(
                                                  side: BorderSide(
                                                    color: Color.fromRGBO(
                                                        255, 255, 255, 1),
                                                    width: 2.0,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.all(
                                                    Radius.zero,
                                                  ),
                                                ),
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 16.0,
                                                        vertical: 12.0),
                                                backgroundColor: widget
                                                    .randomisedBackgroundColor,
                                              ),
                                              child: Text(
                                                'Randomised',
                                                style: TextStyle(
                                                  color: widget
                                                      .randomisedForegroundColor,
                                                  fontSize: 16.0,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                )),
                          ),
                          Expanded(
                            flex: 1,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                SizedBox(
                                  width: 200,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      bool noHeadersSelected = true;
                                      for (int e = 0;
                                          e < widget.headersForSelection.length;
                                          e++) {
                                        if (widget.headersForSelection[e]
                                                .isSelected ==
                                            true) {
                                          noHeadersSelected = false;
                                        }
                                      }
                                      if (noHeadersSelected == true) {
                                      } else {
                                        widget.hideMainOverlay();
                                        widget.showNextOverlay(context);
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16.0, vertical: 12.0),
                                      backgroundColor:
                                          const Color.fromRGBO(0, 150, 136, 1),
                                    ),
                                    child: const Text(
                                      'Start',
                                      style: TextStyle(
                                        color: Color.fromRGBO(255, 255, 255, 1),
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
    });
  }
}
