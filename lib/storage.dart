class WorkspaceButtonStorage {
  late String workspaceButtonID;
  late WorkspaceStorage workspace;
  setWorkspaceButtonID(String a) {
    workspaceButtonID = a;
  }

  setWorkspace(WorkspaceStorage a) {
    workspace = a;
  }

  Map<String, dynamic> toMap() {
    return {
      'workspaceButtonID': workspaceButtonID,
      'workspace': workspace.toMap()
    };
  }
}

class WorkspaceStorage {
  late List<CardsStorage> cards;
  late int counterForCard;
  late int counterForMain;
  late int counterForPoint;
  late int selectedCard;
  late int selectedMain;
  late String workspaceTitle;

  //

  late String pdfBase64STORAGE;
  late bool canShowFileSTORAGE;
  late bool nonPDFSTORAGE;
  late bool fromYouTubeSTORAGE;
  late String statusForAudio2TextSTORAGE;
  late String titleForAudio2TextSTORAGE;
  late bool circularForAudio2TextSTORAGE;
  late String audio2TextTextFieldTextSTORAGE;

  //

  setpdfBase64STORAGE(String a) {
    pdfBase64STORAGE = a;
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

  setaudio2TextTextFieldTextSTORAGE(String a) {
    audio2TextTextFieldTextSTORAGE = a;
  }

  //

  setCards(List<CardsStorage> a) {
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

  Map<String, dynamic> toMap() {
    return {
      'cards': cards.map((y) => y.toMap()).toList(),
      'counterForCard': counterForCard,
      'counterForMain': counterForMain,
      'counterForPoint': counterForPoint,
      'selectedCard': selectedCard,
      'selectedMain': selectedMain,
      'workspaceTitle': workspaceTitle,
      'pdfBase64STORAGE': pdfBase64STORAGE,
      'canShowFileSTORAGE': canShowFileSTORAGE,
      'nonPDFSTORAGE': nonPDFSTORAGE,
      'fromYouTubeSTORAGE': fromYouTubeSTORAGE,
      'statusForAudio2TextSTORAGE': statusForAudio2TextSTORAGE,
      'titleForAudio2TextSTORAGE': titleForAudio2TextSTORAGE,
      'circularForAudio2TextSTORAGE': circularForAudio2TextSTORAGE,
      'audio2TextTextFieldTextSTORAGE': audio2TextTextFieldTextSTORAGE
    };
  }
}

class CardsStorage {
  late int cardID;
  late HeaderStorage header;
  late List<double> cardBorderColor;
  late List<MainsStorage> mains;
  late double cardBottomMargin;
  late bool isCardHiding;

  setCardID(int a) {
    cardID = a;
  }

  setHeader(HeaderStorage a) {
    header = a;
  }

  setCardBorderColor(List<double> a) {
    cardBorderColor = a;
  }

  setMains(List<MainsStorage> a) {
    mains = a;
  }

  setCardBottomMargin(double a) {
    cardBottomMargin = a;
  }

  setIsCardHiding(bool a) {
    isCardHiding = a;
  }

  Map<String, dynamic> toMap() {
    return {
      'cardID': cardID,
      'header': header.toMap(),
      'cardBorderColor': cardBorderColor,
      'mains': mains.map((y) => y.toMap()).toList(),
      'cardBottomMargin': cardBottomMargin,
      'isCardHiding': isCardHiding
    };
  }
}

class HeaderStorage {
  late double containerWidth;
  late int cardID;
  late String header;

  setContainerWidth(double a) {
    containerWidth = a;
  }

  setCardID(int a) {
    cardID = a;
  }

  setHeader(String a) {
    header = a;
  }

  Map<String, dynamic> toMap() {
    return {
      'containerWidth': containerWidth,
      'cardID': cardID,
      'header': header,
    };
  }
}

class MainsStorage {
  late double containerWidth;
  late int cardID;
  late int mainID;
  late String main;
  late List<double> mainColor;
  late List<PointsStorage> points;
  late bool isMainHiding;

  setContainerWidth(double a) {
    containerWidth = a;
  }

  setCardID(int a) {
    cardID = a;
  }

  setMainID(int a) {
    mainID = a;
  }

  setMain(String a) {
    main = a;
  }

  setMainColor(List<double> a) {
    mainColor = a;
  }

  setPoints(List<PointsStorage> a) {
    points = a;
  }

  setIsMainHiding(bool a) {
    isMainHiding = a;
  }

  Map<String, dynamic> toMap() {
    return {
      'containerWidth': containerWidth,
      'cardID': cardID,
      'mainID': mainID,
      'main': main,
      'mainColor': mainColor,
      'points': points.map((y) => y.toMap()).toList(),
      'isMainHiding': isMainHiding
    };
  }
}

class PointsStorage {
  late double containerWidth;
  late int cardID;
  late int mainID;
  late int pointID;
  late String point;

  setContainerWidth(double a) {
    containerWidth = a;
  }

  setCardID(int a) {
    cardID = a;
  }

  setMainID(int a) {
    mainID = a;
  }

  setPointID(int a) {
    pointID = a;
  }

  setPoint(String a) {
    point = a;
  }

  Map<String, dynamic> toMap() {
    return {
      'containerWidth': containerWidth,
      'cardID': cardID,
      'mainID': mainID,
      'pointID': pointID,
      'point': point,
    };
  }
}
