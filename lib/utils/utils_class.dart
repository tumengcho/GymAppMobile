import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gymapp/dtos/dto_product_info.dart';
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
    quotes.shuffle(random);
    return quotes[0];
  }

  static Future<Map<String, dynamic>> getRandomMotivationQuote() async {
    final String response = await rootBundle.loadString('assets/data/main_page_quotes.json');
    final List<dynamic> quotes = json.decode(response);

    final random = Random();
    quotes.shuffle(random);
    return quotes[0];
  }
  static void showProductModal(BuildContext context, ProductInfo? product) {

    TextEditingController perServingController = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      builder: (context) {
        return Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
            color: Colors.black,

          ),
          padding: EdgeInsets.all(20),
          height: double.maxFinite,
          child: product != null ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(flex: 10, child: product.images == null ? Image.asset("assets/images/unknown_image.jpg"): Image.network(product.images!)),
              SizedBox(height: 15),
              Text(product.name,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  )),
              const Spacer(),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "${product.calories}",
                      style: const TextStyle(
                        color: Color(0xFFD3FF55),
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        letterSpacing: 1,
                      ),
                    ),
                    const TextSpan(
                      text: " kcal 🔥",
                      style: TextStyle(fontSize: 12),
                    ),
                    TextSpan(
                        text: " / ${product.serving}",
                        style: TextStyle(fontWeight: FontWeight.bold)
                    ),
                  ],
                ),
              ),
              const Spacer(),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(40)),
                          child: SvgPicture.asset(
                            'assets/icons/steak.svg',
                            // your SVG file in assets
                            width: 20,
                            height: 20,
                            color: Colors.red,
                          ),
                        ),
                        const Spacer(),
                        Text("${product.protein} g", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red),),
                        const Spacer(),

                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(40)),
                          child: SvgPicture.asset(
                            'assets/icons/avocado.svg',
                            // your SVG file in assets
                            width: 20,
                            height: 20,
                            color: Colors.green,
                          ),
                        ),
                        const Spacer(),
                        Text("${product.fat} g", style: TextStyle(fontWeight: FontWeight.bold,color: Colors.green)),
                        const Spacer(),

                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(40)),
                          child: SvgPicture.asset(
                            'assets/icons/bread.svg',
                            // your SVG file in assets
                            width: 20,
                            height: 20,
                            color: Colors.blueAccent,
                          ),
                        ),
                        const Spacer(),
                        Text("${product.calbs} g", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blueAccent)),
                        const Spacer(),

                      ],
                    ),
                  ),
                ],
              ),
              const Spacer(),

              TextFormField(
                controller: perServingController ,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Quantity taken',
                  border: OutlineInputBorder(),
                ),
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
              ),
              const Spacer(),
              Container(
                width: double.maxFinite,
                child: ElevatedButton(
                  onPressed: () => perServingController.text.isEmpty ? null : Navigator.pop(context),
                  child: const Text("Add meal"),
                ),
              )
            ],
          ):Center(child: Text("Product not found."),),
        );
      },
    );
  }

}