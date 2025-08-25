import 'dart:convert';
import 'package:gymapp/dtos/dto_product_info.dart';
import 'package:http/http.dart' as http;

class USDAService {
  static Future<List<ProductInfo>> searchFood(String query) async {
    const apiKey = 'elU98MypuGSJCtTaNLkfowOxQIUhqciybjDpfLnZ';

    final url = Uri.parse(
        'https://api.nal.usda.gov/fdc/v1/foods/search?query=$query&dataType=Foundation,SR Legacy&api_key=$apiKey');

    final response = await http.get(url);

    List<ProductInfo> productsFormatted = [];


    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final foods = data['foods'] as List<dynamic>;

      for (var food in foods) {

        final name = food['description'];
        final servingSize = food['servingSize'] ?? 0.0;
        final servingUnit = food['servingSizeUnit'] ?? 'Unknow';

        double? calories;
        double? protein;
        double? fat;
        double? carbs;

        final nutrients = food['foodNutrients'] as List<dynamic>? ?? [];
        for (var nutrient in nutrients) {
          switch (nutrient['nutrientName']) {
            case 'Energy':
              calories = nutrient['value']?.toDouble();
              break;
            case 'Protein':
              protein = nutrient['value']?.toDouble();
              break;
            case 'Total lipid (fat)':
              fat = nutrient['value']?.toDouble();
              break;
            case 'Carbohydrate, by difference':
              carbs = nutrient['value']?.toDouble();
              break;
          }


        }

        var p = ProductInfo(name, calories ?? 0, fat ?? 0 , carbs ?? 0, protein ?? 0, "$servingSize $servingUnit");
        productsFormatted.add(p);
      }
    }

    return productsFormatted;
  }
}
