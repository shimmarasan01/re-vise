import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'dart:convert';
import 'package:test/cards.dart';
import 'package:test/mainoverlay.dart';
import 'package:test/selftestoverlay.dart';
import 'package:test/helpoverlay.dart';
import 'package:test/selfexplainoverlay.dart';
import 'package:test/functions.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:file_picker/file_picker.dart';

// ignore: must_be_immutable
class Workspace extends StatefulWidget {
  Workspace({
    super.key,
  });

  List<Cards> cards = [];
  int counterForCard = 0;
  int counterForMain = 0;
  int counterForPoint = 0;
  int selectedCard = 0;
  int selectedMain = 0;
  String workspaceTitle = "";

  String pdfBase64STORAGE = "";
  bool canShowFileSTORAGE = false;
  bool nonPDFSTORAGE = false;
  bool fromYouTubeSTORAGE = false;
  String statusForAudio2TextSTORAGE = "";
  String titleForAudio2TextSTORAGE = "";
  bool circularForAudio2TextSTORAGE = false;
  String audio2TextTextFieldTextSTORAGE = "";

  Uint8List pdfbytesFORAFTERFIREBASELOAD = Uint8List(0);

  setpdfBytesSTORAGE(String a) {
    pdfbytesFORAFTERFIREBASELOAD = Uint8List(0);
  }

  setcanShowFileSTORAGE(bool a) {
    canShowFileSTORAGE = a;
  }

  setnonPDFSTORAGE(bool a) {
    nonPDFSTORAGE = a;
  }

  setfromYouTubeSTORAGE(bool a) {
    fromYouTubeSTORAGE = a;
  }

  setstatusForAudio2TextSTORAGE(String a) {
    statusForAudio2TextSTORAGE = a;
  }

  settitleForAudio2TextSTORAGE(String a) {
    titleForAudio2TextSTORAGE = a;
  }

  setcircularForAudio2TextSTORAGE(bool a) {
    circularForAudio2TextSTORAGE = a;
  }

  setaudio2TextTextFieldText(String a) {
    audio2TextTextFieldTextSTORAGE = a;
  }

  //

  setCards(List<Cards> a) {
    cards = a;
  }

  setCounterForCard(int a) {
    counterForCard = a;
  }

  setCounterForMain(int a) {
    counterForMain = a;
  }

  setCounterForPoint(int a) {
    counterForPoint = a;
  }

  setSelectedCard(int a) {
    selectedCard = a;
  }

  setSelectedMain(int a) {
    selectedMain = a;
  }

  setWorkspaceTitle(String a) {
    workspaceTitle = a;
  }

  @override
  State<Workspace> createState() => _WorkspaceState();
}

class _WorkspaceState extends State<Workspace> {
  PdfViewerController? _pdfViewerController;
  @override
  void initState() {
    _pdfViewerController = PdfViewerController();
    controllerForWorkspaceTitleTextField.text = widget.workspaceTitle;
    buildCards();
    test();
    super.initState();
  }

  void test() {
    canShowFile = widget.canShowFileSTORAGE;
    nonPDF = widget.nonPDFSTORAGE;
    fromYouTube = widget.fromYouTubeSTORAGE;
    statusForAudio2Text = widget.statusForAudio2TextSTORAGE;
    titleForAudio2Text = widget.titleForAudio2TextSTORAGE;
    circularForAudio2Text = widget.circularForAudio2TextSTORAGE;
    controllerForAudio2TextTextField.text =
        widget.audio2TextTextFieldTextSTORAGE;
    pdfBytes = widget.pdfbytesFORAFTERFIREBASELOAD;
    setState(() {});
  }

  void buildCards() {
    for (int i = 0; i < widget.cards.length; i++) {
      Header header = Header();
      header.setController(TextEditingController());
      header.setFocusNode(FocusNode());
      header.setContainerWidth(widget.cards[i].header.containerWidth);
      header.setCardID(widget.cards[i].header.cardID);
      header.setHeader(widget.cards[i].header.header);
      header.setCardTouched(cardTouched);
      header.setHideCardContent(hideCardContent);
      header.setRebuildCards(rebuildCards);
      Cards card = Cards();
      card.setCardID(widget.cards[i].cardID);
      card.setHeader(header);
      card.setCardTouched(cardTouched);
      card.setRebuildCards(rebuildCards);
      card.setCardBorderColor(widget.cards[i].cardBorderColor);
      card.setIsCardHiding(widget.cards[i].isCardHiding);
      card.setDeleteCard(deleteCard);
      List<Mains> mains = [];
      if (widget.cards[i].mains.isEmpty) {
      } else {
        for (int j = 0; j < widget.cards[i].mains.length; j++) {
          Mains main = Mains();
          main.setController(TextEditingController());
          main.setFocusNode(FocusNode());
          main.setContainerWidth(widget.cards[i].mains[j].containerWidth);
          main.setCardID(widget.cards[i].mains[j].cardID);
          main.setMainID(widget.cards[i].mains[j].mainID);
          main.setMain(widget.cards[i].mains[j].main);
          main.setCardTouched(cardTouched);
          main.setMainTouched(mainTouched);
          main.setMainColor(widget.cards[i].mains[j].mainColor);
          main.setIsMainHiding(widget.cards[i].mains[j].isMainHiding);
          main.setRebuildCards(rebuildCards);
          main.setDeleteMain(deleteMain);
          List<Points> points = [];
          if (widget.cards[i].mains[j].points.isEmpty) {
          } else {
            for (int k = 0; k < widget.cards[i].mains[j].points.length; k++) {
              Points point = Points();
              point.setController(TextEditingController());
              point.setFocusNode(FocusNode());
              point.setContainerWidth(
                  widget.cards[i].mains[j].points[k].containerWidth);
              point.setCardID(widget.cards[i].mains[j].points[k].cardID);
              point.setMainID(widget.cards[i].mains[j].points[k].mainID);
              point.setPointID(widget.cards[i].mains[j].points[k].pointID);
              point.setPoint(widget.cards[i].mains[j].points[k].point);
              point.setDeletePoint(deletePoint);
              point.setRebuildCards(rebuildCards);
              point.setCardTouched(cardTouched);
              point.setMainTouched(mainTouched);
              points.add(point);
            }
          }
          main.setPoint(points);
          mains.add(main);
        }
      }
      card.setMainList(mains);
      if (i == widget.cards.length - 1) {
        card.setCardBottomMargin(0);
      } else {
        card.setCardBottomMargin(11);
      }
      widget.cards[i] = card;
    }
    setState(() {});
  }

  List<Cards> returnCards() {
    return widget.cards;
  }

  void createNewCard(String a) {
    String processedText1 = a.replaceAll("\n", " ");
    String processedText2 = processedText1.trim();
    Header header = Header();
    header.setController(TextEditingController());
    header.setFocusNode(FocusNode());
    header.setContainerWidth(getTextWidth(processedText2));
    header.setCardID(widget.counterForCard);
    header.setHeader(processedText2);
    header.setCardTouched(cardTouched);
    header.setHideCardContent(hideCardContent);
    header.setRebuildCards(rebuildCards);
    Cards card = Cards();
    card.setCardID(widget.counterForCard);
    card.setHeader(header);
    card.setCardTouched(cardTouched);
    card.setRebuildCards(rebuildCards);
    card.setCardBorderColor(const Color.fromRGBO(0, 150, 136, 1));
    card.setMainList([]);
    card.setIsCardHiding(false);
    card.setDeleteCard(deleteCard);
    widget.cards.add(card);
    cardTouched(widget.counterForCard);
    widget.counterForCard = widget.counterForCard + 1;
    rebuildCards();
    scrollNotesToTheEnd();
  }

  void createNewMain(String b) {
    if (widget.cards.isNotEmpty) {
      String processedText1 = b.replaceAll("\n", " ");
      String processedText2 = processedText1.trim();
      Mains main = Mains();
      main.setContainerWidth(getTextWidth(processedText2));
      int a = 0;
      for (int i = 0; i < widget.cards.length; i++) {
        if (widget.cards[i].cardID == widget.selectedCard) {
          a = i;
        }
      }
      main.setController(TextEditingController());
      main.setFocusNode(FocusNode());
      main.setCardID(widget.selectedCard);
      main.setMainID(widget.counterForMain);
      main.setMain(processedText2);
      main.setCardTouched(cardTouched);
      main.setMainTouched(mainTouched);
      main.setMainColor(const Color.fromRGBO(233, 30, 99, 1));
      main.setIsMainHiding(false);
      main.setRebuildCards(rebuildCards);
      main.setDeleteMain(deleteMain);
      main.setPoint([]);
      List<Mains> oldMains = widget.cards[a].getMainsAsList();
      oldMains.add(main);
      widget.cards[a].setMainList(oldMains);
      mainTouched(widget.counterForMain);
      widget.counterForMain = widget.counterForMain + 1;
      rebuildCards();
      scrollNotesToTheEnd();
    }
  }

  void createNewSupporting(String c) {
    int a = 0;
    int b = 0;
    for (int i = 0; i < widget.cards.length; i++) {
      for (int j = 0; j < widget.cards[i].mains.length; j++) {
        if (widget.cards[i].cardID == widget.selectedCard &&
            widget.cards[i].mains[j].mainID == widget.selectedMain) {
          a = i;
          b = j;
        }
      }
    }
    if (widget.cards.isNotEmpty && widget.cards[a].mains.isNotEmpty) {
      String processedText1 = c.replaceAll("\n", " ");
      String processedText2 = processedText1.trim();
      Points point = Points();
      point.setController(TextEditingController());
      point.setFocusNode(FocusNode());
      point.setContainerWidth(getTextWidth(processedText2));
      point.setCardID(widget.selectedCard);
      point.setMainID(widget.selectedMain);
      point.setPointID(widget.counterForPoint);
      point.setPoint(processedText2);
      point.setDeletePoint(deletePoint);
      point.setRebuildCards(rebuildCards);
      point.setCardTouched(cardTouched);
      point.setMainTouched(mainTouched);
      List<Points> oldPoints = widget.cards[a].mains[b].getPointsAsList();
      oldPoints.add(point);
      widget.cards[a].mains[b].setPoint(oldPoints);
      widget.counterForPoint = widget.counterForPoint + 1;
      rebuildCards();
      scrollNotesToTheEnd();
    }
  }

  void deleteCard(int cardID) {
    int? cardIndex;
    for (int i = 0; i < widget.cards.length; i++) {
      if (widget.cards[i].cardID == cardID) {
        cardIndex = i;
      }
    }
    if (widget.cards[cardIndex!].cardID == widget.selectedCard) {
      if (widget.cards.length == 1) {
      } else {
        if (cardIndex == 0) {
          cardTouched(widget.cards[1].cardID);
        } else {
          cardTouched(widget.cards[0].cardID);
        }
      }
    }
    widget.cards[cardIndex].header.focusNode.unfocus();
    widget.cards.removeAt(cardIndex);
    rebuildCards();
  }

  void deleteMain(int cardID, int mainID) {
    late int cardIndex;
    late int mainIndex;
    for (int i = 0; i < widget.cards.length; i++) {
      if (widget.cards[i].cardID == cardID) {
        for (int j = 0; j < widget.cards[i].mains.length; j++) {
          if (widget.cards[i].mains[j].mainID == mainID) {
            cardIndex = i;
            mainIndex = j;
          }
        }
      }
    }
    if (widget.cards[cardIndex].mains[mainIndex].mainID ==
        widget.selectedMain) {
      if (widget.cards[cardIndex].mains.length == 1) {
      } else {
        if (mainIndex == 0) {
          mainTouched(widget.cards[cardIndex].mains[1].mainID);
        } else {
          mainTouched(widget.cards[cardIndex].mains[0].mainID);
        }
      }
    }
    widget.cards[cardIndex].mains[mainIndex].focusNode.unfocus();
    widget.cards[cardIndex].mains.removeAt(mainIndex);
    rebuildCards();
  }

  void deletePoint(int cardID, int mainID, int pointID) {
    late int cardIndex;
    late int mainIndex;
    late int pointIndex;
    for (int i = 0; i < widget.cards.length; i++) {
      if (widget.cards[i].cardID == cardID) {
        for (int j = 0; j < widget.cards[i].mains.length; j++) {
          if (widget.cards[i].mains[j].mainID == mainID) {
            for (int k = 0; k < widget.cards[i].mains[j].points.length; k++) {
              if (widget.cards[i].mains[j].points[k].pointID == pointID) {
                cardIndex = i;
                mainIndex = j;
                pointIndex = k;
              }
            }
          }
        }
      }
    }
    widget.cards[cardIndex].mains[mainIndex].points[pointIndex].focusNode
        .unfocus();
    widget.cards[cardIndex].mains[mainIndex].points.removeAt(pointIndex);
    rebuildCards();
  }

  void hideCardContent(int cardID) {
    int cardToHide = cardID;
    for (int i = 0; i < widget.cards.length; i++) {
      if (widget.cards[i].header.cardID == cardToHide) {
        if (widget.cards[i].isCardHiding == true) {
          widget.cards[i].setIsCardHiding(false);
        } else if (widget.cards[i].isCardHiding == false) {
          if (widget.cards[i].mains.isEmpty) {
            widget.cards[i].setIsCardHiding(false);
          } else {
            if (widget.selectedCard == cardToHide) {
              widget.cards[i].setIsCardHiding(true);
            } else {
              widget.cards[i].setIsCardHiding(false);
            }
          }
        }
      }
    }
    rebuildCards();
  }

  void cardTouched(int cardID) {
    widget.selectedCard = cardID;
    for (int i = 0; i < widget.cards.length; i++) {
      if (widget.cards[i].cardID == widget.selectedCard) {
        widget.cards[i]
            .setCardBorderColor(const Color.fromRGBO(255, 255, 255, 1));
      } else {
        widget.cards[i]
            .setCardBorderColor(const Color.fromRGBO(0, 150, 136, 1));
      }
    }
    rebuildCards();
  }

  void mainTouched(int mainID) {
    widget.selectedMain = mainID;
    for (int i = 0; i < widget.cards.length; i++) {
      List<Mains> mainsCopy = [];
      for (int j = 0; j < widget.cards[i].mains.length; j++) {
        if (widget.cards[i].mains[j].mainID == widget.selectedMain) {
          widget.cards[i].mains[j]
              .setMainColor(const Color.fromRGBO(233, 30, 99, 1));
        } else {
          widget.cards[i].mains[j]
              .setMainColor(const Color.fromARGB(255, 210, 119, 150));
        }
        mainsCopy.add(widget.cards[i].mains[j]);
      }
      widget.cards[i].setMainList(mainsCopy);
    }
    rebuildCards();
  }

  void rebuildCards() {
    for (int i = 0; i < widget.cards.length; i++) {
      Header header = Header();
      header.setController(widget.cards[i].header.controller);
      header.setFocusNode(widget.cards[i].header.focusNode);
      header.setContainerWidth(widget.cards[i].header.containerWidth);
      header.setCardID(widget.cards[i].header.cardID);
      header.setHeader(widget.cards[i].header.header);
      header.setCardTouched(cardTouched);
      header.setHideCardContent(hideCardContent);
      header.setRebuildCards(rebuildCards);
      Cards card = Cards();
      card.setCardID(widget.cards[i].cardID);
      card.setHeader(widget.cards[i].header);
      card.setCardTouched(cardTouched);
      card.setRebuildCards(rebuildCards);
      card.setCardBorderColor(widget.cards[i].cardBorderColor);
      card.setIsCardHiding(widget.cards[i].isCardHiding);
      card.setDeleteCard(deleteCard);
      List<Mains> fucks = [];
      if (widget.cards[i].mains.isEmpty) {
      } else {
        for (int j = 0; j < widget.cards[i].mains.length; j++) {
          Mains main = Mains();
          main.setController(widget.cards[i].mains[j].controller);
          main.setFocusNode(widget.cards[i].mains[j].focusNode);
          main.setContainerWidth(widget.cards[i].mains[j].containerWidth);
          main.setCardID(widget.cards[i].mains[j].cardID);
          main.setMainID(widget.cards[i].mains[j].mainID);
          main.setMain(widget.cards[i].mains[j].main);
          main.setCardTouched(cardTouched);
          main.setMainTouched(mainTouched);
          main.setMainColor(widget.cards[i].mains[j].mainColor);
          main.setIsMainHiding(widget.cards[i].mains[j].isMainHiding);
          main.setRebuildCards(rebuildCards);
          main.setDeleteMain(deleteMain);
          List<Points> soo = [];
          if (widget.cards[i].mains[j].points.isEmpty) {
          } else {
            for (int k = 0; k < widget.cards[i].mains[j].points.length; k++) {
              Points point = Points();
              point
                  .setController(widget.cards[i].mains[j].points[k].controller);
              point.setFocusNode(widget.cards[i].mains[j].points[k].focusNode);
              point.setContainerWidth(
                  widget.cards[i].mains[j].points[k].containerWidth);
              point.setCardID(widget.cards[i].mains[j].points[k].cardID);
              point.setMainID(widget.cards[i].mains[j].points[k].mainID);
              point.setPointID(widget.cards[i].mains[j].points[k].pointID);
              point.setPoint(widget.cards[i].mains[j].points[k].point);
              point.setDeletePoint(deletePoint);
              point.setRebuildCards(rebuildCards);
              point.setCardTouched(cardTouched);
              point.setMainTouched(mainTouched);
              soo.add(point);
            }
          }
          main.setPoint(soo);
          fucks.add(main);
        }
      }
      card.setMainList(fucks);
      if (i == widget.cards.length - 1) {
        card.setCardBottomMargin(0);
      } else {
        card.setCardBottomMargin(11);
      }
      widget.cards[i] = card;
    }
    setState(() {});
  }

  closeAllCards() {
    if (widget.cards.isNotEmpty) {
      for (int i = 0; i < widget.cards.length; i++) {
        widget.cards[i].setIsCardHiding(true);
        if (widget.cards[i].cardID == widget.selectedCard) {
          widget.cards[i]
              .setCardBorderColor(const Color.fromRGBO(255, 255, 255, 1));
        } else {
          widget.cards[i]
              .setCardBorderColor(const Color.fromRGBO(0, 150, 136, 1));
        }
      }
      rebuildCards();
    } else {}
  }

  showLastEditedCard() {
    if (widget.cards.isNotEmpty) {
      for (int i = 0; i < widget.cards.length; i++) {
        for (int j = 0; j < widget.cards[i].mains.length; j++) {
          if (widget.cards[i].mains[j].mainID == widget.selectedMain) {
            widget.cards[i]
                .setCardBorderColor(const Color.fromRGBO(255, 255, 255, 1));
            widget.cards[i].setIsCardHiding(false);
            widget.selectedCard = widget.cards[i].cardID;
          } else {
            widget.cards[i]
                .setCardBorderColor(const Color.fromRGBO(0, 150, 136, 1));
            widget.cards[i].setIsCardHiding(true);
          }
        }
      }
      rebuildCards();
    } else {}
  }

  OverlayEntry? overlayEntryForNoteSelection;

  void showNoteSelectionOverlay(
      BuildContext context, PdfTextSelectionChangedDetails details) {
    final OverlayState overlayState = Overlay.of(context);
    overlayEntryForNoteSelection = OverlayEntry(
      builder: (context) => Positioned(
        top: details.globalSelectedRegion!.center.dy - 80,
        left: details.globalSelectedRegion!.bottomLeft.dx,
        child: Row(children: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                elevation: 10,
                backgroundColor: const Color.fromRGBO(255, 193, 7, 1),
                foregroundColor: const Color.fromRGBO(0, 0, 0, 1)),
            onPressed: () {
              Clipboard.setData(ClipboardData(text: details.selectedText!));
              createNewCard(details.selectedText.toString());
              _pdfViewerController?.clearSelection();
            },
            child: const Text('Header', style: TextStyle(fontSize: 17)),
          ),
          const SizedBox(width: 10),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                elevation: 10,
                backgroundColor: const Color.fromRGBO(233, 30, 99, 1),
                foregroundColor: const Color.fromRGBO(255, 255, 255, 1)),
            onPressed: () {
              Clipboard.setData(ClipboardData(text: details.selectedText!));
              createNewMain(details.selectedText.toString());
              _pdfViewerController?.clearSelection();
            },
            child: const Text('Main', style: TextStyle(fontSize: 17)),
          ),
          const SizedBox(width: 10),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                elevation: 10,
                backgroundColor: const Color.fromRGBO(63, 81, 181, 1),
                foregroundColor: const Color.fromRGBO(255, 255, 255, 1)),
            onPressed: () {
              Clipboard.setData(ClipboardData(text: details.selectedText!));
              createNewSupporting(details.selectedText.toString());
              _pdfViewerController?.clearSelection();
            },
            child: const Text('Supporting', style: TextStyle(fontSize: 17)),
          ),
          const SizedBox(width: 10),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                elevation: 10,
                backgroundColor: const Color.fromRGBO(0, 0, 0, 1),
                foregroundColor: const Color.fromRGBO(255, 255, 255, 1)),
            onPressed: () {
              Clipboard.setData(ClipboardData(text: details.selectedText!));
              _pdfViewerController?.clearSelection();
            },
            child: const Text('Copy', style: TextStyle(fontSize: 17)),
          ),
        ]),
      ),
    );
    overlayState.insert(overlayEntryForNoteSelection!);
  }

  late OverlayEntry overlayEntryForMainOverlay;
  MainOverlay mainOverlay = MainOverlay();

  void showMainOverlay(BuildContext context, int nextOverlay) {
    if (widget.cards.isNotEmpty) {
      mainOverlay = MainOverlay();
      mainOverlay.setCards(widget.cards);
      mainOverlay.setHeadersForSelection();
      mainOverlay.setHideMainOverlay(hideMainOverlay);
      mainOverlay.setIsSequentialSelected(true);
      mainOverlay.setIsRandomisedSelected(false);
      mainOverlay
          .setSequentialBackgroundColor(const Color.fromRGBO(255, 255, 255, 1));
      mainOverlay
          .setSequentialForegroundColor(const Color.fromRGBO(121, 85, 72, 1));
      mainOverlay
          .setRandomisedBackgroundColor(const Color.fromRGBO(121, 85, 72, 1));
      mainOverlay
          .setRandomisedForegroundColor(const Color.fromRGBO(255, 255, 255, 1));
      if (nextOverlay == 1) {
        mainOverlay.setShowNextOverlay(showSelfTestOverlay);
        mainOverlay.setTaskName("Self-testing");
      } else if (nextOverlay == 2) {
        mainOverlay.setShowNextOverlay(showSelfExplainOverlay);
        mainOverlay.setTaskName("Self-explaining");
      }
      overlayEntryForMainOverlay = OverlayEntry(
        builder: (BuildContext context) {
          return mainOverlay;
        },
      );
      Overlay.of(context).insert(overlayEntryForMainOverlay);
    }
  }

  void hideMainOverlay() {
    overlayEntryForMainOverlay.remove();
  }

  late OverlayEntry overlayEntryForSelfTestOverlay;
  SelfTestOverlay selfTestOverlay = SelfTestOverlay();

  void showSelfTestOverlay(BuildContext context) {
    selfTestOverlay = SelfTestOverlay();
    selfTestOverlay.setCards(widget.cards);
    selfTestOverlay
        .setHeadersForSelection(mainOverlay.getHeadersForSelection());
    selfTestOverlay.setQuestionMode(mainOverlay.getSequentialMode());
    selfTestOverlay.setHideSelfTestOverlay(hideSelfTestOverlay);
    selfTestOverlay.setQuestionButtons([]);
    selfTestOverlay.setCAList([]);
    selfTestOverlay.setQList([]);
    selfTestOverlay.setUAFList([]);
    selfTestOverlay.setCardIDOfSelectedHeaders([]);
    selfTestOverlay.setCurrentIndex(0);
    selfTestOverlay.setReadyToShowSSPercentage(true);
    selfTestOverlay.setPercentageOfSSList([]);
    selfTestOverlay.setSSModelRunning(false);
    selfTestOverlay.setReadyToShowQuestion(false);
    selfTestOverlay.setProgress("");
    overlayEntryForSelfTestOverlay = OverlayEntry(
      builder: (BuildContext context) {
        return selfTestOverlay;
      },
    );
    Overlay.of(context).insert(overlayEntryForSelfTestOverlay);
  }

  void hideSelfTestOverlay() {
    overlayEntryForSelfTestOverlay.remove();
  }

  late OverlayEntry overlayEntryForSelfExplainOverlay;
  SelfExplainOverlay selfExplainOverlay = SelfExplainOverlay();

  void showSelfExplainOverlay(BuildContext context) {
    selfExplainOverlay = SelfExplainOverlay();
    selfExplainOverlay.setCards(widget.cards);
    selfExplainOverlay
        .setHeadersForSelection(mainOverlay.getHeadersForSelection());
    selfExplainOverlay.setQuestionMode(mainOverlay.getSequentialMode());
    selfExplainOverlay.setHideSelfExplainOverlay(hideSelfExplainOverlay);
    selfExplainOverlay.setQuestionButtons([]);
    selfExplainOverlay.setHMList([]);
    selfExplainOverlay.setUAFList([]);
    selfExplainOverlay.setCardIDOfSelectedHeaders([]);
    selfExplainOverlay.setCurrentIndex(0);
    selfExplainOverlay.setReadyToShowSSPercentage(true);
    selfExplainOverlay.setPercentageOfSSList([]);
    selfExplainOverlay.setSSModelRunning(false);
    overlayEntryForSelfExplainOverlay = OverlayEntry(
      builder: (BuildContext context) {
        return selfExplainOverlay;
      },
    );
    Overlay.of(context).insert(overlayEntryForSelfExplainOverlay);
  }

  void hideSelfExplainOverlay() {
    overlayEntryForSelfExplainOverlay.remove();
  }

  late OverlayEntry overlayEntryForHelpOverlay;
  HelpOverlay helpOverlay = HelpOverlay();

  void showHelpOverlay(BuildContext context) {
    helpOverlay = HelpOverlay();
    helpOverlay.setHideHelpOverlay(hideHelpOverlay);
    overlayEntryForHelpOverlay = OverlayEntry(
      builder: (BuildContext context) {
        return helpOverlay;
      },
    );
    Overlay.of(context).insert(overlayEntryForHelpOverlay);
  }

  void hideHelpOverlay() {
    overlayEntryForHelpOverlay.remove();
  }

  Uint8List pdfBytes = Uint8List(0);
  bool canShowFile = false;
  bool nonPDF = false;
  bool fromYouTube = false;
  String statusForAudio2Text = "";
  String titleForAudio2Text = "";
  bool circularForAudio2Text = false;

  TextEditingController controllerForAudio2TextTextField =
      TextEditingController();
  FocusNode focusNodeForAudio2TextTextField = FocusNode();

  filepicker() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: [
        'pdf',
        'docx',
        'pptx',
        'mp4',
        'mp3',
      ],
    );
    if (result == null) {
    } else {
      if (result.files.single.extension == 'pdf') {
        pdfBytes = await File(result.files.single.path!).readAsBytes();
        widget.pdfBase64STORAGE = "NOTHING";
        widget.canShowFileSTORAGE = false;
        widget.nonPDFSTORAGE = false;
        canShowFile = true;
        nonPDF = false;
        setState(() {});
      } else if (result.files.single.extension == 'mp3') {
        titleForAudio2Text = result.files.single.name;
        fromYouTube = false;
        canShowFile = true;
        nonPDF = true;
        controllerForAudio2TextTextField.text = "";
        circularForAudio2Text = true;
        int file2audioPercentage = 0;
        statusForAudio2Text = "$file2audioPercentage%";
        setState(() {});
        Uint8List audioData =
            await File(result.files.single.path!).readAsBytes();
        List<String> base64StringList = audioBytesToBase64(audioData);
        for (int i = 0; i < base64StringList.length; i++) {
          String text = await runSRModel(base64StringList[i]);
          file2audioPercentage =
              (((i + 1) / base64StringList.length) * 100).toInt();
          statusForAudio2Text = "$file2audioPercentage%";
          controllerForAudio2TextTextField.text =
              controllerForAudio2TextTextField.text + text;
          setState(() {});
        }
        circularForAudio2Text = false;
        statusForAudio2Text = "Local storage";
        widget.pdfBase64STORAGE = "";
        widget.canShowFileSTORAGE = true;
        widget.nonPDFSTORAGE = true;
        widget.fromYouTubeSTORAGE = false;
        widget.statusForAudio2TextSTORAGE = statusForAudio2Text;
        widget.titleForAudio2TextSTORAGE = titleForAudio2Text;
        widget.circularForAudio2TextSTORAGE = false;
        widget.audio2TextTextFieldTextSTORAGE =
            controllerForAudio2TextTextField.text;
        setState(() {});
      } else if (result.files.single.extension == 'mp4') {
        titleForAudio2Text = result.files.single.name;
        fromYouTube = false;
        canShowFile = true;
        nonPDF = true;
        controllerForAudio2TextTextField.text = "";
        circularForAudio2Text = true;
        int file2audioPercentage = 0;
        statusForAudio2Text = "Converting";
        setState(() {});
        Uint8List videoData =
            await File(result.files.single.path!).readAsBytes();
        String base64String = base64.encode(videoData);
        String base64OfAudioFromVideo = await runMP42MP3Model(base64String);
        statusForAudio2Text = "$file2audioPercentage%";
        setState(() {});
        Uint8List bytesofAudioFromVideo =
            videoData = base64.decode(base64OfAudioFromVideo);
        List<String> base64StringList =
            audioBytesToBase64(bytesofAudioFromVideo);
        for (int i = 0; i < base64StringList.length; i++) {
          String text = await runSRModel(base64StringList[i]);
          file2audioPercentage =
              (((i + 1) / base64StringList.length) * 100).toInt();
          statusForAudio2Text = "$file2audioPercentage%";
          controllerForAudio2TextTextField.text =
              controllerForAudio2TextTextField.text + text;
          setState(() {});
        }
        circularForAudio2Text = false;
        statusForAudio2Text = "Local storage";
        widget.pdfBase64STORAGE = "";
        widget.canShowFileSTORAGE = true;
        widget.nonPDFSTORAGE = true;
        widget.fromYouTubeSTORAGE = false;
        widget.statusForAudio2TextSTORAGE = statusForAudio2Text;
        widget.titleForAudio2TextSTORAGE = titleForAudio2Text;
        widget.circularForAudio2TextSTORAGE = false;
        widget.audio2TextTextFieldTextSTORAGE =
            controllerForAudio2TextTextField.text;
        setState(() {});
      }
    }
  }

  TextEditingController controllerForYouTubeURLTextField =
      TextEditingController();
  FocusNode focusNodeForYouTubeURLTextField = FocusNode();
  bool showYouTubeURLTextField = false;

  youtube() async {
    String url = "";
    url = controllerForYouTubeURLTextField.text;
    var jsonData = await getDetail(url);
    if (jsonData == null) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Color.fromRGBO(244, 67, 54, 1),
          content: Text("[YouTube] Unauthorised"),
          duration: Duration(seconds: 3),
        ),
      );
    } else {
      titleForAudio2Text = jsonData['title'];
      int youtube2audioPercentage = 0;
      fromYouTube = true;
      canShowFile = true;
      nonPDF = true;
      controllerForAudio2TextTextField.text = "";
      circularForAudio2Text = true;
      statusForAudio2Text = "Downloading";
      setState(() {});
      String base64YTVideo = await runYTModel(url.trim());
      statusForAudio2Text = "$youtube2audioPercentage%";
      setState(() {});
      Uint8List audioData = base64.decode(base64YTVideo);
      List<String> base64StringList = audioBytesToBase64(audioData);
      for (int i = 0; i < base64StringList.length; i++) {
        String x = await runSRModel(base64StringList[i]);
        youtube2audioPercentage =
            (((i + 1) / base64StringList.length) * 100).toInt();
        statusForAudio2Text = "$youtube2audioPercentage%";
        controllerForAudio2TextTextField.text =
            controllerForAudio2TextTextField.text + x;
        setState(() {});
      }
      circularForAudio2Text = false;
      statusForAudio2Text = url.trim();

      widget.pdfBase64STORAGE = "";
      widget.canShowFileSTORAGE = true;
      widget.nonPDFSTORAGE = true;
      widget.fromYouTubeSTORAGE = true;
      widget.statusForAudio2TextSTORAGE = statusForAudio2Text;
      widget.titleForAudio2TextSTORAGE = titleForAudio2Text;
      widget.circularForAudio2TextSTORAGE = false;
      widget.audio2TextTextFieldTextSTORAGE =
          controllerForAudio2TextTextField.text;

      setState(() {});
    }
  }

  ScrollController scrollController = ScrollController();
  scrollNotesToTheEnd() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      scrollController.animateTo(scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 150), curve: Curves.easeIn);
    });
  }

  TextEditingController controllerForWorkspaceTitleTextField =
      TextEditingController();
  FocusNode focusNodeForWorkspaceTitleTextField = FocusNode();

  bool showFloatingButtons = false;
  double topFloatingButtons = 0.0;

  bool showNoteArea = true;

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        return orientation == Orientation.landscape
            ? WillPopScope(
                onWillPop: () async {
                  return true;
                },
                child: Scaffold(
                  //===== APP BAR =====
                  appBar: AppBar(
                    titleSpacing: 0,
                    backgroundColor: const Color.fromRGBO(121, 85, 72, 1),
                    title: Row(
                      children: [
                        const SizedBox(width: 10),
                        Expanded(
                          child: Theme(
                            data: ThemeData(
                              textSelectionTheme: const TextSelectionThemeData(
                                cursorColor: Color.fromRGBO(255, 255, 255, 1),
                                selectionColor:
                                    Color.fromRGBO(255, 255, 255, 0.2),
                              ),
                            ),
                            child: TextField(
                                selectionControls: CustomColorSelectionHandle(
                                    const Color.fromRGBO(0, 0, 0, 0)),
                                magnifierConfiguration:
                                    TextMagnifierConfiguration.disabled,
                                enableInteractiveSelection: true,
                                onTapOutside: (PointerDownEvent a) {
                                  focusNodeForWorkspaceTitleTextField.unfocus();
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
                                  widget.workspaceTitle =
                                      controllerForWorkspaceTitleTextField.text;
                                  setState(() {});
                                },
                                keyboardType: TextInputType.multiline,
                                controller:
                                    controllerForWorkspaceTitleTextField,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 20.0,
                                    color: Color.fromRGBO(255, 255, 255, 1)),
                                focusNode: focusNodeForWorkspaceTitleTextField,
                                maxLines: 1,
                                readOnly: false),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                            child: Container(
                          alignment: Alignment.centerRight,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(7),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 252,
                                    child: Stack(
                                      alignment: Alignment.centerRight,
                                      children: [
                                        AnimatedPositioned(
                                          duration:
                                              const Duration(milliseconds: 250),
                                          curve: Curves.easeInOut,
                                          left: showYouTubeURLTextField == true
                                              ? 0
                                              : 223,
                                          child: Container(
                                            width: 223,
                                            height: 35,
                                            decoration: BoxDecoration(
                                              color: const Color.fromRGBO(
                                                  255, 255, 255, 1),
                                              border: Border.all(
                                                width: 0,
                                                color: const Color.fromRGBO(
                                                    255, 255, 255, 1),
                                              ),
                                              borderRadius:
                                                  const BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(7),
                                                      bottomLeft:
                                                          Radius.circular(7)),
                                            ),
                                            child: Theme(
                                              data: ThemeData(
                                                textSelectionTheme:
                                                    const TextSelectionThemeData(
                                                        cursorColor:
                                                            Color.fromRGBO(
                                                                121, 85, 72, 1),
                                                        selectionColor:
                                                            Color.fromRGBO(121,
                                                                85, 72, 0.2)),
                                              ),
                                              child: TextField(
                                                controller:
                                                    controllerForYouTubeURLTextField,
                                                focusNode:
                                                    focusNodeForYouTubeURLTextField,
                                                onTapOutside:
                                                    (PointerDownEvent a) {
                                                  focusNodeForYouTubeURLTextField
                                                      .unfocus();
                                                },
                                                selectionControls:
                                                    CustomColorSelectionHandle(
                                                        const Color.fromRGBO(
                                                            0, 0, 0, 0)),
                                                magnifierConfiguration:
                                                    TextMagnifierConfiguration
                                                        .disabled,
                                                decoration:
                                                    const InputDecoration(
                                                        enabledBorder:
                                                            InputBorder.none,
                                                        border:
                                                            InputBorder.none,
                                                        disabledBorder:
                                                            InputBorder.none,
                                                        errorBorder:
                                                            InputBorder.none,
                                                        focusedErrorBorder:
                                                            InputBorder.none,
                                                        focusedBorder:
                                                            InputBorder.none,
                                                        contentPadding:
                                                            EdgeInsets.only(
                                                                bottom: 0,
                                                                top: -15,
                                                                left: 7,
                                                                right: 10)),
                                                enableInteractiveSelection:
                                                    true,
                                                keyboardType: TextInputType.url,
                                                style: const TextStyle(
                                                  fontSize: 14,
                                                  color: Color.fromRGBO(
                                                      121, 85, 72, 1),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width: 10,
                                          height: 36,
                                          decoration: const BoxDecoration(
                                            color:
                                                Color.fromRGBO(121, 85, 72, 1),
                                          ),
                                        ),
                                        Container(
                                          alignment: Alignment.center,
                                          width: 35,
                                          child: SizedBox(
                                            width: 35,
                                            height: 35,
                                            child: GestureDetector(
                                              onLongPress: () {
                                                if (showYouTubeURLTextField ==
                                                    false) {
                                                } else {
                                                  youtube();
                                                  setState(() {
                                                    focusNodeForYouTubeURLTextField
                                                        .unfocus();
                                                    showYouTubeURLTextField =
                                                        false;
                                                  });
                                                }
                                              },
                                              child: FloatingActionButton(
                                                heroTag: UniqueKey(),
                                                elevation: 0,
                                                backgroundColor:
                                                    const Color.fromRGBO(
                                                        255, 255, 255, 1),
                                                shape:
                                                    const RoundedRectangleBorder(
                                                        side: BorderSide(
                                                            width: 0,
                                                            color:
                                                                Color.fromRGBO(
                                                                    255,
                                                                    255,
                                                                    255,
                                                                    1)),
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    7))),
                                                onPressed: () {
                                                  setState(() {
                                                    if (showYouTubeURLTextField ==
                                                        false) {
                                                      controllerForYouTubeURLTextField
                                                          .text = "";
                                                      focusNodeForYouTubeURLTextField
                                                          .requestFocus();
                                                      showYouTubeURLTextField =
                                                          true;
                                                    } else {
                                                      controllerForYouTubeURLTextField
                                                          .text = "";
                                                      focusNodeForYouTubeURLTextField
                                                          .unfocus();
                                                      showYouTubeURLTextField =
                                                          false;
                                                    }
                                                  });
                                                },
                                                child: const Icon(
                                                  color: Color.fromRGBO(
                                                      121, 85, 72, 1),
                                                  size: 20,
                                                  MaterialCommunityIcons
                                                      .youtube,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Container(
                                      alignment: Alignment.center,
                                      width: 35,
                                      child: SizedBox(
                                        width: 35,
                                        height: 35,
                                        child: FloatingActionButton(
                                            heroTag: UniqueKey(),
                                            elevation: 0,
                                            backgroundColor:
                                                const Color.fromRGBO(
                                                    255, 255, 255, 1),
                                            shape: const RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(7))),
                                            onPressed: () {
                                              filepicker();
                                            },
                                            child: const Icon(
                                                color: Color.fromRGBO(
                                                    121, 85, 72, 1),
                                                size: 20,
                                                MaterialCommunityIcons
                                                    .file_document)),
                                      )),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Container(
                                      alignment: Alignment.center,
                                      width: 35,
                                      child: SizedBox(
                                        width: 35,
                                        height: 35,
                                        child: FloatingActionButton(
                                            heroTag: UniqueKey(),
                                            elevation: 0,
                                            backgroundColor: Colors.teal,
                                            shape: const RoundedRectangleBorder(
                                                side: BorderSide(
                                                    width: 2,
                                                    color: Colors.white),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(7))),
                                            onPressed: () {
                                              showHelpOverlay(context);
                                            },
                                            child: const Icon(
                                                color: Colors.white,
                                                size: 18,
                                                MaterialCommunityIcons.help)),
                                      )),
                                ],
                              ),
                            ),
                          ),
                        )),
                        const SizedBox(width: 10)
                      ],
                    ),
                  ),
                  //===== APP BAR =====
                  //===== BODY =====
                  body: Row(children: [
                    //===== FILE AREA =====
                    Expanded(
                      flex: 3,
                      child: Stack(
                        children: [
                          Container(
                              padding: canShowFile == true && nonPDF == false
                                  ? const EdgeInsets.all(0)
                                  : const EdgeInsets.all(20),
                              color: const Color.fromRGBO(255, 255, 255, 1),
                              child: canShowFile == true && nonPDF == false
                                  //PDF
                                  ? SfPdfViewer.memory(
                                      pdfBytes,
                                      interactionMode:
                                          PdfInteractionMode.selection,
                                      onTextSelectionChanged:
                                          (PdfTextSelectionChangedDetails
                                              details) {
                                        if (details.selectedText == null &&
                                            overlayEntryForNoteSelection !=
                                                null) {
                                          overlayEntryForNoteSelection!
                                              .remove();
                                          overlayEntryForNoteSelection = null;
                                        } else if (details.selectedText !=
                                                null &&
                                            overlayEntryForNoteSelection ==
                                                null) {
                                          showNoteSelectionOverlay(
                                              context, details);
                                        }
                                      },
                                      controller: _pdfViewerController,
                                    )
                                  : canShowFile == true && nonPDF == true
                                      //AUDIO2TEXT
                                      ? Column(
                                          children: [
                                            //TOP PADDING
                                            //const SizedBox(height: 20),
                                            //TITLE, STATUS, BUTTON...
                                            Flexible(
                                              flex: 4,
                                              child: SizedBox(
                                                height: 76,
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    fromYouTube == true
                                                        ? SizedBox(
                                                            height: 76,
                                                            width: 76,
                                                            child: FloatingActionButton(
                                                                heroTag:
                                                                    UniqueKey(),
                                                                elevation: 0,
                                                                backgroundColor:
                                                                    const Color.fromRGBO(
                                                                        121,
                                                                        85,
                                                                        72,
                                                                        1),
                                                                shape: const RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.all(Radius.circular(
                                                                            0))),
                                                                onPressed: null,
                                                                child: Container(
                                                                    padding:
                                                                        const EdgeInsets.all(
                                                                            0),
                                                                    child: const Icon(
                                                                        color: Color.fromRGBO(255, 255, 255, 1),
                                                                        size: 45,
                                                                        MaterialCommunityIcons.youtube))))
                                                        : SizedBox(height: 76, width: 76, child: FloatingActionButton(elevation: 0, backgroundColor: const Color.fromRGBO(121, 85, 72, 1), shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(0))), onPressed: null, child: Container(padding: const EdgeInsets.all(0), child: const Icon(color: Color.fromRGBO(255, 255, 255, 1), size: 40, MaterialCommunityIcons.file_document)))),
                                                    const Flexible(
                                                        flex: 1,
                                                        child: SizedBox(
                                                            width: 10)),
                                                    Expanded(
                                                        flex: 43,
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Expanded(
                                                                flex: 9,
                                                                child: Container(
                                                                    alignment:
                                                                        Alignment
                                                                            .bottomLeft,
                                                                    child: SingleChildScrollView(
                                                                        scrollDirection:
                                                                            Axis
                                                                                .horizontal,
                                                                        child: Text(
                                                                            titleForAudio2Text,
                                                                            style: const TextStyle(
                                                                                color: Color.fromRGBO(121, 85, 72, 1),
                                                                                fontSize: 25,
                                                                                fontWeight: FontWeight.bold))))),
                                                            const Expanded(
                                                                flex: 1,
                                                                child:
                                                                    Text("")),
                                                            Expanded(
                                                                flex: 7,
                                                                child:
                                                                    Container(
                                                                  alignment:
                                                                      Alignment
                                                                          .topLeft,
                                                                  child:
                                                                      SingleChildScrollView(
                                                                    scrollDirection:
                                                                        Axis.horizontal,
                                                                    child: Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        circularForAudio2Text ==
                                                                                true
                                                                            ? Row(
                                                                                children: const [
                                                                                  SizedBox(width: 1.7),
                                                                                  SizedBox(
                                                                                    height: 10,
                                                                                    width: 10,
                                                                                    child: CircularProgressIndicator(
                                                                                      valueColor: AlwaysStoppedAnimation<Color>(Color.fromRGBO(121, 85, 72, 1)),
                                                                                      strokeWidth: 1.0,
                                                                                    ),
                                                                                  ),
                                                                                  SizedBox(width: 7),
                                                                                ],
                                                                              )
                                                                            : const SizedBox(
                                                                                height: 10,
                                                                              ),
                                                                        Text(
                                                                            statusForAudio2Text,
                                                                            style:
                                                                                const TextStyle(
                                                                              color: Color.fromRGBO(121, 85, 72, 1),
                                                                              fontSize: 15,
                                                                            ))
                                                                      ],
                                                                    ),
                                                                  ),
                                                                )),
                                                          ],
                                                        )),
                                                    const Flexible(
                                                        flex: 1,
                                                        child: SizedBox(
                                                            width: 10)),
                                                    Expanded(
                                                        flex: 15,
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .end,
                                                          children: [
                                                            Flexible(
                                                              child: Container(
                                                                decoration: const BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius.all(
                                                                            Radius.circular(40))),
                                                                child:
                                                                    FloatingActionButton(
                                                                        heroTag:
                                                                            UniqueKey(),
                                                                        elevation:
                                                                            0,
                                                                        backgroundColor: const Color.fromRGBO(
                                                                            121,
                                                                            85,
                                                                            72,
                                                                            1),
                                                                        shape: const RoundedRectangleBorder(
                                                                            borderRadius: BorderRadius.all(Radius.circular(
                                                                                40))),
                                                                        onPressed:
                                                                            () {
                                                                          if (showFloatingButtons ==
                                                                              false) {
                                                                            showFloatingButtons =
                                                                                true;
                                                                          } else {
                                                                            showFloatingButtons =
                                                                                false;
                                                                            topFloatingButtons =
                                                                                500;
                                                                          }
                                                                          setState(
                                                                              () {});
                                                                        },
                                                                        child: Container(
                                                                            padding: const EdgeInsets.all(
                                                                                0),
                                                                            child: showFloatingButtons == true
                                                                                ? const Icon(color: Color.fromRGBO(255, 255, 255, 1), size: 20, MaterialCommunityIcons.note_edit)
                                                                                : const Icon(color: Color.fromRGBO(255, 255, 255, 1), size: 20, MaterialCommunityIcons.note_off))),
                                                              ),
                                                            )
                                                          ],
                                                        ))
                                                  ],
                                                ),
                                              ),
                                            ),
                                            const Flexible(
                                                flex: 1,
                                                child: SizedBox(height: 20)),
                                            //TEXTFIELD
                                            Expanded(
                                              flex: 26,
                                              child: Container(
                                                padding: const EdgeInsets.only(
                                                    top: 5, bottom: 5),
                                                alignment: Alignment.topLeft,
                                                child: Theme(
                                                  data: ThemeData(
                                                    textSelectionTheme:
                                                        const TextSelectionThemeData(
                                                      cursorColor:
                                                          Color.fromRGBO(
                                                              121, 85, 72, 1),
                                                      selectionColor:
                                                          Color.fromRGBO(
                                                              121, 85, 72, 0.2),
                                                    ),
                                                  ),
                                                  child: ScrollConfiguration(
                                                    behavior:
                                                        const CustomScrollBehavior(),
                                                    child: TextField(
                                                        selectionControls:
                                                            CustomColorSelectionHandle(
                                                                const Color.fromRGBO(
                                                                    121,
                                                                    85,
                                                                    72,
                                                                    1)),
                                                        magnifierConfiguration:
                                                            TextMagnifierConfiguration
                                                                .disabled,
                                                        enableInteractiveSelection:
                                                            true,
                                                        onTapOutside:
                                                            (PointerDownEvent
                                                                a) {
                                                          focusNodeForAudio2TextTextField
                                                              .unfocus();
                                                        },
                                                        decoration:
                                                            const InputDecoration(
                                                          // this will remove the default content padding
                                                          isDense: true,
                                                          // now you can customize it here or add padding widget
                                                          contentPadding:
                                                              EdgeInsets.symmetric(
                                                                  //horizontal: 5,
                                                                  vertical: 0),
                                                          enabledBorder:
                                                              InputBorder.none,
                                                          border:
                                                              InputBorder.none,
                                                          disabledBorder:
                                                              InputBorder.none,
                                                          errorBorder:
                                                              InputBorder.none,
                                                          focusedErrorBorder:
                                                              InputBorder.none,
                                                          focusedBorder:
                                                              InputBorder.none,
                                                        ),
                                                        onChanged: (text) {},
                                                        keyboardType:
                                                            TextInputType
                                                                .multiline,
                                                        controller:
                                                            controllerForAudio2TextTextField,
                                                        style: const TextStyle(
                                                            fontSize: 20.0,
                                                            color:
                                                                Color.fromRGBO(
                                                                    121,
                                                                    85,
                                                                    72,
                                                                    1)),
                                                        focusNode:
                                                            focusNodeForAudio2TextTextField,
                                                        maxLines: null,
                                                        readOnly: false),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                                      : Container()),
                          showFloatingButtons == true
                              ? Positioned(
                                  top: topFloatingButtons,
                                  right: 20,
                                  child: Draggable(
                                    feedback: SizedBox(
                                        height: 50,
                                        child: Row(children: [
                                          ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                elevation: 0,
                                                backgroundColor:
                                                    const Color.fromRGBO(
                                                        255, 193, 7, 1),
                                                foregroundColor:
                                                    const Color.fromRGBO(
                                                        0, 0, 0, 1)),
                                            onPressed: () {
                                              final textSelection =
                                                  controllerForAudio2TextTextField
                                                      .selection;
                                              if (!textSelection.isCollapsed) {
                                                final selectedText =
                                                    textSelection.textInside(
                                                        controllerForAudio2TextTextField
                                                            .text);
                                                createNewCard(selectedText);
                                              }
                                            },
                                            child: const Text('Header',
                                                style: TextStyle(fontSize: 17)),
                                          ),
                                          const SizedBox(width: 10),
                                          ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                elevation: 0,
                                                backgroundColor:
                                                    const Color.fromRGBO(
                                                        233, 30, 99, 1),
                                                foregroundColor:
                                                    const Color.fromRGBO(
                                                        255, 255, 255, 1)),
                                            onPressed: () {
                                              final textSelection =
                                                  controllerForAudio2TextTextField
                                                      .selection;
                                              if (!textSelection.isCollapsed) {
                                                final selectedText =
                                                    textSelection.textInside(
                                                        controllerForAudio2TextTextField
                                                            .text);
                                                createNewMain(selectedText);
                                              }
                                            },
                                            child: const Text('Main',
                                                style: TextStyle(fontSize: 17)),
                                          ),
                                          const SizedBox(width: 10),
                                          ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                elevation: 0,
                                                backgroundColor:
                                                    const Color.fromRGBO(
                                                        63, 81, 181, 1),
                                                foregroundColor:
                                                    const Color.fromRGBO(
                                                        255, 255, 255, 1)),
                                            onPressed: () {
                                              final textSelection =
                                                  controllerForAudio2TextTextField
                                                      .selection;
                                              if (!textSelection.isCollapsed) {
                                                final selectedText =
                                                    textSelection.textInside(
                                                        controllerForAudio2TextTextField
                                                            .text);
                                                createNewSupporting(
                                                    selectedText);
                                              }
                                            },
                                            child: const Text('Supporting',
                                                style: TextStyle(fontSize: 17)),
                                          ),
                                        ])),
                                    onDraggableCanceled: (_, dragOffset) {
                                      setState(() {
                                        topFloatingButtons = dragOffset.dy - 80;
                                      });
                                    },
                                    axis: Axis.vertical,
                                    childWhenDragging: Container(),
                                    child: SizedBox(
                                        height: 50,
                                        child: Row(children: [
                                          ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                elevation: 0,
                                                backgroundColor:
                                                    const Color.fromRGBO(
                                                        255, 193, 7, 1),
                                                foregroundColor:
                                                    const Color.fromRGBO(
                                                        0, 0, 0, 1)),
                                            onPressed: () {
                                              final textSelection =
                                                  controllerForAudio2TextTextField
                                                      .selection;
                                              if (!textSelection.isCollapsed) {
                                                final selectedText =
                                                    textSelection.textInside(
                                                        controllerForAudio2TextTextField
                                                            .text);
                                                createNewCard(selectedText);
                                              }
                                            },
                                            child: const Text('Header',
                                                style: TextStyle(fontSize: 17)),
                                          ),
                                          const SizedBox(width: 10),
                                          ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                elevation: 0,
                                                backgroundColor:
                                                    const Color.fromRGBO(
                                                        233, 30, 99, 1),
                                                foregroundColor:
                                                    const Color.fromRGBO(
                                                        255, 255, 255, 1)),
                                            onPressed: () {
                                              final textSelection =
                                                  controllerForAudio2TextTextField
                                                      .selection;
                                              if (!textSelection.isCollapsed) {
                                                final selectedText =
                                                    textSelection.textInside(
                                                        controllerForAudio2TextTextField
                                                            .text);
                                                createNewMain(selectedText);
                                              }
                                            },
                                            child: const Text('Main',
                                                style: TextStyle(fontSize: 17)),
                                          ),
                                          const SizedBox(width: 10),
                                          ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                elevation: 0,
                                                backgroundColor:
                                                    const Color.fromRGBO(
                                                        63, 81, 181, 1),
                                                foregroundColor:
                                                    const Color.fromRGBO(
                                                        255, 255, 255, 1)),
                                            onPressed: () {
                                              final textSelection =
                                                  controllerForAudio2TextTextField
                                                      .selection;
                                              if (!textSelection.isCollapsed) {
                                                final selectedText =
                                                    textSelection.textInside(
                                                        controllerForAudio2TextTextField
                                                            .text);
                                                createNewSupporting(
                                                    selectedText);
                                              }
                                            },
                                            child: const Text('Supporting',
                                                style: TextStyle(fontSize: 17)),
                                          ),
                                        ])),
                                  ),
                                )
                              : Container()
                        ],
                      ),
                    ),
                    //===== FILE AREA =====
                    //===== NOTE AREA =====
                    Expanded(
                      flex: 2,
                      child: Container(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, bottom: 20, top: 20),
                          decoration: const BoxDecoration(
                            color: Color.fromRGBO(0, 150, 136, 1),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Flexible(
                                flex: 3,
                                child: SizedBox(
                                  height: 56,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          FloatingActionButton(
                                              heroTag: UniqueKey(),
                                              elevation: 0,
                                              backgroundColor: const Color
                                                  .fromRGBO(255, 193, 7, 1),
                                              shape:
                                                  const RoundedRectangleBorder(
                                                      borderRadius: BorderRadius
                                                          .all(Radius
                                                              .circular(10))),
                                              onPressed: () {
                                                createNewCard("Header");
                                              },
                                              child: Container(
                                                  padding:
                                                      const EdgeInsets.all(0),
                                                  child: const Icon(
                                                      color: Color.fromRGBO(
                                                          0, 0, 0, 1),
                                                      size: 50,
                                                      MaterialCommunityIcons
                                                          .alpha_h))),
                                          const SizedBox(width: 13.3),
                                          FloatingActionButton(
                                              heroTag: UniqueKey(),
                                              elevation: 0,
                                              backgroundColor:
                                                  const Color.fromRGBO(
                                                      233, 30, 99, 1),
                                              shape: const RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(10))),
                                              onPressed: () {
                                                createNewMain("Main");
                                              },
                                              child: Container(
                                                  padding:
                                                      const EdgeInsets.all(0),
                                                  child: const Icon(
                                                      color: Color.fromRGBO(
                                                          255, 255, 255, 1),
                                                      size: 50,
                                                      MaterialCommunityIcons
                                                          .alpha_m))),
                                          const SizedBox(width: 13.3),
                                          FloatingActionButton(
                                              heroTag: UniqueKey(),
                                              elevation: 0,
                                              backgroundColor:
                                                  const Color.fromRGBO(
                                                      63, 81, 181, 1),
                                              shape: const RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(10))),
                                              onPressed: () {
                                                createNewSupporting(
                                                    "Supporting");
                                              },
                                              child: Container(
                                                  padding:
                                                      const EdgeInsets.all(0),
                                                  child: const Icon(
                                                      color: Color.fromRGBO(
                                                          255, 255, 255, 1),
                                                      size: 50,
                                                      MaterialCommunityIcons
                                                          .alpha_s))),
                                          const SizedBox(width: 13.3),
                                          FloatingActionButton(
                                              heroTag: UniqueKey(),
                                              elevation: 0,
                                              backgroundColor:
                                                  const Color.fromRGBO(
                                                      121, 85, 72, 1),
                                              shape:
                                                  const RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  10))),
                                              onPressed: () {
                                                closeAllCards();
                                              },
                                              child: Container(
                                                  padding:
                                                      const EdgeInsets.all(10),
                                                  child: const Icon(
                                                    Icons.density_medium,
                                                    size: 30,
                                                  ))),
                                          const SizedBox(width: 13.3),
                                          FloatingActionButton(
                                              heroTag: UniqueKey(),
                                              elevation: 0,
                                              backgroundColor:
                                                  const Color.fromRGBO(
                                                      121, 85, 72, 1),
                                              shape:
                                                  const RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  10))),
                                              onPressed: () {
                                                showLastEditedCard();
                                              },
                                              child: Container(
                                                  padding:
                                                      const EdgeInsets.all(10),
                                                  child: const Icon(
                                                    Icons.center_focus_strong,
                                                    size: 30,
                                                  ))),
                                          const SizedBox(width: 13.3),
                                          FloatingActionButton(
                                              heroTag: UniqueKey(),
                                              elevation: 0,
                                              backgroundColor:
                                                  const Color.fromRGBO(
                                                      121, 85, 72, 1),
                                              shape: const RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(10))),
                                              onPressed: () {
                                                showMainOverlay(context, 1);
                                              },
                                              child: Container(
                                                  padding:
                                                      const EdgeInsets.all(0),
                                                  child: const Icon(
                                                      color: Color.fromRGBO(
                                                          255, 255, 255, 1),
                                                      size: 30,
                                                      MaterialCommunityIcons
                                                          .comment_question))),
                                          const SizedBox(width: 13.3),
                                          FloatingActionButton(
                                              heroTag: UniqueKey(),
                                              elevation: 0,
                                              backgroundColor:
                                                  const Color.fromRGBO(
                                                      121, 85, 72, 1),
                                              shape: const RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(10))),
                                              onPressed: () {
                                                showMainOverlay(context, 2);
                                              },
                                              child: Container(
                                                  padding:
                                                      const EdgeInsets.all(0),
                                                  child: const Icon(
                                                      color: Color.fromRGBO(
                                                          255, 255, 255, 1),
                                                      size: 29,
                                                      MaterialCommunityIcons
                                                          .comment_text))),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const Flexible(
                                  flex: 1, child: SizedBox(height: 20)),
                              Expanded(
                                flex: 27,
                                child: ScrollConfiguration(
                                  behavior: const ScrollBehavior()
                                      .copyWith(scrollbars: false),
                                  child: SingleChildScrollView(
                                    controller: scrollController,
                                    scrollDirection: Axis.vertical,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: returnCards(),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )),
                    ),
                    //===== NOTE AREA =====
                  ]),
                ),
              )
            : WillPopScope(
                onWillPop: () async {
                  return true;
                },
                child: Scaffold(
                  //===== APP BAR =====
                  appBar: AppBar(
                    titleSpacing: 0,
                    backgroundColor: const Color.fromRGBO(121, 85, 72, 1),
                    title: Row(
                      children: [
                        const SizedBox(width: 10),
                        Expanded(
                          child: Theme(
                            data: ThemeData(
                              textSelectionTheme: const TextSelectionThemeData(
                                cursorColor: Color.fromRGBO(255, 255, 255, 1),
                                selectionColor:
                                    Color.fromRGBO(255, 255, 255, 0.2),
                              ),
                            ),
                            child: TextField(
                                selectionControls: CustomColorSelectionHandle(
                                    const Color.fromRGBO(0, 0, 0, 0)),
                                magnifierConfiguration:
                                    TextMagnifierConfiguration.disabled,
                                enableInteractiveSelection: true,
                                onTapOutside: (PointerDownEvent a) {
                                  focusNodeForWorkspaceTitleTextField.unfocus();
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
                                  widget.workspaceTitle =
                                      controllerForWorkspaceTitleTextField.text;
                                  setState(() {});
                                },
                                keyboardType: TextInputType.multiline,
                                controller:
                                    controllerForWorkspaceTitleTextField,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 20.0,
                                    color: Color.fromRGBO(255, 255, 255, 1)),
                                focusNode: focusNodeForWorkspaceTitleTextField,
                                maxLines: 1,
                                readOnly: false),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                            child: Container(
                          alignment: Alignment.centerRight,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(7),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 252,
                                    child: Stack(
                                      alignment: Alignment.centerRight,
                                      children: [
                                        AnimatedPositioned(
                                          duration:
                                              const Duration(milliseconds: 250),
                                          curve: Curves.easeInOut,
                                          left: showYouTubeURLTextField == true
                                              ? 0
                                              : 223,
                                          child: Container(
                                            width: 223,
                                            height: 35,
                                            decoration: BoxDecoration(
                                              color: const Color.fromRGBO(
                                                  255, 255, 255, 1),
                                              border: Border.all(
                                                width: 0,
                                                color: const Color.fromRGBO(
                                                    255, 255, 255, 1),
                                              ),
                                              borderRadius:
                                                  const BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(7),
                                                      bottomLeft:
                                                          Radius.circular(7)),
                                            ),
                                            child: Theme(
                                              data: ThemeData(
                                                textSelectionTheme:
                                                    const TextSelectionThemeData(
                                                        cursorColor:
                                                            Color.fromRGBO(
                                                                121, 85, 72, 1),
                                                        selectionColor:
                                                            Color.fromRGBO(121,
                                                                85, 72, 0.2)),
                                              ),
                                              child: TextField(
                                                controller:
                                                    controllerForYouTubeURLTextField,
                                                focusNode:
                                                    focusNodeForYouTubeURLTextField,
                                                onTapOutside:
                                                    (PointerDownEvent a) {
                                                  focusNodeForYouTubeURLTextField
                                                      .unfocus();
                                                },
                                                selectionControls:
                                                    CustomColorSelectionHandle(
                                                        const Color.fromRGBO(
                                                            0, 0, 0, 0)),
                                                magnifierConfiguration:
                                                    TextMagnifierConfiguration
                                                        .disabled,
                                                decoration:
                                                    const InputDecoration(
                                                        enabledBorder:
                                                            InputBorder.none,
                                                        border:
                                                            InputBorder.none,
                                                        disabledBorder:
                                                            InputBorder.none,
                                                        errorBorder:
                                                            InputBorder.none,
                                                        focusedErrorBorder:
                                                            InputBorder.none,
                                                        focusedBorder:
                                                            InputBorder.none,
                                                        contentPadding:
                                                            EdgeInsets.only(
                                                                bottom: 0,
                                                                top: -15,
                                                                left: 7,
                                                                right: 10)),
                                                enableInteractiveSelection:
                                                    true,
                                                keyboardType: TextInputType.url,
                                                style: const TextStyle(
                                                  fontSize: 14,
                                                  color: Color.fromRGBO(
                                                      121, 85, 72, 1),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width: 10,
                                          height: 36,
                                          decoration: const BoxDecoration(
                                            color:
                                                Color.fromRGBO(121, 85, 72, 1),
                                          ),
                                        ),
                                        Container(
                                          alignment: Alignment.center,
                                          width: 35,
                                          child: SizedBox(
                                            width: 35,
                                            height: 35,
                                            child: GestureDetector(
                                              onLongPress: () {
                                                if (showYouTubeURLTextField ==
                                                    false) {
                                                } else {
                                                  youtube();
                                                  setState(() {
                                                    focusNodeForYouTubeURLTextField
                                                        .unfocus();
                                                    showYouTubeURLTextField =
                                                        false;
                                                  });
                                                }
                                              },
                                              child: FloatingActionButton(
                                                heroTag: UniqueKey(),
                                                elevation: 0,
                                                backgroundColor:
                                                    const Color.fromRGBO(
                                                        255, 255, 255, 1),
                                                shape:
                                                    const RoundedRectangleBorder(
                                                        side: BorderSide(
                                                            width: 0,
                                                            color:
                                                                Color.fromRGBO(
                                                                    255,
                                                                    255,
                                                                    255,
                                                                    1)),
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    7))),
                                                onPressed: () {
                                                  setState(() {
                                                    if (showYouTubeURLTextField ==
                                                        false) {
                                                      controllerForYouTubeURLTextField
                                                          .text = "";
                                                      focusNodeForYouTubeURLTextField
                                                          .requestFocus();
                                                      showYouTubeURLTextField =
                                                          true;
                                                    } else {
                                                      controllerForYouTubeURLTextField
                                                          .text = "";
                                                      focusNodeForYouTubeURLTextField
                                                          .unfocus();
                                                      showYouTubeURLTextField =
                                                          false;
                                                    }
                                                  });
                                                },
                                                child: const Icon(
                                                  color: Color.fromRGBO(
                                                      121, 85, 72, 1),
                                                  size: 20,
                                                  MaterialCommunityIcons
                                                      .youtube,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Container(
                                      alignment: Alignment.center,
                                      width: 35,
                                      child: SizedBox(
                                        width: 35,
                                        height: 35,
                                        child: FloatingActionButton(
                                            heroTag: UniqueKey(),
                                            elevation: 0,
                                            backgroundColor:
                                                const Color.fromRGBO(
                                                    255, 255, 255, 1),
                                            shape: const RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(7))),
                                            onPressed: () {
                                              filepicker();
                                            },
                                            child: const Icon(
                                                color: Color.fromRGBO(
                                                    121, 85, 72, 1),
                                                size: 20,
                                                MaterialCommunityIcons
                                                    .file_document)),
                                      )),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Container(
                                      alignment: Alignment.center,
                                      width: 35,
                                      child: SizedBox(
                                        width: 35,
                                        height: 35,
                                        child: FloatingActionButton(
                                            heroTag: UniqueKey(),
                                            elevation: 0,
                                            backgroundColor:
                                                const Color.fromRGBO(
                                                    255, 255, 255, 1),
                                            shape: const RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(7))),
                                            onPressed: () {
                                              if (showNoteArea == true) {
                                                showNoteArea = false;
                                              } else {
                                                showNoteArea = true;
                                              }
                                              setState(() {});
                                            },
                                            child: const Icon(
                                                color: Color.fromRGBO(
                                                    121, 85, 72, 1),
                                                size: 20,
                                                MaterialCommunityIcons
                                                    .view_split_vertical)),
                                      )),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Container(
                                      alignment: Alignment.center,
                                      width: 35,
                                      child: SizedBox(
                                        width: 35,
                                        height: 35,
                                        child: FloatingActionButton(
                                            heroTag: UniqueKey(),
                                            elevation: 0,
                                            backgroundColor: Colors.teal,
                                            shape: const RoundedRectangleBorder(
                                                side: BorderSide(
                                                    width: 2,
                                                    color: Colors.white),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(7))),
                                            onPressed: () {
                                              showHelpOverlay(context);
                                            },
                                            child: const Icon(
                                                color: Colors.white,
                                                size: 18,
                                                MaterialCommunityIcons.help)),
                                      )),
                                ],
                              ),
                            ),
                          ),
                        )),
                        const SizedBox(width: 10)
                      ],
                    ),
                  ),
                  //===== APP BAR =====
                  //===== BODY =====
                  body: Row(children: [
                    showNoteArea == false
                        ?
                        //===== FILE AREA =====
                        Expanded(
                            flex: 3,
                            child: Stack(
                              children: [
                                Container(
                                    padding:
                                        canShowFile == true && nonPDF == false
                                            ? const EdgeInsets.all(0)
                                            : const EdgeInsets.all(20),
                                    color:
                                        const Color.fromRGBO(255, 255, 255, 1),
                                    child:
                                        canShowFile == true && nonPDF == false
                                            //PDF
                                            ? SfPdfViewer.memory(
                                                pdfBytes,
                                                interactionMode:
                                                    PdfInteractionMode
                                                        .selection,
                                                onTextSelectionChanged:
                                                    (PdfTextSelectionChangedDetails
                                                        details) {
                                                  if (details.selectedText ==
                                                          null &&
                                                      overlayEntryForNoteSelection !=
                                                          null) {
                                                    overlayEntryForNoteSelection!
                                                        .remove();
                                                    overlayEntryForNoteSelection =
                                                        null;
                                                  } else if (details
                                                              .selectedText !=
                                                          null &&
                                                      overlayEntryForNoteSelection ==
                                                          null) {
                                                    showNoteSelectionOverlay(
                                                        context, details);
                                                  }
                                                },
                                                controller:
                                                    _pdfViewerController,
                                              )
                                            : canShowFile == true &&
                                                    nonPDF == true
                                                //AUDIO2TEXT
                                                ? Column(
                                                    children: [
                                                      //TOP PADDING
                                                      //const SizedBox(height: 20),
                                                      //TITLE, STATUS, BUTTON...
                                                      Flexible(
                                                        flex: 4,
                                                        child: SizedBox(
                                                          height: 76,
                                                          child: Row(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              fromYouTube == true
                                                                  ? SizedBox(
                                                                      height:
                                                                          76,
                                                                      width: 76,
                                                                      child: FloatingActionButton(
                                                                          heroTag:
                                                                              UniqueKey(),
                                                                          elevation:
                                                                              0,
                                                                          backgroundColor: const Color.fromRGBO(
                                                                              121,
                                                                              85,
                                                                              72,
                                                                              1),
                                                                          shape: const RoundedRectangleBorder(
                                                                              borderRadius: BorderRadius.all(Radius.circular(
                                                                                  0))),
                                                                          onPressed:
                                                                              null,
                                                                          child: Container(
                                                                              padding: const EdgeInsets.all(0),
                                                                              child: const Icon(color: Color.fromRGBO(255, 255, 255, 1), size: 45, MaterialCommunityIcons.youtube))))
                                                                  : SizedBox(height: 76, width: 76, child: FloatingActionButton(elevation: 0, backgroundColor: const Color.fromRGBO(121, 85, 72, 1), shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(0))), onPressed: null, child: Container(padding: const EdgeInsets.all(0), child: const Icon(color: Color.fromRGBO(255, 255, 255, 1), size: 40, MaterialCommunityIcons.file_document)))),
                                                              const Flexible(
                                                                  flex: 1,
                                                                  child: SizedBox(
                                                                      width:
                                                                          10)),
                                                              Expanded(
                                                                  flex: 43,
                                                                  child: Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      Expanded(
                                                                          flex:
                                                                              9,
                                                                          child: Container(
                                                                              alignment: Alignment.bottomLeft,
                                                                              child: SingleChildScrollView(scrollDirection: Axis.horizontal, child: Text(titleForAudio2Text, style: const TextStyle(color: Color.fromRGBO(121, 85, 72, 1), fontSize: 25, fontWeight: FontWeight.bold))))),
                                                                      const Expanded(
                                                                          flex:
                                                                              1,
                                                                          child:
                                                                              Text("")),
                                                                      Expanded(
                                                                          flex:
                                                                              7,
                                                                          child:
                                                                              Container(
                                                                            alignment:
                                                                                Alignment.topLeft,
                                                                            child:
                                                                                SingleChildScrollView(
                                                                              scrollDirection: Axis.horizontal,
                                                                              child: Row(
                                                                                mainAxisAlignment: MainAxisAlignment.start,
                                                                                children: [
                                                                                  circularForAudio2Text == true
                                                                                      ? Row(
                                                                                          children: const [
                                                                                            SizedBox(width: 1.7),
                                                                                            SizedBox(
                                                                                              height: 10,
                                                                                              width: 10,
                                                                                              child: CircularProgressIndicator(
                                                                                                valueColor: AlwaysStoppedAnimation<Color>(Color.fromRGBO(121, 85, 72, 1)),
                                                                                                strokeWidth: 1.0,
                                                                                              ),
                                                                                            ),
                                                                                            SizedBox(width: 7),
                                                                                          ],
                                                                                        )
                                                                                      : const SizedBox(
                                                                                          height: 10,
                                                                                        ),
                                                                                  Text(statusForAudio2Text,
                                                                                      style: const TextStyle(
                                                                                        color: Color.fromRGBO(121, 85, 72, 1),
                                                                                        fontSize: 15,
                                                                                      ))
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          )),
                                                                    ],
                                                                  )),
                                                              const Flexible(
                                                                  flex: 1,
                                                                  child: SizedBox(
                                                                      width:
                                                                          10)),
                                                              Expanded(
                                                                  flex: 15,
                                                                  child: Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .end,
                                                                    children: [
                                                                      Flexible(
                                                                        child:
                                                                            Container(
                                                                          decoration:
                                                                              const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(40))),
                                                                          child: FloatingActionButton(
                                                                              heroTag: UniqueKey(),
                                                                              elevation: 0,
                                                                              backgroundColor: const Color.fromRGBO(121, 85, 72, 1),
                                                                              shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(40))),
                                                                              onPressed: () {
                                                                                if (showFloatingButtons == false) {
                                                                                  showFloatingButtons = true;
                                                                                } else {
                                                                                  showFloatingButtons = false;
                                                                                  topFloatingButtons = 500;
                                                                                }
                                                                                setState(() {});
                                                                              },
                                                                              child: Container(padding: const EdgeInsets.all(0), child: showFloatingButtons == true ? const Icon(color: Color.fromRGBO(255, 255, 255, 1), size: 20, MaterialCommunityIcons.note_edit) : const Icon(color: Color.fromRGBO(255, 255, 255, 1), size: 20, MaterialCommunityIcons.note_off))),
                                                                        ),
                                                                      )
                                                                    ],
                                                                  ))
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      const Flexible(
                                                          flex: 1,
                                                          child: SizedBox(
                                                              height: 20)),
                                                      //TEXTFIELD
                                                      Expanded(
                                                        flex: 26,
                                                        child: Container(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  top: 5,
                                                                  bottom: 5),
                                                          alignment:
                                                              Alignment.topLeft,
                                                          child: Theme(
                                                            data: ThemeData(
                                                              textSelectionTheme:
                                                                  const TextSelectionThemeData(
                                                                cursorColor: Color
                                                                    .fromRGBO(
                                                                        121,
                                                                        85,
                                                                        72,
                                                                        1),
                                                                selectionColor:
                                                                    Color.fromRGBO(
                                                                        121,
                                                                        85,
                                                                        72,
                                                                        0.2),
                                                              ),
                                                            ),
                                                            child:
                                                                ScrollConfiguration(
                                                              behavior:
                                                                  const CustomScrollBehavior(),
                                                              child: TextField(
                                                                  selectionControls:
                                                                      CustomColorSelectionHandle(const Color.fromRGBO(
                                                                          121,
                                                                          85,
                                                                          72,
                                                                          1)),
                                                                  magnifierConfiguration:
                                                                      TextMagnifierConfiguration
                                                                          .disabled,
                                                                  enableInteractiveSelection:
                                                                      true,
                                                                  onTapOutside:
                                                                      (PointerDownEvent
                                                                          a) {
                                                                    focusNodeForAudio2TextTextField
                                                                        .unfocus();
                                                                  },
                                                                  decoration:
                                                                      const InputDecoration(
                                                                    // this will remove the default content padding
                                                                    isDense:
                                                                        true,
                                                                    // now you can customize it here or add padding widget
                                                                    contentPadding:
                                                                        EdgeInsets.symmetric(
                                                                            //horizontal: 5,
                                                                            vertical: 0),
                                                                    enabledBorder:
                                                                        InputBorder
                                                                            .none,
                                                                    border:
                                                                        InputBorder
                                                                            .none,
                                                                    disabledBorder:
                                                                        InputBorder
                                                                            .none,
                                                                    errorBorder:
                                                                        InputBorder
                                                                            .none,
                                                                    focusedErrorBorder:
                                                                        InputBorder
                                                                            .none,
                                                                    focusedBorder:
                                                                        InputBorder
                                                                            .none,
                                                                  ),
                                                                  onChanged:
                                                                      (text) {},
                                                                  keyboardType:
                                                                      TextInputType
                                                                          .multiline,
                                                                  controller:
                                                                      controllerForAudio2TextTextField,
                                                                  style: const TextStyle(
                                                                      fontSize:
                                                                          20.0,
                                                                      color: Color.fromRGBO(
                                                                          121,
                                                                          85,
                                                                          72,
                                                                          1)),
                                                                  focusNode:
                                                                      focusNodeForAudio2TextTextField,
                                                                  maxLines:
                                                                      null,
                                                                  readOnly:
                                                                      false),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                : Container()),
                                showFloatingButtons == true
                                    ? Positioned(
                                        top: topFloatingButtons,
                                        right: 20,
                                        child: Draggable(
                                          feedback: SizedBox(
                                              height: 50,
                                              child: Row(children: [
                                                ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                          elevation: 0,
                                                          backgroundColor:
                                                              const Color
                                                                      .fromRGBO(
                                                                  255,
                                                                  193,
                                                                  7,
                                                                  1),
                                                          foregroundColor:
                                                              const Color
                                                                      .fromRGBO(
                                                                  0, 0, 0, 1)),
                                                  onPressed: () {
                                                    final textSelection =
                                                        controllerForAudio2TextTextField
                                                            .selection;
                                                    if (!textSelection
                                                        .isCollapsed) {
                                                      final selectedText =
                                                          textSelection.textInside(
                                                              controllerForAudio2TextTextField
                                                                  .text);
                                                      createNewCard(
                                                          selectedText);
                                                    }
                                                  },
                                                  child: const Text('Header',
                                                      style: TextStyle(
                                                          fontSize: 17)),
                                                ),
                                                const SizedBox(width: 10),
                                                ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                          elevation: 0,
                                                          backgroundColor:
                                                              const Color
                                                                      .fromRGBO(
                                                                  233,
                                                                  30,
                                                                  99,
                                                                  1),
                                                          foregroundColor:
                                                              const Color
                                                                      .fromRGBO(
                                                                  255,
                                                                  255,
                                                                  255,
                                                                  1)),
                                                  onPressed: () {
                                                    final textSelection =
                                                        controllerForAudio2TextTextField
                                                            .selection;
                                                    if (!textSelection
                                                        .isCollapsed) {
                                                      final selectedText =
                                                          textSelection.textInside(
                                                              controllerForAudio2TextTextField
                                                                  .text);
                                                      createNewMain(
                                                          selectedText);
                                                    }
                                                  },
                                                  child: const Text('Main',
                                                      style: TextStyle(
                                                          fontSize: 17)),
                                                ),
                                                const SizedBox(width: 10),
                                                ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                          elevation: 0,
                                                          backgroundColor:
                                                              const Color
                                                                      .fromRGBO(
                                                                  63,
                                                                  81,
                                                                  181,
                                                                  1),
                                                          foregroundColor:
                                                              const Color
                                                                      .fromRGBO(
                                                                  255,
                                                                  255,
                                                                  255,
                                                                  1)),
                                                  onPressed: () {
                                                    final textSelection =
                                                        controllerForAudio2TextTextField
                                                            .selection;
                                                    if (!textSelection
                                                        .isCollapsed) {
                                                      final selectedText =
                                                          textSelection.textInside(
                                                              controllerForAudio2TextTextField
                                                                  .text);
                                                      createNewSupporting(
                                                          selectedText);
                                                    }
                                                  },
                                                  child: const Text(
                                                      'Supporting',
                                                      style: TextStyle(
                                                          fontSize: 17)),
                                                ),
                                              ])),
                                          onDraggableCanceled: (_, dragOffset) {
                                            setState(() {
                                              topFloatingButtons =
                                                  dragOffset.dy - 80;
                                            });
                                          },
                                          axis: Axis.vertical,
                                          childWhenDragging: Container(),
                                          child: SizedBox(
                                              height: 50,
                                              child: Row(children: [
                                                ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                          elevation: 0,
                                                          backgroundColor:
                                                              const Color
                                                                      .fromRGBO(
                                                                  255,
                                                                  193,
                                                                  7,
                                                                  1),
                                                          foregroundColor:
                                                              const Color
                                                                      .fromRGBO(
                                                                  0, 0, 0, 1)),
                                                  onPressed: () {
                                                    final textSelection =
                                                        controllerForAudio2TextTextField
                                                            .selection;
                                                    if (!textSelection
                                                        .isCollapsed) {
                                                      final selectedText =
                                                          textSelection.textInside(
                                                              controllerForAudio2TextTextField
                                                                  .text);
                                                      createNewCard(
                                                          selectedText);
                                                    }
                                                  },
                                                  child: const Text('Header',
                                                      style: TextStyle(
                                                          fontSize: 17)),
                                                ),
                                                const SizedBox(width: 10),
                                                ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                          elevation: 0,
                                                          backgroundColor:
                                                              const Color
                                                                      .fromRGBO(
                                                                  233,
                                                                  30,
                                                                  99,
                                                                  1),
                                                          foregroundColor:
                                                              const Color
                                                                      .fromRGBO(
                                                                  255,
                                                                  255,
                                                                  255,
                                                                  1)),
                                                  onPressed: () {
                                                    final textSelection =
                                                        controllerForAudio2TextTextField
                                                            .selection;
                                                    if (!textSelection
                                                        .isCollapsed) {
                                                      final selectedText =
                                                          textSelection.textInside(
                                                              controllerForAudio2TextTextField
                                                                  .text);
                                                      createNewMain(
                                                          selectedText);
                                                    }
                                                  },
                                                  child: const Text('Main',
                                                      style: TextStyle(
                                                          fontSize: 17)),
                                                ),
                                                const SizedBox(width: 10),
                                                ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                          elevation: 0,
                                                          backgroundColor:
                                                              const Color
                                                                      .fromRGBO(
                                                                  63,
                                                                  81,
                                                                  181,
                                                                  1),
                                                          foregroundColor:
                                                              const Color
                                                                      .fromRGBO(
                                                                  255,
                                                                  255,
                                                                  255,
                                                                  1)),
                                                  onPressed: () {
                                                    final textSelection =
                                                        controllerForAudio2TextTextField
                                                            .selection;
                                                    if (!textSelection
                                                        .isCollapsed) {
                                                      final selectedText =
                                                          textSelection.textInside(
                                                              controllerForAudio2TextTextField
                                                                  .text);
                                                      createNewSupporting(
                                                          selectedText);
                                                    }
                                                  },
                                                  child: const Text(
                                                      'Supporting',
                                                      style: TextStyle(
                                                          fontSize: 17)),
                                                ),
                                              ])),
                                        ),
                                      )
                                    : Container()
                              ],
                            ),
                          )
                        :
                        //===== FILE AREA =====

                        //===== NOTE AREA =====

                        Expanded(
                            flex: 2,
                            child: Container(
                                padding: const EdgeInsets.only(
                                    left: 20, right: 20, bottom: 20, top: 20),
                                decoration: const BoxDecoration(
                                  color: Color.fromRGBO(0, 150, 136, 1),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Flexible(
                                      flex: 3,
                                      child: SizedBox(
                                        height: 56,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: SingleChildScrollView(
                                            scrollDirection: Axis.horizontal,
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                FloatingActionButton(
                                                    heroTag: UniqueKey(),
                                                    elevation: 0,
                                                    backgroundColor:
                                                        const Color.fromRGBO(
                                                            255, 193, 7, 1),
                                                    shape: const RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    10))),
                                                    onPressed: () {
                                                      createNewCard("Header");
                                                    },
                                                    child: Container(
                                                        padding:
                                                            const EdgeInsets.all(
                                                                0),
                                                        child: const Icon(
                                                            color:
                                                                Color.fromRGBO(
                                                                    0, 0, 0, 1),
                                                            size: 50,
                                                            MaterialCommunityIcons
                                                                .alpha_h))),
                                                const SizedBox(width: 13.3),
                                                FloatingActionButton(
                                                    heroTag: UniqueKey(),
                                                    elevation: 0,
                                                    backgroundColor:
                                                        const Color.fromRGBO(
                                                            233, 30, 99, 1),
                                                    shape: const RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    10))),
                                                    onPressed: () {
                                                      createNewMain("Main");
                                                    },
                                                    child: Container(
                                                        padding:
                                                            const EdgeInsets.all(
                                                                0),
                                                        child: const Icon(
                                                            color: Color.fromRGBO(
                                                                255,
                                                                255,
                                                                255,
                                                                1),
                                                            size: 50,
                                                            MaterialCommunityIcons
                                                                .alpha_m))),
                                                const SizedBox(width: 13.3),
                                                FloatingActionButton(
                                                    heroTag: UniqueKey(),
                                                    elevation: 0,
                                                    backgroundColor:
                                                        const Color.fromRGBO(
                                                            63, 81, 181, 1),
                                                    shape: const RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    10))),
                                                    onPressed: () {
                                                      createNewSupporting(
                                                          "Supporting");
                                                    },
                                                    child: Container(
                                                        padding:
                                                            const EdgeInsets.all(
                                                                0),
                                                        child: const Icon(
                                                            color: Color.fromRGBO(
                                                                255,
                                                                255,
                                                                255,
                                                                1),
                                                            size: 50,
                                                            MaterialCommunityIcons
                                                                .alpha_s))),
                                                const SizedBox(width: 13.3),
                                                FloatingActionButton(
                                                    heroTag: UniqueKey(),
                                                    elevation: 0,
                                                    backgroundColor:
                                                        const Color.fromRGBO(
                                                            121, 85, 72, 1),
                                                    shape: const RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    10))),
                                                    onPressed: () {
                                                      closeAllCards();
                                                    },
                                                    child: Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(10),
                                                        child: const Icon(
                                                          Icons.density_medium,
                                                          size: 30,
                                                        ))),
                                                const SizedBox(width: 13.3),
                                                FloatingActionButton(
                                                    heroTag: UniqueKey(),
                                                    elevation: 0,
                                                    backgroundColor:
                                                        const Color.fromRGBO(
                                                            121, 85, 72, 1),
                                                    shape: const RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    10))),
                                                    onPressed: () {},
                                                    child: Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(10),
                                                        child: const Icon(
                                                          Icons
                                                              .center_focus_strong,
                                                          size: 30,
                                                        ))),
                                                const SizedBox(width: 13.3),
                                                FloatingActionButton(
                                                    heroTag: UniqueKey(),
                                                    elevation: 0,
                                                    backgroundColor:
                                                        const Color.fromRGBO(
                                                            121, 85, 72, 1),
                                                    shape: const RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    10))),
                                                    onPressed: () {
                                                      showMainOverlay(
                                                          context, 1);
                                                    },
                                                    child: Container(
                                                        padding:
                                                            const EdgeInsets.all(
                                                                0),
                                                        child: const Icon(
                                                            color: Color.fromRGBO(
                                                                255,
                                                                255,
                                                                255,
                                                                1),
                                                            size: 30,
                                                            MaterialCommunityIcons
                                                                .comment_question))),
                                                const SizedBox(width: 13.3),
                                                FloatingActionButton(
                                                    heroTag: UniqueKey(),
                                                    elevation: 0,
                                                    backgroundColor:
                                                        const Color.fromRGBO(
                                                            121, 85, 72, 1),
                                                    shape: const RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    10))),
                                                    onPressed: () {
                                                      showMainOverlay(
                                                          context, 2);
                                                    },
                                                    child: Container(
                                                        padding:
                                                            const EdgeInsets.all(
                                                                0),
                                                        child: const Icon(
                                                            color: Color.fromRGBO(
                                                                255,
                                                                255,
                                                                255,
                                                                1),
                                                            size: 29,
                                                            MaterialCommunityIcons
                                                                .comment_text))),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const Flexible(
                                        flex: 1, child: SizedBox(height: 20)),
                                    Expanded(
                                      flex: 27,
                                      child: ScrollConfiguration(
                                        behavior: const ScrollBehavior()
                                            .copyWith(scrollbars: false),
                                        child: SingleChildScrollView(
                                          controller: scrollController,
                                          scrollDirection: Axis.vertical,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: returnCards(),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                )),
                          ),

                    //===== NOTE AREA =====
                  ]),
                ),
              );
      },
    );
  }
}
