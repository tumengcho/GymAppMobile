import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

class Utils{
  static Future<File> getImageFileFromAssets(String assetPath) async {
    final byteData = await rootBundle.load(assetPath);

    final tempDir = await getTemporaryDirectory();
    final file = File('${tempDir.path}/${assetPath.split('/').last}');

    await file.writeAsBytes(
      byteData.buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes),
    );

    return file;
  }

  static String formatTime(int sec) {
    final minutes = (sec ~/ 60).toString().padLeft(2, '0');
    final seconds = (sec % 60).toString().padLeft(2, '0');
    return "$minutes:$seconds";
  }

  static Future<String> getRandomBreakQuote() async {
    final String response = await rootBundle.loadString('assets/data/rest_quotes.json');

    final data = json.decode(response);

    final List quotes = data['rest_quotes'];

    final random = Random();
    return quotes[random.nextInt(quotes.length)];
  }
}