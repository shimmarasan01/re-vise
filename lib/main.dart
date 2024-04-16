import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:test/auth_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:test/workspace.dart';
import 'package:test/functions.dart';
import 'package:test/storage.dart';
import 'package:test/cards.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:uuid/uuid.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
        apiKey: "AIzaSyDfcP6lTk3AYjtt42jDvxTOx_Lt6l3N-vs",
        appId: "1:302970949505:android:0e13b04038d8b0e7356280",
        messagingSenderId: "",
        projectId: "test-44910"),
  );
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.brown,
          fontFamily: "Roboto",
        ),
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (ctx, userSnapshot) {
            if (userSnapshot.hasData) {
              Dashboard a = Dashboard();
              a.setWorkspaceButtons([]);
              return a;
            }
            return const AuthScreen();
          },
        ));
  }
}

// ignore: must_be_immutable
class Dashboard extends StatefulWidget {
  Dashboard({super.key});
  late List<WorkspaceButton> workspaceButtons;
  setWorkspaceButtons(List<WorkspaceButton> a) {
    workspaceButtons = a;
  }

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  bool deleteMode = false;
  String userID = "";
  String userEmail = "";

  @override
  void initState() {
    super.initState();
    setWorkspaceAddButton();
    getUserIDAndEmail();
    checkIfNewUser();
  }

  checkIfNewUser() async {
    DocumentSnapshot documentSnapshot =
        await FirebaseFirestore.instance.collection("users").doc(userID).get();
    if (documentSnapshot.exists) {
      await test();
    } else {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(userID)
          .set({'workspacebutton': []});
    }
  }

  storeWorkspacesToFirebase() async {
    List<WorkspaceButtonStorage> workspaceButtonStorageList = [];
    for (int i = 1; i < widget.workspaceButtons.length; i++) {
      List<CardsStorage> cardsStorageList = [];
      for (int j = 0;
          j < widget.workspaceButtons[i].workspace.cards.length;
          j++) {
        CardsStorage cardsStorage = CardsStorage();
        cardsStorage.setCardBorderColor(rgbaToList(
            widget.workspaceButtons[i].workspace.cards[j].cardBorderColor));
        cardsStorage.setCardBottomMargin(
            widget.workspaceButtons[i].workspace.cards[j].cardBottomMargin);
        cardsStorage
            .setCardID(widget.workspaceButtons[i].workspace.cards[j].cardID);
        HeaderStorage headerStorage = HeaderStorage();
        headerStorage.setCardID(
            widget.workspaceButtons[i].workspace.cards[j].header.cardID);
        headerStorage.setContainerWidth(widget
            .workspaceButtons[i].workspace.cards[j].header.containerWidth);
        headerStorage.setHeader(
            widget.workspaceButtons[i].workspace.cards[j].header.header);
        cardsStorage.setHeader(headerStorage);
        cardsStorage.setIsCardHiding(
            widget.workspaceButtons[i].workspace.cards[j].isCardHiding);
        List<MainsStorage> mainsStorageList = [];
        for (int k = 0;
            k < widget.workspaceButtons[i].workspace.cards[j].mains.length;
            k++) {
          MainsStorage mainsStorage = MainsStorage();
          mainsStorage.setCardID(
              widget.workspaceButtons[i].workspace.cards[j].mains[k].cardID);
          mainsStorage.setContainerWidth(widget
              .workspaceButtons[i].workspace.cards[j].mains[k].containerWidth);
          mainsStorage.setIsMainHiding(widget
              .workspaceButtons[i].workspace.cards[j].mains[k].isMainHiding);
          mainsStorage.setMain(
              widget.workspaceButtons[i].workspace.cards[j].mains[k].main);
          mainsStorage.setMainColor(rgbaToList(widget
              .workspaceButtons[i].workspace.cards[j].mains[k].mainColor));
          mainsStorage.setMainID(
              widget.workspaceButtons[i].workspace.cards[j].mains[k].mainID);
          List<PointsStorage> pointsStorageList = [];
          for (int l = 0;
              l <
                  widget.workspaceButtons[i].workspace.cards[j].mains[k].points
                      .length;
              l++) {
            PointsStorage pointsStorage = PointsStorage();
            pointsStorage.setCardID(widget.workspaceButtons[i].workspace
                .cards[j].mains[k].points[l].cardID);
            pointsStorage.setContainerWidth(widget.workspaceButtons[i].workspace
                .cards[j].mains[k].points[l].containerWidth);
            pointsStorage.setMainID(widget.workspaceButtons[i].workspace
                .cards[j].mains[k].points[l].mainID);
            pointsStorage.setPoint(widget.workspaceButtons[i].workspace.cards[j]
                .mains[k].points[l].point);
            pointsStorage.setPointID(widget.workspaceButtons[i].workspace
                .cards[j].mains[k].points[l].pointID);
            pointsStorageList.add(pointsStorage);
          }
          mainsStorage.setPoints(pointsStorageList);
          mainsStorageList.add(mainsStorage);
        }
        cardsStorage.setMains(mainsStorageList);
        cardsStorageList.add(cardsStorage);
      }
      WorkspaceStorage workspaceStorage = WorkspaceStorage();

      workspaceStorage.setpdfBase64STORAGE(
          widget.workspaceButtons[i].workspace.pdfBase64STORAGE);
      workspaceStorage.setcanShowFileSTORAGE(
          widget.workspaceButtons[i].workspace.canShowFileSTORAGE);
      workspaceStorage
          .setnonPDFSTORAGE(widget.workspaceButtons[i].workspace.nonPDFSTORAGE);
      workspaceStorage.setfromYouTubeSTORAGE(
          widget.workspaceButtons[i].workspace.fromYouTubeSTORAGE);
      workspaceStorage.setstatusForAudio2TextSTORAGE(
          widget.workspaceButtons[i].workspace.statusForAudio2TextSTORAGE);
      workspaceStorage.settitleForAudio2TextSTORAGE(
          widget.workspaceButtons[i].workspace.titleForAudio2TextSTORAGE);
      workspaceStorage.setcircularForAudio2TextSTORAGE(
          widget.workspaceButtons[i].workspace.circularForAudio2TextSTORAGE);
      workspaceStorage.setaudio2TextTextFieldTextSTORAGE(
          widget.workspaceButtons[i].workspace.audio2TextTextFieldTextSTORAGE);

      workspaceStorage.setCards(cardsStorageList);
      workspaceStorage.setCounterForCard(
          widget.workspaceButtons[i].workspace.counterForCard);
      workspaceStorage.setCounterForMain(
          widget.workspaceButtons[i].workspace.counterForMain);
      workspaceStorage.setCounterForPoint(
          widget.workspaceButtons[i].workspace.counterForPoint);
      workspaceStorage
          .setSelectedCard(widget.workspaceButtons[i].workspace.selectedCard);
      workspaceStorage
          .setSelectedMain(widget.workspaceButtons[i].workspace.selectedMain);
      workspaceStorage.setWorkspaceTitle(
          widget.workspaceButtons[i].workspace.workspaceTitle);
      WorkspaceButtonStorage workspaceButtonStorage = WorkspaceButtonStorage();
      workspaceButtonStorage
          .setWorkspaceButtonID(widget.workspaceButtons[i].workspaceButtonID);
      workspaceButtonStorage.setWorkspace(workspaceStorage);
      workspaceButtonStorageList.add(workspaceButtonStorage);
    }
    await FirebaseFirestore.instance.collection("users").doc(userID).set({
      'workspacebutton':
          workspaceButtonStorageList.map((y) => y.toMap()).toList(),
    });
  }

  test() async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    DocumentReference documentReference =
        firestore.collection('users').doc(userID);
    DocumentSnapshot snapshot = await documentReference.get();
    if (snapshot.exists) {
      final List<dynamic> mapsList = snapshot.get('workspacebutton');
      for (int i = mapsList.length - 1; i > -1; i--) {
        Map<String, dynamic> map = mapsList[i];
        Map<String, dynamic> mapWorkspace = map['workspace'];
        Workspace workspace = Workspace();
        //
        workspace.setpdfBytesSTORAGE(mapWorkspace['pdfBase64STORAGE']);
        workspace.setcanShowFileSTORAGE(mapWorkspace['canShowFileSTORAGE']);
        workspace.setnonPDFSTORAGE(mapWorkspace['nonPDFSTORAGE']);
        workspace.setfromYouTubeSTORAGE(mapWorkspace['fromYouTubeSTORAGE']);
        workspace.setstatusForAudio2TextSTORAGE(
            mapWorkspace['statusForAudio2TextSTORAGE']);
        workspace.settitleForAudio2TextSTORAGE(
            mapWorkspace['titleForAudio2TextSTORAGE']);
        workspace.setcircularForAudio2TextSTORAGE(
            mapWorkspace['circularForAudio2TextSTORAGE']);
        workspace.setaudio2TextTextFieldText(
            mapWorkspace['audio2TextTextFieldTextSTORAGE']);
        //
        workspace.setWorkspaceTitle(mapWorkspace['workspaceTitle']);
        workspace.setCounterForCard(mapWorkspace['counterForCard']);
        workspace.setCounterForMain(mapWorkspace['counterForMain']);
        workspace.setCounterForPoint(mapWorkspace['counterForPoint']);
        workspace.setSelectedCard(mapWorkspace['selectedCard']);
        workspace.setSelectedMain(mapWorkspace['selectedMain']);
        List<dynamic> mapCards = mapWorkspace['cards'];
        List<Cards> cardsList = [];
        for (int j = 0; j < mapCards.length; j++) {
          Map<String, dynamic> jCard = mapCards[j];
          Cards cards = Cards();
          cards.setCardID(jCard['cardID']);
          List<dynamic> a = jCard['cardBorderColor'];
          cards.setCardBorderColor(
              Color.fromRGBO(a[0].toInt(), a[1].toInt(), a[2].toInt(), a[3]));
          cards.setCardBottomMargin(jCard['cardBottomMargin']);
          cards.setIsCardHiding(jCard['isCardHiding']);
          Map<String, dynamic> mapHeader = jCard['header'];
          Header header = Header();
          header.setContainerWidth(mapHeader['containerWidth']);
          header.setCardID(mapHeader['cardID']);
          header.setHeader(mapHeader['header']);
          cards.setHeader(header);
          List<dynamic> mapMains = jCard['mains'];
          List<Mains> mainsList = [];
          for (int k = 0; k < mapMains.length; k++) {
            Map<String, dynamic> kMain = mapMains[k];
            Mains mains = Mains();
            mains.setContainerWidth(kMain['containerWidth']);
            mains.setCardID(kMain['cardID']);
            mains.setMainID(kMain['mainID']);
            mains.setMain(kMain['main']);
            List<dynamic> b = kMain['mainColor'];
            mains.setMainColor(
                Color.fromRGBO(b[0].toInt(), b[1].toInt(), b[2].toInt(), b[3]));
            mains.setIsMainHiding(kMain['isMainHiding']);
            List<dynamic> mapPoints = kMain['points'];
            List<Points> pointsList = [];
            for (int l = 0; l < mapPoints.length; l++) {
              Map<String, dynamic> lPoint = mapPoints[l];
              Points points = Points();
              points.setContainerWidth(lPoint['containerWidth']);
              points.setCardID(lPoint['cardID']);
              points.setMainID(lPoint['mainID']);
              points.setPointID(lPoint['pointID']);
              points.setPoint(lPoint['point']);
              pointsList.add(points);
            }
            mains.setPoint(pointsList);
            mainsList.add(mains);
          }
          cards.setMainList(mainsList);
          cardsList.add(cards);
        }
        workspace.setCards(cardsList);
        WorkspaceButton workspaceButton = WorkspaceButton();
        workspaceButton.setIsWorkspaceAddButton(false);
        workspaceButton.setWorkspaceButtonID(map['workspaceButtonID']);
        workspaceButton.setWorkspace(workspace);
        workspaceButton.setStartDeleteMode(startDeleteMode);
        workspaceButton.setContainerColor(const Color.fromRGBO(0, 150, 136, 1));
        workspaceButton.setDeleteMode(false);
        workspaceButton.setCheckIfAllWorkspaceButtonUnselected(
            checkIfAllWorkspaceButtonUnselected);
        workspaceButton.setForDelete(false);
        widget.workspaceButtons.insert(1, workspaceButton);
        setState(() {});
      }
    }
  }

  getUserIDAndEmail() {
    final FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;
    String? uid = user?.uid;
    userID = uid!;
    String? uemail = user?.email;
    userEmail = uemail!;
    setState(() {});
  }

  setWorkspaceAddButton() {
    WorkspaceButton workspaceAddButton = WorkspaceButton();
    workspaceAddButton.setAddWorkspace(addWorkspace);
    widget.workspaceButtons.add(workspaceAddButton);
  }

  checkIfAllWorkspaceButtonUnselected(bool a) {
    if (a == true) {
      bool isCloseDeleteMode = true;
      for (int i = 0; i < widget.workspaceButtons.length; i++) {
        if (widget.workspaceButtons[i].forDelete == true) {
          isCloseDeleteMode = false;
        }
      }
      if (isCloseDeleteMode == true) {
        closeDeleteMode();
      }
    }
  }

  addWorkspace(bool a) async {
    if (deleteMode == false) {
      if (a == true) {
        WorkspaceButton workspaceButton = WorkspaceButton();
        workspaceButton.setIsWorkspaceAddButton(false);
        workspaceButton.setWorkspaceButtonID(const Uuid().v4());
        workspaceButton.setWorkspaceNew(Workspace());
        workspaceButton.setStartDeleteMode(startDeleteMode);
        workspaceButton.setContainerColor(const Color.fromRGBO(0, 150, 136, 1));
        workspaceButton.setDeleteMode(false);
        workspaceButton.setCheckIfAllWorkspaceButtonUnselected(
            checkIfAllWorkspaceButtonUnselected);
        workspaceButton.setForDelete(false);
        widget.workspaceButtons.insert(1, workspaceButton);
        await Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => workspaceButton.workspace),
        );
        setState(() {});
      }
    }
  }

  startDeleteMode(bool a, String b) {
    if (a == true) {
      deleteMode = true;
      List<WorkspaceButton> workspaceButtonsCopy = [];
      for (int i = 0; i < widget.workspaceButtons.length; i++) {
        if (i == 0) {
          WorkspaceButton workspaceAddButton = WorkspaceButton();
          workspaceAddButton.setAddWorkspace(addWorkspace);
          workspaceButtonsCopy.add(workspaceAddButton);
        } else {
          WorkspaceButton workspaceButtonCopy = WorkspaceButton();
          workspaceButtonCopy.setIsWorkspaceAddButton(false);
          workspaceButtonCopy
              .setWorkspace(widget.workspaceButtons[i].workspace);
          workspaceButtonCopy.setStartDeleteMode(startDeleteMode);
          if (widget.workspaceButtons[i].workspaceButtonID == b) {
            workspaceButtonCopy
                .setContainerColor(const Color.fromRGBO(244, 67, 54, 1));
            workspaceButtonCopy.setForDelete(true);
          } else {
            workspaceButtonCopy
                .setContainerColor(const Color.fromRGBO(0, 150, 136, 1));
            workspaceButtonCopy.setForDelete(false);
          }
          workspaceButtonCopy.setDeleteMode(true);
          workspaceButtonCopy.setCheckIfAllWorkspaceButtonUnselected(
              checkIfAllWorkspaceButtonUnselected);
          workspaceButtonCopy.setWorkspaceButtonID(
              widget.workspaceButtons[i].workspaceButtonID);
          workspaceButtonsCopy.add(workspaceButtonCopy);
        }
      }
      widget.workspaceButtons = workspaceButtonsCopy;
      setState(() {});
    }
  }

  deleteWorkspace() {
    List<WorkspaceButton> workspaceButtonsCopy = [];
    for (int i = 0; i < widget.workspaceButtons.length; i++) {
      if (i == 0) {
        WorkspaceButton workspaceAddButton = WorkspaceButton();
        workspaceAddButton.setAddWorkspace(addWorkspace);
        workspaceButtonsCopy.add(workspaceAddButton);
      } else {
        if (widget.workspaceButtons[i].forDelete == true) {
        } else {
          WorkspaceButton workspaceButtonCopy = WorkspaceButton();
          workspaceButtonCopy.setIsWorkspaceAddButton(false);
          workspaceButtonCopy
              .setWorkspace(widget.workspaceButtons[i].workspace);
          workspaceButtonCopy.setStartDeleteMode(startDeleteMode);
          workspaceButtonCopy
              .setContainerColor(const Color.fromRGBO(0, 150, 136, 1));
          workspaceButtonCopy.setDeleteMode(false);
          workspaceButtonCopy.setCheckIfAllWorkspaceButtonUnselected(
              checkIfAllWorkspaceButtonUnselected);
          workspaceButtonCopy.setForDelete(false);
          workspaceButtonCopy.setWorkspaceButtonID(
              widget.workspaceButtons[i].workspaceButtonID);
          workspaceButtonsCopy.add(workspaceButtonCopy);
        }
      }
    }
    widget.workspaceButtons = workspaceButtonsCopy;
    deleteMode = false;
    setState(() {});
  }

  closeDeleteMode() {
    deleteMode = false;
    List<WorkspaceButton> workspaceButtonsCopy = [];
    for (int i = 0; i < widget.workspaceButtons.length; i++) {
      if (i == 0) {
        WorkspaceButton workspaceAddButton = WorkspaceButton();
        workspaceAddButton.setAddWorkspace(addWorkspace);
        workspaceButtonsCopy.add(workspaceAddButton);
      } else {
        WorkspaceButton workspaceButtonCopy = WorkspaceButton();
        workspaceButtonCopy.setIsWorkspaceAddButton(false);
        workspaceButtonCopy.setWorkspace(widget.workspaceButtons[i].workspace);
        workspaceButtonCopy.setStartDeleteMode(startDeleteMode);
        workspaceButtonCopy
            .setContainerColor(const Color.fromRGBO(0, 150, 136, 1));
        workspaceButtonCopy.setDeleteMode(false);
        workspaceButtonCopy.setCheckIfAllWorkspaceButtonUnselected(
            checkIfAllWorkspaceButtonUnselected);
        workspaceButtonCopy.setForDelete(false);
        workspaceButtonCopy
            .setWorkspaceButtonID(widget.workspaceButtons[i].workspaceButtonID);
        workspaceButtonsCopy.add(workspaceButtonCopy);
      }
    }
    widget.workspaceButtons = workspaceButtonsCopy;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(builder: (context, orientation) {
      return orientation == Orientation.landscape
          ? Scaffold(
              appBar: AppBar(
                titleSpacing: 0,
                backgroundColor: const Color.fromRGBO(121, 85, 72, 1),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(right: 10),
                      child: Row(
                        children: [
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
                                        const Color.fromRGBO(255, 255, 255, 1),
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(7))),
                                    onPressed: () async {
                                      await storeWorkspacesToFirebase();
                                      FirebaseAuth.instance.signOut();
                                    },
                                    child: const Icon(
                                        color: Color.fromRGBO(121, 85, 72, 1),
                                        size: 20,
                                        MaterialCommunityIcons
                                            .arrow_right_bold)),
                              )),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              body: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                      flex: 3,
                      child: Container(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 1,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text("Workspace",
                                        style: TextStyle(
                                            height: 1,
                                            color:
                                                Color.fromRGBO(121, 85, 72, 1),
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold)),
                                    deleteMode == true
                                        ? Container(
                                            alignment: Alignment.topRight,
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(7),
                                              child: SingleChildScrollView(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                child: Row(
                                                  children: [
                                                    SizedBox(
                                                      width: 45,
                                                      height: 45,
                                                      child:
                                                          FloatingActionButton(
                                                              heroTag:
                                                                  UniqueKey(),
                                                              elevation: 0,
                                                              backgroundColor:
                                                                  const Color
                                                                          .fromRGBO(
                                                                      244,
                                                                      67,
                                                                      54,
                                                                      1),
                                                              shape: const RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius.all(
                                                                          Radius
                                                                              .circular(
                                                                                  50))),
                                                              onPressed: () {
                                                                deleteWorkspace();
                                                              },
                                                              child: const Icon(
                                                                  color: Color
                                                                      .fromRGBO(
                                                                          255,
                                                                          255,
                                                                          255,
                                                                          1),
                                                                  size: 20,
                                                                  MaterialCommunityIcons
                                                                      .delete)),
                                                    ),
                                                    const SizedBox(width: 5),
                                                    SizedBox(
                                                      width: 45,
                                                      height: 45,
                                                      child:
                                                          FloatingActionButton(
                                                              heroTag:
                                                                  UniqueKey(),
                                                              elevation: 0,
                                                              backgroundColor:
                                                                  const Color
                                                                          .fromRGBO(
                                                                      0,
                                                                      150,
                                                                      136,
                                                                      1),
                                                              shape: const RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius.all(
                                                                          Radius
                                                                              .circular(
                                                                                  50))),
                                                              onPressed: () {
                                                                closeDeleteMode();
                                                              },
                                                              child: const Icon(
                                                                  color: Color
                                                                      .fromRGBO(
                                                                          255,
                                                                          255,
                                                                          255,
                                                                          1),
                                                                  size: 20,
                                                                  MaterialCommunityIcons
                                                                      .close)),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          )
                                        : Container()
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 9,
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10)),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: ScrollConfiguration(
                                      behavior: const CustomScrollBehavior(),
                                      child: SingleChildScrollView(
                                        scrollDirection: Axis.vertical,
                                        child: Wrap(
                                          runSpacing: 10.0,
                                          spacing: 10.0,
                                          children: List.generate(
                                            widget.workspaceButtons.length,
                                            (index) =>
                                                widget.workspaceButtons[index],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ))),
                  Expanded(
                    flex: 1,
                    child: Container(
                      alignment: Alignment.topCenter,
                      padding:
                          const EdgeInsets.only(top: 25, left: 25, right: 25),
                      decoration: const BoxDecoration(
                        color: Color.fromRGBO(0, 150, 136, 1),
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Flexible(
                                    child: FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: Text(userEmail,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Color.fromRGBO(
                                                255, 255, 255, 1),
                                            fontSize: 25,
                                          )),
                                    ),
                                  ),
                                ],
                              )
                            ]),
                      ),
                    ),
                  ),
                ],
              ),
            )
          : Scaffold(
              appBar: AppBar(
                titleSpacing: 0,
                backgroundColor: const Color.fromRGBO(121, 85, 72, 1),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(right: 10),
                      child: Row(
                        children: [
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
                                        const Color.fromRGBO(255, 255, 255, 1),
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(7))),
                                    onPressed: () async {
                                      await storeWorkspacesToFirebase();
                                      FirebaseAuth.instance.signOut();
                                    },
                                    child: const Icon(
                                        color: Color.fromRGBO(121, 85, 72, 1),
                                        size: 20,
                                        MaterialCommunityIcons
                                            .arrow_right_bold)),
                              )),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              body: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                      flex: 3,
                      child: Container(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 1,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text("Workspace",
                                        style: TextStyle(
                                            height: 1,
                                            color:
                                                Color.fromRGBO(121, 85, 72, 1),
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold)),
                                    deleteMode == true
                                        ? Container(
                                            alignment: Alignment.topRight,
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(7),
                                              child: SingleChildScrollView(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                child: Row(
                                                  children: [
                                                    SizedBox(
                                                      width: 45,
                                                      height: 45,
                                                      child:
                                                          FloatingActionButton(
                                                              heroTag:
                                                                  UniqueKey(),
                                                              elevation: 0,
                                                              backgroundColor:
                                                                  const Color
                                                                          .fromRGBO(
                                                                      244,
                                                                      67,
                                                                      54,
                                                                      1),
                                                              shape: const RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius.all(
                                                                          Radius
                                                                              .circular(
                                                                                  50))),
                                                              onPressed: () {
                                                                deleteWorkspace();
                                                              },
                                                              child: const Icon(
                                                                  color: Color
                                                                      .fromRGBO(
                                                                          255,
                                                                          255,
                                                                          255,
                                                                          1),
                                                                  size: 20,
                                                                  MaterialCommunityIcons
                                                                      .delete)),
                                                    ),
                                                    const SizedBox(width: 5),
                                                    SizedBox(
                                                      width: 45,
                                                      height: 45,
                                                      child:
                                                          FloatingActionButton(
                                                              heroTag:
                                                                  UniqueKey(),
                                                              elevation: 0,
                                                              backgroundColor:
                                                                  const Color
                                                                          .fromRGBO(
                                                                      0,
                                                                      150,
                                                                      136,
                                                                      1),
                                                              shape: const RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius.all(
                                                                          Radius
                                                                              .circular(
                                                                                  50))),
                                                              onPressed: () {
                                                                closeDeleteMode();
                                                              },
                                                              child: const Icon(
                                                                  color: Color
                                                                      .fromRGBO(
                                                                          255,
                                                                          255,
                                                                          255,
                                                                          1),
                                                                  size: 20,
                                                                  MaterialCommunityIcons
                                                                      .close)),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          )
                                        : Container()
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 16,
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10)),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: ScrollConfiguration(
                                      behavior: const CustomScrollBehavior(),
                                      child: SingleChildScrollView(
                                        scrollDirection: Axis.vertical,
                                        child: Wrap(
                                          runSpacing: 10.0,
                                          spacing: 10.0,
                                          children: List.generate(
                                            widget.workspaceButtons.length,
                                            (index) =>
                                                widget.workspaceButtons[index],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ))),
                  Expanded(
                    flex: 1,
                    child: Container(
                      alignment: Alignment.topCenter,
                      padding:
                          const EdgeInsets.only(top: 25, left: 25, right: 25),
                      decoration: const BoxDecoration(
                        color: Color.fromRGBO(0, 150, 136, 1),
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Flexible(
                                    child: FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: Text(userEmail,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Color.fromRGBO(
                                                255, 255, 255, 1),
                                            fontSize: 25,
                                          )),
                                    ),
                                  ),
                                ],
                              )
                            ]),
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
class WorkspaceButton extends StatefulWidget {
  WorkspaceButton({super.key});
  late String workspaceButtonID;
  late Workspace workspace;
  late bool isWorkspaceAddButton;
  late Function addWorkspace = () {};
  late Color containerColor;
  late Function startDeleteMode;
  late bool deleteMode;
  late bool forDelete;
  late Function checkIfAllWorkspaceButtonUnselected;

  setForDelete(bool a) {
    forDelete = a;
  }

  setWorkspaceButtonID(String a) {
    workspaceButtonID = a;
  }

  setCheckIfAllWorkspaceButtonUnselected(Function a) {
    checkIfAllWorkspaceButtonUnselected = a;
  }

  setAddWorkspace(Function a) {
    addWorkspace = a;
    isWorkspaceAddButton = true;
    workspace = Workspace();
    containerColor = const Color.fromRGBO(0, 150, 136, 1);
    startDeleteMode = () {};
    deleteMode = false;
    checkIfAllWorkspaceButtonUnselected = () {};
    workspaceButtonID = "";
    forDelete = false;
  }

  setIsWorkspaceAddButton(bool a) {
    isWorkspaceAddButton = a;
  }

  setWorkspaceNew(Workspace a) {
    workspace = a;
    workspace.setCards([]);
    workspace.setCounterForCard(0);
    workspace.setCounterForMain(0);
    workspace.setCounterForPoint(0);
    workspace.setSelectedCard(0);
    workspace.setSelectedMain(0);
    workspace.setWorkspaceTitle("Untitled");
  }

  setWorkspace(Workspace a) {
    workspace = a;
  }

  setContainerColor(Color a) {
    containerColor = a;
  }

  setStartDeleteMode(Function a) {
    startDeleteMode = a;
  }

  setDeleteMode(bool a) {
    deleteMode = a;
  }

  @override
  State<WorkspaceButton> createState() => _WorkspaceButtonState();
}

class _WorkspaceButtonState extends State<WorkspaceButton> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.isWorkspaceAddButton == true
        ? GestureDetector(
            onTap: () {
              if (widget.deleteMode == false) {
                widget.addWorkspace(true);
              }
            },
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: const Color.fromARGB(179, 158, 158, 158),
                  borderRadius: BorderRadius.circular(10)),
              width: 300,
              height: 243,
              padding: const EdgeInsets.all(10.0),
              child: const Icon(
                  color: Color.fromRGBO(255, 255, 255, 1),
                  size: 100,
                  MaterialCommunityIcons.plus),
            ),
          )
        : GestureDetector(
            onLongPress: () {
              widget.startDeleteMode(true, widget.workspaceButtonID);
            },
            onTap: () async {
              if (widget.deleteMode == false) {
                await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => widget.workspace),
                );
                setState(() {});
              } else {
                if (widget.forDelete == false) {
                  widget.containerColor = const Color.fromRGBO(244, 67, 54, 1);
                  widget.forDelete = true;
                } else {
                  widget.containerColor = const Color.fromRGBO(0, 150, 136, 1);
                  widget.forDelete = false;
                }
                widget.checkIfAllWorkspaceButtonUnselected(true);
                setState(() {});
              }
            },
            child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: widget.containerColor,
                    borderRadius: BorderRadius.circular(10)),
                width: 300,
                height: 243,
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                        flex: 3,
                        child: Container(
                          alignment: Alignment.topLeft,
                          child: Text(
                            overflow: TextOverflow.ellipsis,
                            widget.workspace.workspaceTitle,
                            style: const TextStyle(
                                color: Color.fromRGBO(255, 255, 255, 1),
                                fontSize: 18),
                          ),
                        )),
                    Expanded(
                        flex: 13,
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10)),
                        )),
                    Expanded(
                        flex: 2,
                        child: Container(
                            alignment: Alignment.bottomRight,
                            child: const Text(
                              "Just now",
                              style: TextStyle(
                                  color: Color.fromRGBO(255, 255, 255, 1),
                                  fontSize: 11),
                            )))
                  ],
                )),
          );
  }
}
