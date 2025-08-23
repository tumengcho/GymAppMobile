import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_svg/svg.dart';
import 'package:openfoodfacts/openfoodfacts.dart';

class BarCodeScanner extends StatefulWidget {
  const BarCodeScanner({super.key});

  @override
  State<BarCodeScanner> createState() => _BarCodeScannerState();
}

class _BarCodeScannerState extends State<BarCodeScanner> {
  Product? product;
  TextEditingController perServingController = TextEditingController();
  late Nutriments nutriments;
  String protein = "";
  String fat = "";
  String carbs = "";
  String calories = "";
  void _openModal(BuildContext context) {
    if(product != null){
      Nutriments nutriments = product!.nutriments!;
      String protein = nutriments.getValue(Nutrient.proteins, PerSize.serving) != null ? nutriments.getValue(Nutrient.proteins, PerSize.serving).toString() : "Unknown";
      String fat = nutriments.getValue(Nutrient.fat, PerSize.serving) != null ? nutriments.getValue(Nutrient.fat, PerSize.serving).toString() : "Unknown";
      String carbs = nutriments.getValue(Nutrient.carbohydrates, PerSize.serving) != null ? nutriments.getValue(Nutrient.carbohydrates, PerSize.serving).toString() : "Unknown";
      String calories = nutriments.getValue(Nutrient.energyKCal, PerSize.serving) != null ? nutriments.getValue(Nutrient.energyKCal, PerSize.serving).toString() : "Unknown";
    }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      builder: (context) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
            color: Colors.black,

          ),
          padding: EdgeInsets.all(20),
          height: double.maxFinite,
          child: product != null ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(flex: 10, child: Image.network(product!.imageFrontUrl!)),
              SizedBox(height: 15),
              Text(product!.productName ?? "Product not found",
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  )),
              const Spacer(),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: calories,
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
                      text: " / ${product!.servingSize}",
                      style: TextStyle(fontWeight: FontWeight.bold)
                    ),
                  ],
                ),
              ),
              // Text("$calories kcal 🔥 / ${product!.servingSize}"),
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
                        Text("$protein g", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red),),
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
                        Text("$fat g", style: TextStyle(fontWeight: FontWeight.bold,color: Colors.green)),
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
                        Text("$carbs g", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blueAccent)),
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

  Future<void> scanProduct(BuildContext context) async {
    try {
      // Scan barcode
      String barcode = await FlutterBarcodeScanner.scanBarcode(
        "#ff6666", // scanner line color
        "Cancel", // cancel button text
        true, // show flash icon
        ScanMode.BARCODE,
      );

      if (barcode == "-1") return; // Cancel pressed
      OpenFoodAPIConfiguration.userAgent = UserAgent(name: 'GYM APP');
      final configuration = ProductQueryConfiguration(
        barcode,
        fields: [ProductField.ALL],
        language: OpenFoodFactsLanguage.ENGLISH,
        version: ProductQueryVersion.v3,
      );

      final result = await OpenFoodAPIClient.getProductV3(configuration);

      if (result.product != null) {
        setState(() {
          product = result.product;
        });
      } else{
        setState(() {
          product = null;
        });
      }
    } catch (e) {
      print(e);
    }

    _openModal(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: Color(0xFFD3FF55), borderRadius: BorderRadius.circular(10)),
        child: IconButton(
            onPressed: () => scanProduct(context),
            icon: Icon(Icons.document_scanner_outlined)));
  }
}
