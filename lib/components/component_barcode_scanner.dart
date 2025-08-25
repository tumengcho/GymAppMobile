import 'package:flutter/material.dart';
import 'package:gymapp/dtos/dto_product_info.dart';
import 'package:gymapp/utils/utils_class.dart';
import 'package:openfoodfacts/openfoodfacts.dart';

import 'component_scan_page.dart';

class BarCodeScanner extends StatefulWidget {
  String category;
  BarCodeScanner({super.key, required this.category});

  @override
  State<BarCodeScanner> createState() => _BarCodeScannerState();
}

class _BarCodeScannerState extends State<BarCodeScanner> {

  Future<void> scanProduct(BuildContext context) async {
    String? barcode;



    try {

      final barcode = await showDialog<String>(
        context: context,
        barrierDismissible: false,
        builder: (context) => ScannerPage(
          onScan: (code) {
            Navigator.pop(context, code);
          },
        ),
      );

      if (barcode == null) return;
      final configuration = ProductQueryConfiguration(
        barcode!,
        fields: [ProductField.ALL],
        language: OpenFoodFactsLanguage.ENGLISH,
        version: ProductQueryVersion.v3,
      );

      final result = await OpenFoodAPIClient.getProductV3(configuration);
      ProductInfo? p;
      if (result.product != null) {
        p = result.product!.nutriments != null
            ? ProductInfo(
            result.product!.productName ?? "Unknown",
            result.product!.nutriments!
                .getValue(Nutrient.energyKCal, PerSize.serving) ??
                0,
            result.product!.nutriments!.getValue(Nutrient.fat, PerSize.serving) ??
                0,
            result.product!.nutriments!
                .getValue(Nutrient.carbohydrates, PerSize.serving) ??
                0,
            result.product!.nutriments!
                .getValue(Nutrient.proteins, PerSize.serving) ??
                0,
            result.product!.servingSize ?? "Unknown")
            : ProductInfo(result.product!.productName ?? "Unknown", 0, 0, 0, 0,
            result.product!.servingSize ?? "Unknown");
        p.images = result.product!.imageFrontUrl;

      }
      Utils.showProductModal(context, p, widget.category);
    } catch (e) {
      print(e);
    }


  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: const Color(0xFFD3FF55), borderRadius: BorderRadius.circular(10)),
        child: IconButton(
            onPressed: () => scanProduct(context),
            icon: const Icon(Icons.document_scanner_outlined)));
  }
}
