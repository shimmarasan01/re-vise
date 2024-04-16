import 'package:flutter/material.dart';
import 'package:test/cards.dart';
import 'package:test/headerforselection.dart';
import 'package:test/numericbutton.dart';
import 'package:test/functions.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

// ignore: must_be_immutable
class SelfTestOverlay extends StatefulWidget {
  SelfTestOverlay({super.key});
  late List<Cards> cards;
  late Function hideSelfTestOverlay;
  late List<HeaderForSelection> headersForSelection;
  late bool sequentialMode;
  late List<NumericButton> questionButtons;
  late List<ContextAnswer> caList;
  late List<Question> qList;
  late List<UserAnswerField> uafList;
  late List<int> cardIDOfSelectedHeaders;
  late int currentIndex;
  late bool readyToShowSSPercentage;
  late List<String> percentageOfSSList;
  late bool ssModelRunning;
  late bool readyToShowQuestion;
  late String progress;

  void setQuestionButtons(List<NumericButton> a) {
    questionButtons = a;
  }

  void setCAList(List<ContextAnswer> a) {
    caList = a;
  }

  void setQList(List<Question> a) {
    qList = a;
  }

  void setUAFList(List<UserAnswerField> a) {
    uafList = a;
  }

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

  void setReadyToShowQuestion(bool a) {
    readyToShowQuestion = a;
  }

  void setProgress(String a) {
    progress = a;
  }

  void setCards(List<Cards> a) {
    cards = a;
  }

  void setHeadersForSelection(List<HeaderForSelection> a) {
    headersForSelection = a;
  }

  void setHideSelfTestOverlay(Function a) {
    hideSelfTestOverlay = a;
  }

  void setQuestionMode(bool a) {
    if (a == true) {
      sequentialMode = true;
    } else {
      sequentialMode = false;
    }
  }

  @override
  State<SelfTestOverlay> createState() => _SelfTestOverlayState();
}

class _SelfTestOverlayState extends State<SelfTestOverlay> {
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
    widget.caList = [];
    for (int z = 0; z < mainsToGenerateQuestionsFrom.length; z++) {
      for (int x = 0; x < mainsToGenerateQuestionsFrom[z].length; x++) {
        for (int d = 0;
            d < mainsToGenerateQuestionsFrom[z][x].points.length;
            d++) {
          ContextAnswer ca = ContextAnswer();
          ca.setContext(
              "${mainsToGenerateQuestionsFrom[z][x].main}, ${mainsToGenerateQuestionsFrom[z][x].points[d].point}");
          ca.setAnswer(mainsToGenerateQuestionsFrom[z][x].points[d].point);
          widget.caList.add(ca);
        }
      }
    }
    widget.qList = [];
    widget.uafList = [];
    String currentQuestion = "";
    String totalQuestion = widget.caList.length.toString();
    for (int r = 0; r < widget.caList.length; r++) {
      currentQuestion = (r + 1).toString();
      widget.progress = "$currentQuestion/$totalQuestion";
      setState(() {});
      Question q = Question();
      q.setQuestion(
          await runQGModel(widget.caList[r].context, widget.caList[r].answer));
      widget.qList.add(q);
      UserAnswerField uaf = UserAnswerField();
      uaf.setController(TextEditingController());
      uaf.setFocusNode(FocusNode());
      uaf.setUserAnswer("");
      uaf.setContainerColor(const Color.fromRGBO(121, 85, 72, 1));
      uaf.setShowHint(false);
      uaf.setActualAnswer(widget.caList[r].answer);
      uaf.setResetPercentage(resetPercentage);
      widget.uafList.add(uaf);
      widget.percentageOfSSList.add("");
    }
    if (widget.sequentialMode == false) {
      final indices = List.generate(widget.qList.length, (index) => index)
        ..shuffle();
      widget.caList = indices.map((i) => widget.caList[i]).toList();
      widget.qList = indices.map((i) => widget.qList[i]).toList();
      widget.uafList = indices.map((i) => widget.uafList[i]).toList();
    }
    buildNumericButton(widget.currentIndex);
    widget.readyToShowQuestion = true;
    setState(() {});
  }

  void resetPercentage(bool a) {
    if (widget.ssModelRunning == false) {
      if (a == true) {
        List<String> x = widget.percentageOfSSList;
        for (int i = 0; i < widget.qList.length; i++) {
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
    for (int i = 0; i < widget.qList.length; i++) {
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
      for (int d = 0; d < widget.qList.length; d++) {
        NumericButton numericButtons = NumericButton();
        numericButtons.setNumericButtonIndex(d);
        numericButtons.setBuildNumericButtons(buildNumericButton);
        if (d == widget.currentIndex) {
          numericButtons.setBorderColor(const Color.fromRGBO(255, 255, 255, 1));
        } else {
          numericButtons.setBorderColor(const Color.fromRGBO(0, 0, 0, 0));
        }
        if (d == widget.qList.length - 1) {
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
    for (int d = 0; d < widget.qList.length; d++) {
      UserAnswerField uaf = UserAnswerField();
      uaf.setController(widget.uafList[d].controller);
      uaf.setFocusNode(widget.uafList[d].focusNode);
      uaf.setUserAnswer(widget.uafList[d].userAnswer);
      uaf.setActualAnswer(widget.uafList[d].actualAnswer);
      uaf.setResetPercentage(resetPercentage);
      uaf.setContainerColor(widget.uafList[d].containerColor);
      if (d == widget.currentIndex) {
        uaf.setShowHint(a);
      } else {
        uaf.setShowHint(false);
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
                      child: widget.readyToShowQuestion == false
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text("",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 25,
                                              color: Color.fromRGBO(
                                                  255, 255, 255, 1))),
                                      SizedBox(
                                        width: 45,
                                        child: FloatingActionButton(
                                            elevation: 0,
                                            backgroundColor:
                                                const Color.fromRGBO(
                                                    0, 150, 136, 1),
                                            shape: const RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10))),
                                            onPressed: () {
                                              widget.hideSelfTestOverlay();
                                            },
                                            child: const Icon(
                                                color: Color.fromRGBO(
                                                    255, 255, 255, 1),
                                                size: 25,
                                                MaterialCommunityIcons.close)),
                                      )
                                    ],
                                  ),
                                ),
                                Expanded(
                                  flex: 11,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const SizedBox(
                                        width: 60,
                                        height: 60,
                                        child: CircularProgressIndicator(
                                          valueColor: AlwaysStoppedAnimation<
                                                  Color>(
                                              Color.fromRGBO(255, 255, 255, 1)),
                                          strokeWidth: 8.0,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 50,
                                      ),
                                      SizedBox(
                                        child: Text(widget.progress,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 25,
                                                color: Color.fromRGBO(
                                                    255, 255, 255, 1))),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            )
                          : Column(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text("Self-testing",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 25,
                                              color: Color.fromRGBO(
                                                  255, 255, 255, 1))),
                                      SizedBox(
                                        width: 45,
                                        child: FloatingActionButton(
                                            elevation: 0,
                                            backgroundColor:
                                                const Color.fromRGBO(
                                                    0, 150, 136, 1),
                                            shape: const RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10))),
                                            onPressed: () {
                                              widget.hideSelfTestOverlay();
                                            },
                                            child: const Icon(
                                                color: Color.fromRGBO(
                                                    255, 255, 255, 1),
                                                size: 25,
                                                MaterialCommunityIcons.close)),
                                      )
                                    ],
                                  ),
                                ),
                                Expanded(
                                  flex: 10,
                                  child: Container(
                                      margin: const EdgeInsets.only(
                                          top: 20, bottom: 20),
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
                                                  scrollDirection:
                                                      Axis.vertical,
                                                  child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: widget
                                                          .questionButtons),
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
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Expanded(
                                                      flex: 1,
                                                      child: Container(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                bottom: 30),
                                                        child: SizedBox(
                                                          child: Row(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Expanded(
                                                                flex: 10,
                                                                child:
                                                                    Container(
                                                                  alignment:
                                                                      Alignment
                                                                          .centerLeft,
                                                                  child:
                                                                      SingleChildScrollView(
                                                                    scrollDirection:
                                                                        Axis.horizontal,
                                                                    child: widget
                                                                            .qList[
                                                                        widget
                                                                            .currentIndex],
                                                                  ),
                                                                ),
                                                              ),
                                                              Expanded(
                                                                flex: 1,
                                                                child: Container(
                                                                    padding: const EdgeInsets.only(left: 40),
                                                                    alignment: Alignment.center,
                                                                    child: widget.readyToShowSSPercentage == false
                                                                        ? const SizedBox(
                                                                            width:
                                                                                15,
                                                                            height:
                                                                                15,
                                                                            child:
                                                                                CircularProgressIndicator(
                                                                              valueColor: AlwaysStoppedAnimation<Color>(Color.fromRGBO(255, 255, 255, 1)),
                                                                              strokeWidth: 3.0,
                                                                            ),
                                                                          )
                                                                        : Text(widget.percentageOfSSList[widget.currentIndex], style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16, color: Color.fromRGBO(255, 255, 255, 1)))),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 4,
                                                      child: SizedBox(
                                                          child: widget.uafList[
                                                              widget
                                                                  .currentIndex]),
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
                                              splashFactory:
                                                  NoSplash.splashFactory,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 16.0,
                                                      vertical: 12.0),
                                              backgroundColor:
                                                  const Color.fromRGBO(
                                                      63, 81, 181, 1),
                                            ),
                                            child: const Text(
                                              'Hint',
                                              style: TextStyle(
                                                color: Color.fromRGBO(
                                                    255, 255, 255, 1),
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
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 16.0,
                                                vertical: 12.0),
                                            backgroundColor:
                                                const Color.fromRGBO(
                                                    0, 150, 136, 1),
                                          ),
                                          child: const Text(
                                            'Check',
                                            style: TextStyle(
                                              color: Color.fromRGBO(
                                                  255, 255, 255, 1),
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
                      child: widget.readyToShowQuestion == false
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text("",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 25,
                                              color: Color.fromRGBO(
                                                  255, 255, 255, 1))),
                                      SizedBox(
                                        width: 45,
                                        child: FloatingActionButton(
                                            elevation: 0,
                                            backgroundColor:
                                                const Color.fromRGBO(
                                                    0, 150, 136, 1),
                                            shape: const RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10))),
                                            onPressed: () {
                                              widget.hideSelfTestOverlay();
                                            },
                                            child: const Icon(
                                                color: Color.fromRGBO(
                                                    255, 255, 255, 1),
                                                size: 25,
                                                MaterialCommunityIcons.close)),
                                      )
                                    ],
                                  ),
                                ),
                                Expanded(
                                  flex: 21,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const SizedBox(
                                        width: 60,
                                        height: 60,
                                        child: CircularProgressIndicator(
                                          valueColor: AlwaysStoppedAnimation<
                                                  Color>(
                                              Color.fromRGBO(255, 255, 255, 1)),
                                          strokeWidth: 8.0,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 50,
                                      ),
                                      SizedBox(
                                        child: Text(widget.progress,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 25,
                                                color: Color.fromRGBO(
                                                    255, 255, 255, 1))),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            )
                          : Column(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text("Self-testing",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 25,
                                              color: Color.fromRGBO(
                                                  255, 255, 255, 1))),
                                      SizedBox(
                                        width: 45,
                                        child: FloatingActionButton(
                                            elevation: 0,
                                            backgroundColor:
                                                const Color.fromRGBO(
                                                    0, 150, 136, 1),
                                            shape: const RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10))),
                                            onPressed: () {
                                              widget.hideSelfTestOverlay();
                                            },
                                            child: const Icon(
                                                color: Color.fromRGBO(
                                                    255, 255, 255, 1),
                                                size: 25,
                                                MaterialCommunityIcons.close)),
                                      )
                                    ],
                                  ),
                                ),
                                Expanded(
                                  flex: 20,
                                  child: Container(
                                      margin: const EdgeInsets.only(
                                          top: 20, bottom: 20),
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
                                                  scrollDirection:
                                                      Axis.vertical,
                                                  child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: widget
                                                          .questionButtons),
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
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Expanded(
                                                      flex: 1,
                                                      child: Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(top: 16),
                                                        child: SizedBox(
                                                          child: Row(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Expanded(
                                                                flex: 10,
                                                                child:
                                                                    SingleChildScrollView(
                                                                  scrollDirection:
                                                                      Axis.horizontal,
                                                                  child: widget
                                                                          .qList[
                                                                      widget
                                                                          .currentIndex],
                                                                ),
                                                              ),
                                                              Expanded(
                                                                flex: 2,
                                                                child: Container(
                                                                    margin: const EdgeInsets.only(top: 4),
                                                                    padding: const EdgeInsets.only(left: 30),
                                                                    height: 20,
                                                                    width: 45,
                                                                    alignment: Alignment.center,
                                                                    child: widget.readyToShowSSPercentage == false
                                                                        ? const SizedBox(
                                                                            width:
                                                                                15,
                                                                            height:
                                                                                15,
                                                                            child:
                                                                                CircularProgressIndicator(
                                                                              valueColor: AlwaysStoppedAnimation<Color>(Color.fromRGBO(255, 255, 255, 1)),
                                                                              strokeWidth: 3.0,
                                                                            ),
                                                                          )
                                                                        : Text(widget.percentageOfSSList[widget.currentIndex], style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16, color: Color.fromRGBO(255, 255, 255, 1)))),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 13,
                                                      child: SizedBox(
                                                          child: widget.uafList[
                                                              widget
                                                                  .currentIndex]),
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
                                              splashFactory:
                                                  NoSplash.splashFactory,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 16.0,
                                                      vertical: 12.0),
                                              backgroundColor:
                                                  const Color.fromRGBO(
                                                      63, 81, 181, 1),
                                            ),
                                            child: const Text(
                                              'Hint',
                                              style: TextStyle(
                                                color: Color.fromRGBO(
                                                    255, 255, 255, 1),
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
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 16.0,
                                                vertical: 12.0),
                                            backgroundColor:
                                                const Color.fromRGBO(
                                                    0, 150, 136, 1),
                                          ),
                                          child: const Text(
                                            'Check',
                                            style: TextStyle(
                                              color: Color.fromRGBO(
                                                  255, 255, 255, 1),
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
class Question extends StatefulWidget {
  Question({super.key});
  late String question;
  void setQuestion(String a) {
    question = a;
  }

  @override
  State<Question> createState() => _QuestionState();
}

class _QuestionState extends State<Question> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
        textAlign: TextAlign.center,
        widget.question,
        style: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 20,
            color: Color.fromRGBO(255, 255, 255, 1)));
  }
}

// ignore: must_be_immutable
class UserAnswerField extends StatefulWidget {
  UserAnswerField({super.key});
  late String actualAnswer;
  late String userAnswer;
  late bool showHint;
  late Function resetPercentage;
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

  void setActualAnswer(String a) {
    actualAnswer = a;
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

class ContextAnswer {
  late String context;
  late String answer;
  void setContext(String a) {
    context = a;
  }

  void setAnswer(String a) {
    answer = a;
  }
}
