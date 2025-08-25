import 'package:gymapp/dtos/dto_product_info.dart';
import 'package:openfoodfacts/openfoodfacts.dart';

class OpenFoodFactsService {
  static Future<List<ProductInfo>> searchProduct(String query) async {
    const user = User(userId: '', password: '');

    final parameters = [
      const PageSize(size: 10),
      SearchTerms(terms: [query]),
    ];

    final configuration = ProductSearchQueryConfiguration(
      parametersList: parameters,
      version: ProductQueryVersion.v3,
      fields: [
        ProductField.NAME,
        ProductField.IMAGE_FRONT_URL,
        ProductField.NUTRIMENTS,
        ProductField.NUTRIENT_LEVELS,
        ProductField.NUTRIMENT_DATA_PER,
        ProductField.NUTRIMENT_ENERGY_UNIT,
        ProductField.SERVING_QUANTITY,
        ProductField.SERVING_SIZE
      ],
      language: OpenFoodFactsLanguage.ENGLISH,
    );

    final searchResult = await OpenFoodAPIClient.searchProducts(
      user,
      configuration,
    );

    List<ProductInfo> productsFormatted = [];

    if (searchResult.products!.isNotEmpty) {
      for (var product in searchResult.products!) {
        var p = product.nutriments != null
            ? ProductInfo(
                product.productName ?? "Unknown",
                product.nutriments!
                        .getValue(Nutrient.energyKCal, PerSize.serving) ??
                    0,
                product.nutriments!.getValue(Nutrient.fat, PerSize.serving) ??
                    0,
                product.nutriments!
                        .getValue(Nutrient.carbohydrates, PerSize.serving) ??
                    0,
                product.nutriments!
                        .getValue(Nutrient.proteins, PerSize.serving) ??
                    0,
                product.servingSize ?? "Unknown")
            : ProductInfo(product.productName ?? "Unknown", 0, 0, 0, 0,
                product.servingSize ?? "Unknown");
        p.images = product.imageFrontUrl;
        productsFormatted.add(p);
      }
    }

    return productsFormatted;
  }
}
