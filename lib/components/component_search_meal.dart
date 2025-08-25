import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gymapp/dtos/dto_product_info.dart';
import 'package:gymapp/service/service_open_food_facts.dart';
import 'package:gymapp/service/service_usda_food.dart';
import 'package:gymapp/utils/utils_class.dart';

class SearchMeal extends StatefulWidget {
  bool brandSearch;
  String searchValue;
  String category;
  SearchMeal({super.key, required this.searchValue ,this.brandSearch = false, required this.category});

  @override
  State<SearchMeal> createState() => _SearchMealState();
}

class _SearchMealState extends State<SearchMeal> {
  
  List<ProductInfo>? searchResults;

  void makeResearch() async {
    List<ProductInfo> result =  widget.brandSearch ? await OpenFoodFactsService.searchProduct(widget.searchValue) : await USDAService.searchFood(widget.searchValue);

    setState(() {
      searchResults = result;
    });
  }

  @override
  void initState() {
    super.initState();
    makeResearch();
  }

  @override
  Widget build(BuildContext context) {
    return widget.searchValue.isEmpty ? SingleChildScrollView(
      child: Center(child: Column(
        children: [
          Image.asset("assets/images/fond_search_page.png"),
          Text(widget.brandSearch ? "Search a brand".toUpperCase() : "Search a meal".toUpperCase(), style: const TextStyle(fontWeight: FontWeight.bold),),
        ],
      )),
    ) : searchResults != null ?  GridView.count(
      shrinkWrap: true,
      crossAxisCount: 1,
      childAspectRatio: 1,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      children: List.generate(searchResults!.length, (index) {
        var product = searchResults![index];
        return
            GestureDetector(
              onTap: () => Utils.showProductModal(context, product, widget.category),
              child: Container(
                width: double.maxFinite,
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xFFD3FF55), width: 1),
                  borderRadius: BorderRadius.circular(15)
                ),
                child: Column(
                  children: [
                    Expanded(child: product.images == null ? Image.asset("assets/images/unknown_image.jpg"): Image.network(product.images!)),
                    Text(product.name, style: const TextStyle(fontWeight: FontWeight.bold),),
                    Text(" ${product.calories} kcal 🔥"),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center
                      ,
                      children: [
                        Text("${product.protein}", style: const TextStyle(color: Colors.red),),
                        const Spacer(),
                        Text("${product.fat}", style: const TextStyle(color: Colors.green)),
                        const Spacer(),
                        Text(" ${product.calbs}", style: const TextStyle(color: Colors.blueAccent))

                      ],
                    ),
                  ],
                ),
              ).animate().fadeIn(delay: (index * 100).ms),
            );

      }),
    ):const Center(child: CircularProgressIndicator(color: Color(0xFFD3FF55),),);
  }
}
