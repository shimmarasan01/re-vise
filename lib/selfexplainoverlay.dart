import 'package:flutter/material.dart';
import 'package:test/cards.dart';
import 'package:test/headerforselection.dart';
import 'package:test/numericbutton.dart';
import 'package:test/functions.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

// ignore: must_be_immutable
class SelfExplainOverlay extends StatefulWidget {
  SelfExplainOverlay({super.key});
  late List<Cards> cards;
  late Function hideSelfExplainOverlay;
  late bool sequentialMode;
  late List<HeaderForSelection> headersForSelection;
  late List<NumericButton> questionButtons;
  late List<HeaderMain> hmList;
  late List<UserAnswerField> uafList;
  late List<int> cardIDOfSelectedHeaders;
  late int currentIndex;
  late bool readyToShowSSPercentage;
  late List<String> percentageOfSSList;
  late bool ssModelRunning;

  void setCardIDOfSelectedHeaders(List<int> a) {
    cardIDOfSelectedHeaders = a;
  }

  void setCurrentIndex(int a) {
    currentIndex = a;
  }

  void setReadyToShowSSPercentage(bool a) {
    readyToShowSSPercentage = a;
  }

  void setPercentageOfSSList(List<String> a) {
    percentageOfSSList = a;
  }

  void setSSModelRunning(bool a) {
    ssModelRunning = a;
  }

  void setQuestionButtons(List<NumericButton> a) {
    questionButtons = a;
  }

  void setHMList(List<HeaderMain> a) {
    hmList = a;
  }

  void setUAFList(List<UserAnswerField> a) {
    uafList = a;
  }

  void setCards(List<Cards> a) {
    cards = a;
  }

  void setHeadersForSelection(List<HeaderForSelection> a) {
    headersForSelection = a;
  }

  void setHideSelfExplainOverlay(Function a) {
    hideSelfExplainOverlay = a;
  }

  void setQuestionMode(bool a) {
    if (a == true) {
      sequentialMode = true;
    } else {
      sequentialMode = false;
    }
  }

  @override
  State<SelfExplainOverlay> createState() => _SelfExplainOverlayState();
}

class _SelfExplainOverlayState extends State<SelfExplainOverlay> {
  @override
  void initState() {
    generateQuestion();
    super.initState();
  }

  Future<void> generateQuestion() async {
    widget.cardIDOfSelectedHeaders = [];
    for (int i = 0; i < widget.headersForSelection.length; i++) {
      if (widget.headersForSelection[i].isSelected == true) {
        widget.cardIDOfSelectedHeaders
            .add(widget.headersForSelection[i].cardID);
      }
    }
    List<List<Mains>> mainsToGenerateQuestionsFrom = [];
    for (int k = 0; k < widget.cards.length; k++) {
      for (int l = 0; l < widget.cardIDOfSelectedHeaders.length; l++) {
        if (widget.cards[k].cardID == widget.cardIDOfSelectedHeaders[l]) {
          mainsToGenerateQuestionsFrom.add(widget.cards[k].mains);
        }
      }
    }
    widget.hmList = [];
    for (int z = 0; z < mainsToGenerateQuestionsFrom.length; z++) {
      for (int x = 0; x < mainsToGenerateQuestionsFrom[z].length; x++) {
        HeaderMain hm = HeaderMain();
        hm.setMainController(TextEditingController());
        hm.setHeaderController(TextEditingController());
        for (int i = 0; i < widget.headersForSelection.length; i++) {
          if (mainsToGenerateQuestionsFrom[z][x].cardID ==
              widget.headersForSelection[i].cardID) {
            hm.setHeader(widget.headersForSelection[i].header);
            hm.setHeaderContainerWidth(
                widget.headersForSelection[i].containerWidth);
          }
        }
        hm.setMain(mainsToGenerateQuestionsFrom[z][x].main);
        hm.setPointList(mainsToGenerateQuestionsFrom[z][x].points);
        hm.setMainContainerWidth(
            mainsToGenerateQuestionsFrom[z][x].containerWidth);
        widget.hmList.add(hm);
      }
    }
    widget.uafList = [];
    for (int r = 0; r < widget.hmList.length; r++) {
      UserAnswerField uaf = UserAnswerField();
      uaf.setController(TextEditingController());
      uaf.setFocusNode(FocusNode());
      uaf.setUserAnswer("");
      uaf.setActualAnswer(widget.hmList[r].points);
      uaf.setResetPercentage(resetPercentage);
      uaf.setContainerColor(const Color.fromRGBO(121, 85, 72, 1));
      widget.uafList.add(uaf);
      widget.percentageOfSSList.add("");
    }
    if (widget.sequentialMode == false) {
      final indices = List.generate(widget.hmList.length, (index) => index)
        ..shuffle();
      widget.hmList = indices.map((i) => widget.hmList[i]).toList();
      widget.uafList = indices.map((i) => widget.uafList[i]).toList();
    }
    buildNumericButton(widget.currentIndex);
    setState(() {});
  }

  void resetPercentage(bool a) {
    if (widget.ssModelRunning == false) {
      if (a == true) {
        List<String> x = widget.percentageOfSSList;
        for (int i = 0; i < widget.hmList.length; i++) {
          if (i == widget.currentIndex) {
            widget.percentageOfSSList[i] = "";
            x.add(widget.percentageOfSSList[i]);
          } else {
            x.add(widget.percentageOfSSList[i]);
          }
        }
        widget.percentageOfSSList = x;
        widget.readyToShowSSPercentage = true;
        setState(() {});
      }
    }
  }

  Future<void> checkSemanticSimilarity() async {
    widget.ssModelRunning = true;
    widget.readyToShowSSPercentage = false;
    setState(() {});
    String d = await runSSModel(
        widget.uafList[widget.currentIndex].actualAnswer,
        widget.uafList[widget.currentIndex].userAnswer);
    List<String> x = widget.percentageOfSSList;
    for (int i = 0; i < widget.hmList.length; i++) {
      if (i == widget.currentIndex) {
        widget.percentageOfSSList[i] = d;
        x.add(widget.percentageOfSSList[i]);
      } else {
        x.add(widget.percentageOfSSList[i]);
      }
    }
    widget.percentageOfSSList = x;
    widget.readyToShowSSPercentage = true;
    widget.ssModelRunning = false;
    setState(() {});
  }

  void buildNumericButton(int selectedNumericeButtonIndex) {
    if (widget.ssModelRunning == false) {
      widget.questionButtons = [];
      widget.currentIndex = selectedNumericeButtonIndex;
      for (int d = 0; d < widget.hmList.length; d++) {
        NumericButton numericButtons = NumericButton();
        numericButtons.setNumericButtonIndex(d);
        numericButtons.setBuildNumericButtons(buildNumericButton);
        if (d == widget.currentIndex) {
          numericButtons.setBorderColor(const Color.fromRGBO(255, 255, 255, 1));
        } else {
          numericButtons.setBorderColor(const Color.fromRGBO(0, 0, 0, 0));
        }
        if (d == widget.hmList.length - 1) {
          numericButtons.setBottomMargin(0);
        } else {
          numericButtons.setBottomMargin(13.3);
        }
        widget.questionButtons.add(numericButtons);
      }
      setState(() {});
    }
  }

  void showHint(bool a) {
    for (int d = 0; d < widget.hmList.length; d++) {
      UserAnswerField uaf = UserAnswerField();
      uaf.setController(TextEditingController());
      uaf.setFocusNode(FocusNode());
      uaf.setUserAnswer(widget.uafList[d].userAnswer);
      uaf.setActualAnswer(widget.uafList[d].d);
      uaf.setResetPercentage(resetPercentage);
      uaf.setContainerColor(const Color.fromRGBO(121, 85, 72, 1));
      if (d == widget.currentIndex) {
        uaf.setShowHint(a);
      }
      widget.uafList[d] = uaf;
    }
    setState(() {});
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
                                const Text("Self-explaining",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 25,
                                        color:
                                            Color.fromRGBO(255, 255, 255, 1))),
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
                                        widget.hideSelfExplainOverlay();
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
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: SizedBox(
                                        height: double.infinity,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: SingleChildScrollView(
                                            scrollDirection: Axis.vertical,
                                            child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children:
                                                    widget.questionButtons),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 10,
                                      child: SizedBox(
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Expanded(
                                                flex: 2,
                                                child: Container(
                                                  padding:
                                                      const EdgeInsets.only(
                                                    top: 4,
                                                  ),
                                                  child: SizedBox(
                                                    child: Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .end,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Expanded(
                                                          flex: 19,
                                                          child: SizedBox(
                                                            child: widget
                                                                    .hmList[
                                                                widget
                                                                    .currentIndex],
                                                          ),
                                                        ),
                                                        Expanded(
                                                          flex: 1,
                                                          child: Container(
                                                              height: 90,
                                                              width: 45,
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              child: widget
                                                                          .readyToShowSSPercentage ==
                                                                      false
                                                                  ? const SizedBox(
                                                                      width: 15,
                                                                      height:
                                                                          15,
                                                                      child:
                                                                          CircularProgressIndicator(
                                                                        valueColor: AlwaysStoppedAnimation<Color>(Color.fromRGBO(
                                                                            255,
                                                                            255,
                                                                            255,
                                                                            1)),
                                                                        strokeWidth:
                                                                            3.0,
                                                                      ),
                                                                    )
                                                                  : Text(
                                                                      widget.percentageOfSSList[
                                                                          widget
                                                                              .currentIndex],
                                                                      style: const TextStyle(
                                                                          fontWeight: FontWeight
                                                                              .w700,
                                                                          fontSize:
                                                                              16,
                                                                          color: Color.fromRGBO(
                                                                              255,
                                                                              255,
                                                                              255,
                                                                              1)))),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 5,
                                                child: Container(
                                                  color: Colors.green,
                                                  child: SizedBox(
                                                    child: widget.uafList[
                                                        widget.currentIndex],
                                                  ),
                                                ),
                                              )
                                            ]),
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
                                  width: 100,
                                  child: GestureDetector(
                                    onTapCancel: () {
                                      showHint(false);
                                    },
                                    onTapDown: (TapDownDetails a) {
                                      showHint(true);
                                    },
                                    child: ElevatedButton(
                                      onPressed: () {
                                        showHint(false);
                                      },
                                      style: ElevatedButton.styleFrom(
                                        splashFactory: NoSplash.splashFactory,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16.0, vertical: 12.0),
                                        backgroundColor: const Color.fromRGBO(
                                            63, 81, 181, 1),
                                      ),
                                      child: const Text(
                                        'Hint',
                                        style: TextStyle(
                                          color:
                                              Color.fromRGBO(255, 255, 255, 1),
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                SizedBox(
                                  width: 200,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      if (widget.ssModelRunning == true) {
                                      } else {
                                        checkSemanticSimilarity();
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
                                      'Check',
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
                                const Text("Self-explaining",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 25,
                                        color:
                                            Color.fromRGBO(255, 255, 255, 1))),
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
                                        widget.hideSelfExplainOverlay();
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
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: SizedBox(
                                        height: double.infinity,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: SingleChildScrollView(
                                            scrollDirection: Axis.vertical,
                                            child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children:
                                                    widget.questionButtons),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 5,
                                      child: SizedBox(
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Expanded(
                                                flex: 3,
                                                child: Container(
                                                  padding:
                                                      const EdgeInsets.only(
                                                    top: 3,
                                                  ),
                                                  child: SizedBox(
                                                    child: Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .end,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Expanded(
                                                          flex: 10,
                                                          child: SizedBox(
                                                            child: widget
                                                                    .hmList[
                                                                widget
                                                                    .currentIndex],
                                                          ),
                                                        ),
                                                        Expanded(
                                                          flex: 1,
                                                          child: Container(
                                                              height: 100,
                                                              width: 45,
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              child: widget
                                                                          .readyToShowSSPercentage ==
                                                                      false
                                                                  ? const SizedBox(
                                                                      width: 15,
                                                                      height:
                                                                          15,
                                                                      child:
                                                                          CircularProgressIndicator(
                                                                        valueColor: AlwaysStoppedAnimation<Color>(Color.fromRGBO(
                                                                            255,
                                                                            255,
                                                                            255,
                                                                            1)),
                                                                        strokeWidth:
                                                                            3.0,
                                                                      ),
                                                                    )
                                                                  : Text(
                                                                      widget.percentageOfSSList[
                                                                          widget
                                                                              .currentIndex],
                                                                      style: const TextStyle(
                                                                          fontWeight: FontWeight
                                                                              .w700,
                                                                          fontSize:
                                                                              16,
                                                                          color: Color.fromRGBO(
                                                                              255,
                                                                              255,
                                                                              255,
                                                                              1)))),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 19,
                                                child: SizedBox(
                                                  child: widget.uafList[
                                                      widget.currentIndex],
                                                ),
                                              )
                                            ]),
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
                                  width: 100,
                                  child: GestureDetector(
                                    onTapCancel: () {
                                      showHint(false);
                                    },
                                    onTapDown: (TapDownDetails a) {
                                      showHint(true);
                                    },
                                    child: ElevatedButton(
                                      onPressed: () {
                                        showHint(false);
                                      },
                                      style: ElevatedButton.styleFrom(
                                        splashFactory: NoSplash.splashFactory,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16.0, vertical: 12.0),
                                        backgroundColor: const Color.fromRGBO(
                                            63, 81, 181, 1),
                                      ),
                                      child: const Text(
                                        'Hint',
                                        style: TextStyle(
                                          color:
                                              Color.fromRGBO(255, 255, 255, 1),
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                SizedBox(
                                  width: 200,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      if (widget.ssModelRunning == true) {
                                      } else {
                                        checkSemanticSimilarity();
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
                                      'Check',
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

// ignore: must_be_immutable
class HeaderMain extends StatefulWidget {
  HeaderMain({super.key});
  late String header;
  late String main;
  late double headerContainerWidth;
  late double mainContainerWidth;
  late List<Points> points;
  late TextEditingController mainController;
  late TextEditingController headerController;

  void setHeader(String a) {
    header = a;
    headerController.text = header;
  }

  void setMain(String a) {
    main = a;
    mainController.text = main;
  }

  void setHeaderContainerWidth(double a) {
    headerContainerWidth = a;
  }

  void setMainContainerWidth(double a) {
    mainContainerWidth = a;
  }

  void setPointList(List<Points> a) {
    points = a;
  }

  void setMainController(TextEditingController a) {
    mainController = a;
  }

  void setHeaderController(TextEditingController a) {
    headerController = a;
  }

  @override
  State<HeaderMain> createState() => _HeaderMainState();
}

class _HeaderMainState extends State<HeaderMain> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Container(
            width: widget.headerContainerWidth,
            decoration:
                const BoxDecoration(color: Color.fromRGBO(255, 193, 7, 1)),
            padding:
                const EdgeInsets.only(top: 0, bottom: 0, left: 10, right: 10),
            child: TextField(
                enableInteractiveSelection: false,
                decoration: const InputDecoration(
                  enabledBorder: InputBorder.none,
                  border: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  focusedErrorBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                ),
                controller: widget.headerController,
                style: const TextStyle(
                    fontSize: 20.0,
                    color: Color.fromRGBO(0, 0, 0, 1),
                    fontWeight: FontWeight.bold),
                maxLines: null,
                readOnly: true),
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Container(
            width: widget.mainContainerWidth,
            decoration:
                const BoxDecoration(color: Color.fromRGBO(233, 30, 99, 1)),
            padding:
                const EdgeInsets.only(top: 0, bottom: 0, left: 10, right: 10),
            child: TextField(
                enableInteractiveSelection: false,
                decoration: const InputDecoration(
                  enabledBorder: InputBorder.none,
                  border: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  focusedErrorBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                ),
                controller: widget.mainController,
                style: const TextStyle(
                    fontSize: 20.0,
                    color: Color.fromRGBO(255, 255, 255, 1),
                    fontWeight: FontWeight.normal),
                maxLines: null,
                readOnly: true),
          ),
        ),
      ],
    );
  }
}

// ignore: must_be_immutable
class UserAnswerField extends StatefulWidget {
  UserAnswerField({super.key});
  late String actualAnswer;
  late String userAnswer;
  late bool showHint = false;
  late Function resetPercentage = () {};
  late List<Points> d = [];
  late Color containerColor;
  late TextEditingController controller;
  late FocusNode focusNode;

  void setContainerColor(Color a) {
    containerColor = a;
  }

  void setController(TextEditingController a) {
    controller = a;
  }

  void setFocusNode(FocusNode a) {
    focusNode = a;
  }

  void setUserAnswer(String a) {
    userAnswer = a;
    controller.text = userAnswer;
  }

  void setActualAnswer(List<Points> a) {
    d = a;
    for (int i = 0; i < d.length; i++) {
      if (i == 0) {
        actualAnswer = d[i].point;
      } else {
        actualAnswer = "$actualAnswer, ${d[i].point}";
      }
    }
  }

  void setShowHint(bool a) {
    showHint = a;
    if (showHint == true) {
      containerColor = const Color.fromRGBO(63, 81, 181, 1);
      controller.text = actualAnswer;
    } else {
      containerColor = const Color.fromRGBO(121, 85, 72, 1);
      controller.text = userAnswer;
    }
  }

  void setResetPercentage(Function a) {
    resetPercentage = a;
  }

  @override
  State<UserAnswerField> createState() => _UserAnswerFieldState();
}

class _UserAnswerFieldState extends State<UserAnswerField> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(left: 10, right: 10),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          color: widget.containerColor,
          border: Border.all(
            width: 2,
            color: const Color.fromRGBO(255, 255, 255, 1),
          ),
        ),
        width: double.infinity,
        child: widget.showHint == false
            ? Theme(
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
                    onTap: () {},
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
                      widget.resetPercentage(true);
                      widget.userAnswer = text;
                      setState(() {});
                    },
                    keyboardType: TextInputType.multiline,
                    controller: widget.controller,
                    style: const TextStyle(
                        fontSize: 20.0,
                        color: Color.fromRGBO(255, 255, 255, 1),
                        fontWeight: FontWeight.w500),
                    autofocus: false,
                    focusNode: widget.focusNode,
                    maxLines: null,
                    readOnly: false),
              )
            : TextField(
                enableInteractiveSelection: false,
                decoration: const InputDecoration(
                  enabledBorder: InputBorder.none,
                  border: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  focusedErrorBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                ),
                keyboardType: TextInputType.multiline,
                controller: widget.controller,
                style: const TextStyle(
                    fontSize: 20.0,
                    color: Color.fromRGBO(255, 255, 255, 1),
                    fontWeight: FontWeight.w500),
                maxLines: null,
                readOnly: true,
              ));
  }
}
