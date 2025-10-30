import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

// ignore: must_be_immutable
class HelpOverlay extends StatefulWidget {
  HelpOverlay({super.key});
  late Function hideHelpOverlay;

  void setHideHelpOverlay(Function a) {
    hideHelpOverlay = a;
  }

  @override
  State<HelpOverlay> createState() => _HelpOverlayState();
}

class _HelpOverlayState extends State<HelpOverlay> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(builder: (context, orientation) {
      return orientation == Orientation.landscape
          ? Material(
              color: const Color.fromRGBO(0, 0, 0, 0.8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(
                          top: 100, bottom: 100, left: 100, right: 100),
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.teal,
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
                                const Text("Help",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 25,
                                        color:
                                            Color.fromRGBO(255, 255, 255, 1))),
                                SizedBox(
                                  width: 45,
                                  child: FloatingActionButton(
                                      elevation: 0,
                                      backgroundColor: Colors.brown,
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10))),
                                      onPressed: () {
                                        widget.hideHelpOverlay();
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
                            flex: 11,
                            child: Container(
                                margin:
                                    const EdgeInsets.only(top: 20, bottom: 20),
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      Container(
                                        margin:
                                            const EdgeInsets.only(bottom: 22),
                                        child: Row(
                                          children: [
                                            Container(
                                                alignment: Alignment.center,
                                                height: 55,
                                                width: 55,
                                                child: Container(
                                                  decoration:
                                                      const BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          7))),
                                                  height: 35,
                                                  width: 35,
                                                  child: const Icon(
                                                    color: Color.fromRGBO(
                                                        121, 85, 72, 1),
                                                    size: 20,
                                                    MaterialCommunityIcons
                                                        .youtube,
                                                  ),
                                                )),
                                            const SizedBox(width: 20),
                                            const Text(
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.white,
                                                    fontSize: 20),
                                                "Grabs a YouTube video using its URL link")
                                          ],
                                        ),
                                      ),
                                      Container(
                                        margin:
                                            const EdgeInsets.only(bottom: 22),
                                        child: Row(
                                          children: [
                                            Container(
                                                alignment: Alignment.center,
                                                height: 55,
                                                width: 55,
                                                child: Container(
                                                  decoration:
                                                      const BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          7))),
                                                  height: 35,
                                                  width: 35,
                                                  child: const Icon(
                                                    color: Color.fromRGBO(
                                                        121, 85, 72, 1),
                                                    size: 20,
                                                    MaterialCommunityIcons
                                                        .file_document,
                                                  ),
                                                )),
                                            const SizedBox(width: 20),
                                            const Text(
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.white,
                                                    fontSize: 20),
                                                "Imports a file")
                                          ],
                                        ),
                                      ),
                                      Container(
                                        margin:
                                            const EdgeInsets.only(bottom: 22),
                                        child: Row(
                                          children: [
                                            FloatingActionButton(
                                                heroTag: UniqueKey(),
                                                elevation: 0,
                                                backgroundColor:
                                                    const Color.fromRGBO(
                                                        255, 193, 7, 1),
                                                shape:
                                                    const RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    10))),
                                                onPressed: null,
                                                child: Container(
                                                    padding: const EdgeInsets
                                                        .all(0),
                                                    child: const Icon(
                                                        color: Color.fromRGBO(
                                                            0, 0, 0, 1),
                                                        size: 50,
                                                        MaterialCommunityIcons
                                                            .alpha_h))),
                                            const SizedBox(width: 20),
                                            const Text(
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.white,
                                                    fontSize: 20),
                                                "Adds a new header")
                                          ],
                                        ),
                                      ),
                                      Container(
                                        margin:
                                            const EdgeInsets.only(bottom: 22),
                                        child: Row(
                                          children: [
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
                                                onPressed: null,
                                                child: Container(
                                                    padding:
                                                        const EdgeInsets.all(0),
                                                    child: const Icon(
                                                        color: Color.fromRGBO(
                                                            255, 255, 255, 1),
                                                        size: 50,
                                                        MaterialCommunityIcons
                                                            .alpha_m))),
                                            const SizedBox(width: 20),
                                            const Text(
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.white,
                                                    fontSize: 20),
                                                "Adds a new main point")
                                          ],
                                        ),
                                      ),
                                      Container(
                                        margin:
                                            const EdgeInsets.only(bottom: 22),
                                        child: Row(
                                          children: [
                                            FloatingActionButton(
                                                heroTag: UniqueKey(),
                                                elevation: 0,
                                                backgroundColor:
                                                    const Color.fromRGBO(
                                                        63, 81, 181, 1),
                                                shape: const RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.all(
                                                        Radius.circular(10))),
                                                onPressed: null,
                                                child: Container(
                                                    padding:
                                                        const EdgeInsets.all(0),
                                                    child: const Icon(
                                                        color: Color.fromRGBO(
                                                            255, 255, 255, 1),
                                                        size: 50,
                                                        MaterialCommunityIcons
                                                            .alpha_s))),
                                            const SizedBox(width: 20),
                                            const Text(
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.white,
                                                    fontSize: 20),
                                                "Adds a new supporting point")
                                          ],
                                        ),
                                      ),
                                      Container(
                                        margin:
                                            const EdgeInsets.only(bottom: 22),
                                        child: Row(
                                          children: [
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
                                                onPressed: null,
                                                child: Container(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10),
                                                    child: const Icon(
                                                      Icons.density_medium,
                                                      size: 30,
                                                    ))),
                                            const SizedBox(width: 20),
                                            const Text(
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.white,
                                                    fontSize: 20),
                                                "Hides all cards")
                                          ],
                                        ),
                                      ),
                                      Container(
                                        margin:
                                            const EdgeInsets.only(bottom: 22),
                                        child: Row(
                                          children: [
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
                                                onPressed: null,
                                                child: Container(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10),
                                                    child: const Icon(
                                                      Icons.center_focus_strong,
                                                      size: 30,
                                                    ))),
                                            const SizedBox(width: 20),
                                            const Text(
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.white,
                                                    fontSize: 20),
                                                "Only shows the last modified card")
                                          ],
                                        ),
                                      ),
                                      Container(
                                        margin:
                                            const EdgeInsets.only(bottom: 22),
                                        child: Row(
                                          children: [
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
                                                onPressed: null,
                                                child: Container(
                                                    padding:
                                                        const EdgeInsets.all(0),
                                                    child: const Icon(
                                                        color: Color.fromRGBO(
                                                            255, 255, 255, 1),
                                                        size: 30,
                                                        MaterialCommunityIcons
                                                            .comment_question))),
                                            const SizedBox(width: 20),
                                            const Text(
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.white,
                                                    fontSize: 20),
                                                "Begins self-testing session")
                                          ],
                                        ),
                                      ),
                                      Row(
                                        children: [
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
                                              onPressed: null,
                                              child: Container(
                                                  padding:
                                                      const EdgeInsets.all(0),
                                                  child: const Icon(
                                                      color: Color.fromRGBO(
                                                          255, 255, 255, 1),
                                                      size: 29,
                                                      MaterialCommunityIcons
                                                          .comment_text))),
                                          const SizedBox(width: 20),
                                          const Text(
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.white,
                                                  fontSize: 20),
                                              "Begins self-explaining session")
                                        ],
                                      )
                                    ],
                                  ),
                                )),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          : Material(
              color: const Color.fromRGBO(0, 0, 0, 0.8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(
                          top: 100, bottom: 100, left: 100, right: 100),
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.teal,
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
                                const Text("Help",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 25,
                                        color:
                                            Color.fromRGBO(255, 255, 255, 1))),
                                SizedBox(
                                  width: 45,
                                  child: FloatingActionButton(
                                      elevation: 0,
                                      backgroundColor: Colors.brown,
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10))),
                                      onPressed: () {
                                        widget.hideHelpOverlay();
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
                            flex: 21,
                            child: Container(
                                margin:
                                    const EdgeInsets.only(top: 20, bottom: 20),
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      Container(
                                        margin:
                                            const EdgeInsets.only(bottom: 22),
                                        child: Row(
                                          children: [
                                            Container(
                                                alignment: Alignment.center,
                                                height: 55,
                                                width: 55,
                                                child: Container(
                                                  decoration:
                                                      const BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          7))),
                                                  height: 35,
                                                  width: 35,
                                                  child: const Icon(
                                                    color: Color.fromRGBO(
                                                        121, 85, 72, 1),
                                                    size: 20,
                                                    MaterialCommunityIcons
                                                        .youtube,
                                                  ),
                                                )),
                                            const SizedBox(width: 20),
                                            const Text(
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.white,
                                                    fontSize: 20),
                                                "Grabs a YouTube video using its URL link")
                                          ],
                                        ),
                                      ),
                                      Container(
                                        margin:
                                            const EdgeInsets.only(bottom: 22),
                                        child: Row(
                                          children: [
                                            Container(
                                                alignment: Alignment.center,
                                                height: 55,
                                                width: 55,
                                                child: Container(
                                                  decoration:
                                                      const BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          7))),
                                                  height: 35,
                                                  width: 35,
                                                  child: const Icon(
                                                    color: Color.fromRGBO(
                                                        121, 85, 72, 1),
                                                    size: 20,
                                                    MaterialCommunityIcons
                                                        .file_document,
                                                  ),
                                                )),
                                            const SizedBox(width: 20),
                                            const Text(
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.white,
                                                    fontSize: 20),
                                                "Imports a file")
                                          ],
                                        ),
                                      ),
                                      Container(
                                        margin:
                                            const EdgeInsets.only(bottom: 22),
                                        child: Row(
                                          children: [
                                            Container(
                                                alignment: Alignment.center,
                                                height: 55,
                                                width: 55,
                                                child: Container(
                                                  decoration:
                                                      const BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          7))),
                                                  height: 35,
                                                  width: 35,
                                                  child: const Icon(
                                                    color: Color.fromRGBO(
                                                        121, 85, 72, 1),
                                                    size: 20,
                                                    MaterialCommunityIcons
                                                        .view_split_vertical,
                                                  ),
                                                )),
                                            const SizedBox(width: 20),
                                            const Text(
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.white,
                                                    fontSize: 20),
                                                "Switch between file and note area")
                                          ],
                                        ),
                                      ),
                                      Container(
                                        margin:
                                            const EdgeInsets.only(bottom: 22),
                                        child: Row(
                                          children: [
                                            FloatingActionButton(
                                                heroTag: UniqueKey(),
                                                elevation: 0,
                                                backgroundColor:
                                                    const Color.fromRGBO(
                                                        255, 193, 7, 1),
                                                shape:
                                                    const RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    10))),
                                                onPressed: null,
                                                child: Container(
                                                    padding: const EdgeInsets
                                                        .all(0),
                                                    child: const Icon(
                                                        color: Color.fromRGBO(
                                                            0, 0, 0, 1),
                                                        size: 50,
                                                        MaterialCommunityIcons
                                                            .alpha_h))),
                                            const SizedBox(width: 20),
                                            const Text(
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.white,
                                                    fontSize: 20),
                                                "Adds a new header")
                                          ],
                                        ),
                                      ),
                                      Container(
                                        margin:
                                            const EdgeInsets.only(bottom: 22),
                                        child: Row(
                                          children: [
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
                                                onPressed: null,
                                                child: Container(
                                                    padding:
                                                        const EdgeInsets.all(0),
                                                    child: const Icon(
                                                        color: Color.fromRGBO(
                                                            255, 255, 255, 1),
                                                        size: 50,
                                                        MaterialCommunityIcons
                                                            .alpha_m))),
                                            const SizedBox(width: 20),
                                            const Text(
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.white,
                                                    fontSize: 20),
                                                "Adds a new main point")
                                          ],
                                        ),
                                      ),
                                      Container(
                                        margin:
                                            const EdgeInsets.only(bottom: 22),
                                        child: Row(
                                          children: [
                                            FloatingActionButton(
                                                heroTag: UniqueKey(),
                                                elevation: 0,
                                                backgroundColor:
                                                    const Color.fromRGBO(
                                                        63, 81, 181, 1),
                                                shape: const RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.all(
                                                        Radius.circular(10))),
                                                onPressed: null,
                                                child: Container(
                                                    padding:
                                                        const EdgeInsets.all(0),
                                                    child: const Icon(
                                                        color: Color.fromRGBO(
                                                            255, 255, 255, 1),
                                                        size: 50,
                                                        MaterialCommunityIcons
                                                            .alpha_s))),
                                            const SizedBox(width: 20),
                                            const Text(
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.white,
                                                    fontSize: 20),
                                                "Adds a new supporting point")
                                          ],
                                        ),
                                      ),
                                      Container(
                                        margin:
                                            const EdgeInsets.only(bottom: 22),
                                        child: Row(
                                          children: [
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
                                                onPressed: null,
                                                child: Container(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10),
                                                    child: const Icon(
                                                      Icons.density_medium,
                                                      size: 30,
                                                    ))),
                                            const SizedBox(width: 20),
                                            const Text(
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.white,
                                                    fontSize: 20),
                                                "Hides all cards")
                                          ],
                                        ),
                                      ),
                                      Container(
                                        margin:
                                            const EdgeInsets.only(bottom: 22),
                                        child: Row(
                                          children: [
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
                                                onPressed: null,
                                                child: Container(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10),
                                                    child: const Icon(
                                                      Icons.center_focus_strong,
                                                      size: 30,
                                                    ))),
                                            const SizedBox(width: 20),
                                            const Text(
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.white,
                                                    fontSize: 20),
                                                "Only shows the last modified card")
                                          ],
                                        ),
                                      ),
                                      Container(
                                        margin:
                                            const EdgeInsets.only(bottom: 22),
                                        child: Row(
                                          children: [
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
                                                onPressed: null,
                                                child: Container(
                                                    padding:
                                                        const EdgeInsets.all(0),
                                                    child: const Icon(
                                                        color: Color.fromRGBO(
                                                            255, 255, 255, 1),
                                                        size: 30,
                                                        MaterialCommunityIcons
                                                            .comment_question))),
                                            const SizedBox(width: 20),
                                            const Text(
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.white,
                                                    fontSize: 20),
                                                "Begins self-testing session")
                                          ],
                                        ),
                                      ),
                                      Row(
                                        children: [
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
                                              onPressed: null,
                                              child: Container(
                                                  padding:
                                                      const EdgeInsets.all(0),
                                                  child: const Icon(
                                                      color: Color.fromRGBO(
                                                          255, 255, 255, 1),
                                                      size: 29,
                                                      MaterialCommunityIcons
                                                          .comment_text))),
                                          const SizedBox(width: 20),
                                          const Text(
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.white,
                                                  fontSize: 20),
                                              "Begins self-explaining session")
                                        ],
                                      )
                                    ],
                                  ),
                                )),
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
