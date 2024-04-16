import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/change_notifier.dart';
import 'package:http/http.dart' as http;

Future<String> runMP42MP3Model(String base64String) async {
  final response = await http.post(
    Uri.parse('https://flyboytarantino14-test5.hf.space/run/predict'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, List<dynamic>>{
      'data': [
        {"name": "video.mp4", "data": "data:video/mp4;base64,$base64String"}
      ]
    }),
  );
  if (response.statusCode == 200) {
    final detectionResult = jsonDecode(response.body)["data"];
    String x = detectionResult.toString();
    print(x);
    x = x.substring(1, x.length - 1);
    x = x.trim();
    return x;
  } else {
    return "";
  }
}

Future<String> runSRModel(String base64String) async {
  final response = await http.post(
    Uri.parse('https://flyboytarantino14-test2.hf.space/run/predict'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, List<dynamic>>{
      'data': [
        {"name": "audio.mp3", "data": "data:audio/mp3;base64,$base64String"}
      ]
    }),
  );
  if (response.statusCode == 200) {
    final detectionResult = jsonDecode(response.body)["data"];
    String x = detectionResult.toString();
    x = x.substring(1, x.length - 1);
    x = x.trim();
    return x;
  } else {
    return "";
  }
}

Future<String> runQGModel(String textContext, String textAnswer) async {
  final response = await http.post(
    Uri.parse('https://flyboytarantino14-test1.hf.space/run/predict'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, List<dynamic>>{
      'data': [textContext, textAnswer]
    }),
  );
  if (response.statusCode == 200) {
    final detectionResult = jsonDecode(response.body)["data"];
    String x = detectionResult.toString();
    x = x.substring(1, x.length - 1);
    List<String> questionList = x.split("Â§");
    return questionList[2];
  } else {
    return "";
  }
}

Future<String> runYTModel(String videoURL) async {
  final response = await http.post(
    Uri.parse('https://flyboytarantino14-test4.hf.space/run/predict'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, List<dynamic>>{
      'data': [videoURL]
    }),
  );
  if (response.statusCode == 200) {
    final detectionResult = jsonDecode(response.body)["data"];
    String x = detectionResult.toString();
    x = x.substring(1, x.length - 1);
    return x;
  } else {
    return "";
  }
}

Future<String> runSSModel(String actualAnswer, String userAnswer) async {
  final response = await http.post(
    Uri.parse('https://flyboytarantino14-test3.hf.space/run/predict'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      "Access-Control-Allow-Origin": "*"
    },
    body: jsonEncode(<String, List<dynamic>>{
      'data': [actualAnswer, userAnswer]
    }),
  );
  if (response.statusCode == 200) {
    final detectionResult = jsonDecode(response.body)["data"];
    String x = detectionResult.toString();
    x = x.substring(1, x.length - 1);
    int percentage = int.parse(x);
    String y = "";
    if (percentage <= 0) {
      y = "0%";
    } else {
      y = "$x%";
    }
    return y;
  } else {
    return "";
  }
}

double getTextWidth(String text) {
  final TextPainter textPainter = TextPainter(
    text: TextSpan(
      text: text,
      style: const TextStyle(fontSize: 20.0),
    ),
    textDirection: TextDirection.ltr,
  )..layout(maxWidth: double.infinity);
  return textPainter.width + 50;
}

class CustomColorSelectionHandle extends TextSelectionControls {
  CustomColorSelectionHandle(this.handleColor)
      : _controls = materialTextSelectionControls;
  final Color handleColor;
  final TextSelectionControls _controls;
  Widget _wrapWithThemeData(Widget Function(BuildContext) builder) =>
      TextSelectionTheme(
          data: TextSelectionThemeData(selectionHandleColor: handleColor),
          child: Builder(builder: builder));
  @override
  Widget buildHandle(BuildContext context, TextSelectionHandleType type,
          double textLineHeight, [VoidCallback? onTap]) =>
      _wrapWithThemeData((BuildContext context) =>
          _controls.buildHandle(context, type, textLineHeight, onTap));
  @override
  Offset getHandleAnchor(TextSelectionHandleType type, double textLineHeight) {
    return _controls.getHandleAnchor(type, textLineHeight);
  }

  @override
  Size getHandleSize(double textLineHeight) {
    return _controls.getHandleSize(textLineHeight);
  }

  @override
  Widget buildToolbar(
      BuildContext context,
      Rect globalEditableRegion,
      double textLineHeight,
      Offset selectionMidpoint,
      List<TextSelectionPoint> endpoints,
      TextSelectionDelegate delegate,
      ValueListenable<ClipboardStatus>? clipboardStatus,
      Offset? lastSecondaryTapDownPosition) {
    // ignore: deprecated_member_use
    return _controls.buildToolbar(
        context,
        globalEditableRegion,
        textLineHeight,
        selectionMidpoint,
        endpoints,
        delegate,
        clipboardStatus,
        lastSecondaryTapDownPosition);
  }

  // @override
  // Widget buildToolbar(
  //     BuildContext context,
  //     Rect globalEditableRegion,
  //     double textLineHeight,
  //     Offset selectionMidpoint,
  //     List<TextSelectionPoint> endpoints,
  //     TextSelectionDelegate delegate,
  //     ClipboardStatusNotifier? clipboardStatus,
  //     Offset? lastSecondaryTapDownPosition) {
  //   // ignore: deprecated_member_use
  //   return _controls.buildToolbar(
  //       context,
  //       globalEditableRegion,
  //       textLineHeight,
  //       selectionMidpoint,
  //       endpoints,
  //       delegate,
  //       clipboardStatus,
  //       lastSecondaryTapDownPosition);
  // }
}

Future<dynamic> getDetail(String userUrl) async {
  String embedUrl = "https://www.youtube.com/oembed?url=$userUrl&format=json";
  var res = await http.get(Uri.parse(embedUrl));
  try {
    if (res.statusCode == 200) {
      return json.decode(res.body);
    } else {
      return null;
    }
  } on FormatException {
    return null;
  }
}

List<String> audioBytesToBase64(Uint8List audioData) {
  int audioLengthInSeconds = (audioData.lengthInBytes / 48000 / 2).ceil();
  List<Uint8List> audioChunks = [];
  for (int i = 0; i < audioLengthInSeconds; i += 20) {
    int startByte = i * 48000 * 2;
    int endByte = (i + 20) * 48000 * 2;
    if (endByte > audioData.length) {
      endByte = audioData.length;
    }
    Uint8List chunk = audioData.sublist(startByte, endByte);
    audioChunks.add(chunk);
  }
  List<String> base64StringList = [];
  for (int i = 0; i < audioChunks.length; i++) {
    String base64String = base64.encode(audioChunks[i]);
    base64StringList.add(base64String);
  }
  return base64StringList;
}

class CustomScrollBehavior extends ScrollBehavior {
  const CustomScrollBehavior();
  @override
  Widget buildScrollbar(context, child, details) {
    return child;
  }
}

List<double> rgbaToList(Color color) {
  double red = color.red.toDouble();
  double green = color.green.toDouble();
  double blue = color.blue.toDouble();
  double opacity = color.opacity.toDouble();
  return [red, green, blue, opacity];
}
