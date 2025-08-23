import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gymapp/dtos/dto_product_info.dart';
import 'package:gymapp/service/service_open_food_facts.dart';
import 'package:gymapp/service/service_usda_food.dart';
import 'package:gymapp/utils/utils_class.dart';

class SearchMeal extends StatefulWidget {
  bool brandSearch;
  String searchValue;
  SearchMeal({super.key, required this.searchValue ,this.brandSearch = false});

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
          Text(widget.brandSearch ? "Search a brand".toUpperCase() : "Search a meal".toUpperCase(), style: TextStyle(fontWeight: FontWeight.bold),),
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
              onTap: () => Utils.showProductModal(context, product),
              child: Container(
                width: double.maxFinite,
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xFFD3FF55), width: 1),
                ),
                child: Column(
                  children: [
                    Expanded(child: product.images == null ? Image.asset("assets/images/unknown_image.jpg"): Image.network(product.images!)),
                    Text(product.name, style: TextStyle(fontWeight: FontWeight.bold),),
                    Text(" ${product.calories} kcal 🔥"),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center
                      ,
                      children: [
                        Text("${product.protein}", style: TextStyle(color: Colors.red),),
                        Spacer(),
                        Text("${product.fat}", style: TextStyle(color: Colors.green)),
                        Spacer(),
                        Text(" ${product.calbs}", style: TextStyle(color: Colors.blueAccent))

                      ],
                    ),
                  ],
                ),
              ),
            );

      }),
    ):const Center(child: CircularProgressIndicator(color: Color(0xFFD3FF55),),);
  }
}
