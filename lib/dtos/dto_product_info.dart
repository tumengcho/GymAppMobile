class ProductInfo {
  String name;
  double calories;
  double fat;
  double calbs;
  double protein;
  String? images;
  String serving;

  ProductInfo(this.name, this.calories, this.fat, this.calbs, this.protein, this.serving);

  factory ProductInfo.fromMap(Map<String, dynamic> infos) {
    ProductInfo product = ProductInfo(
      infos["name"] ?? "",
      infos["calories"],
      infos["fat"],
      infos["calbs"],
      infos["protein"],
      infos["serving"] ?? "",
    );
    product.images = infos["images"];

    return product;
  }

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "calories": calories,
      "fat": fat,
      "calbs": calbs,
      "protein": protein,
      "images": images,
      "serving": serving,
    };
  }
}