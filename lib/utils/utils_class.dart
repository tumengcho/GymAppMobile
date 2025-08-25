import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gymapp/dtos/dto_daily_nutrition.dart';
import 'package:gymapp/dtos/dto_product_info.dart';
import 'package:gymapp/service/service_database.dart';
import 'package:path_provider/path_provider.dart';

class Utils {
  static Future<File> getImageFileFromAssets(String assetPath) async {
    final byteData = await rootBundle.load(assetPath);

    final tempDir = await getTemporaryDirectory();
    final file = File('${tempDir.path}/${assetPath.split('/').last}');

    await file.writeAsBytes(
      byteData.buffer
          .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes),
    );

    return file;
  }

  static String formatTime(int sec) {
    final minutes = (sec ~/ 60).toString().padLeft(2, '0');
    final seconds = (sec % 60).toString().padLeft(2, '0');
    return "$minutes:$seconds";
  }

  static Future<String> getRandomBreakQuote() async {
    final String response =
        await rootBundle.loadString('assets/data/rest_quotes.json');

    final data = json.decode(response);

    final List quotes = data['rest_quotes'];

    final random = Random();
    quotes.shuffle(random);
    return quotes[0];
  }

  static Future<Map<String, dynamic>> getRandomMotivationQuote() async {
    final String response =
        await rootBundle.loadString('assets/data/main_page_quotes.json');
    final List<dynamic> quotes = json.decode(response);

    final random = Random();
    quotes.shuffle(random);
    return quotes[0];
  }

  static void showProductModal(
      BuildContext context, ProductInfo? product, String categoryContext) {
    TextEditingController perServingController = TextEditingController();
    TextEditingController _protein =
        TextEditingController(text: "${product?.protein.toInt()}");
    FocusNode _proteinFocus = FocusNode();
    TextEditingController _fat =
        TextEditingController(text: "${product?.fat.toInt()}");
    FocusNode _fatFocus = FocusNode();
    TextEditingController _carbs =
        TextEditingController(text: "${product?.calbs.toInt()}");
    FocusNode _carbsFocus = FocusNode();
    TextEditingController _calories =
        TextEditingController(text: "${product?.calories.toInt()}");
    FocusNode _caloriesFocus = FocusNode();

    void addProduct() {
      Database.addMeal(
          product!, double.parse(perServingController.text), categoryContext);

      Navigator.pop(context);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                    text: "${product.name}",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                const TextSpan(
                  text: " has been added to your ",
                ),
                TextSpan(
                    text: "$categoryContext",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: MealCardColors[categoryContext])),
              ],
            ),
          ),
          duration: const Duration(seconds: 2),
          backgroundColor: Colors.black,
        ),
      );
    }

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
          padding: const EdgeInsets.all(20),
          height: double.maxFinite,
          child: product != null
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                        flex: 10,
                        child: product.images == null
                            ? Image.asset("assets/images/unknown_image.jpg")
                            : Image.network(product.images!)),
                    const SizedBox(height: 15),
                    Text(product.name,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        )),
                    const Spacer(),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          width: 50,
                          child: EditableText(
                            controller: _calories,
                            style: const TextStyle(
                              color: Color(0xFFD3FF55),
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              letterSpacing: 1,
                            ),
                            cursorColor: Colors.blue,
                            backgroundCursorColor: Colors.grey,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            focusNode: _caloriesFocus,
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                            children: [
                              const TextSpan(
                                text: " kcal 🔥",
                                style: TextStyle(fontSize: 12),
                              ),
                              TextSpan(
                                  text: " / ${product.serving}",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(10),
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
                              Expanded(
                                child: EditableText(
                                  controller: _protein,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red),
                                  cursorColor: Colors.blue,
                                  backgroundCursorColor: Colors.grey,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                  ],
                                  focusNode: _proteinFocus,
                                ),
                              ),
                              const Spacer(),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(10),
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
                              Expanded(
                                child: EditableText(
                                  controller: _fat,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green),
                                  cursorColor: Colors.blue,
                                  backgroundCursorColor: Colors.grey,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                  ],
                                  focusNode: _fatFocus,
                                ),
                              ),
                              const Spacer(),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(10),
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
                              Expanded(
                                child: EditableText(
                                  controller: _carbs,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blueAccent),
                                  cursorColor: Colors.blue,
                                  backgroundCursorColor: Colors.grey,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                  ],
                                  focusNode: _carbsFocus,
                                ),
                              ),
                              const Spacer(),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    TextFormField(
                      controller: perServingController,
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
                    SizedBox(
                      width: double.maxFinite,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              WidgetStateProperty.all<Color>(Colors.green),
                        ),
                        onPressed: () => perServingController.text.isEmpty
                            ? null
                            : addProduct(),
                        child: const Text("Add meal"),
                      ),
                    )
                  ],
                )
              : const Center(
                  child: Text("Product not found."),
                ),
        );
      },
    ).whenComplete(() {
      _proteinFocus.dispose();
      _fatFocus.dispose();
      _carbsFocus.dispose();
      _caloriesFocus.dispose();
    });
    ;
  }
}
