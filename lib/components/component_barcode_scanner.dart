import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gymapp/dtos/dto_product_info.dart';
import 'package:gymapp/utils/utils_class.dart';
import 'package:openfoodfacts/openfoodfacts.dart';

class BarCodeScanner extends StatefulWidget {
  const BarCodeScanner({super.key});

  @override
  State<BarCodeScanner> createState() => _BarCodeScannerState();
}

class _BarCodeScannerState extends State<BarCodeScanner> {


  Future<void> scanProduct(BuildContext context) async {
    try {
      String barcode = await FlutterBarcodeScanner.scanBarcode(
        "#ff6666",
        "Cancel",
        true,
        ScanMode.BARCODE,
      );

      if (barcode == "-1") return;
      final configuration = ProductQueryConfiguration(
        barcode,
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
      Utils.showProductModal(context, p);
    } catch (e) {
      print(e);
    }


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
