import 'package:flutter/material.dart';
import 'package:gymapp/components/component_barcode_scanner.dart';
import 'package:gymapp/components/component_search_meal.dart';

class SearchMealPage extends StatefulWidget {
  String category;
  SearchMealPage({super.key, required this.category});

  @override
  State<SearchMealPage> createState() => _SearchMealPageState();
}

class _SearchMealPageState extends State<SearchMealPage> {
  TextEditingController searchController = TextEditingController();
  String searchValue = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
          color: const Color(0xFF323230),
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    width: double.maxFinite,
                    height: 50,
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(10)),
                    child:  Text(
                      "ADD ${widget.category.toUpperCase()}",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.w900,
                          letterSpacing: 1,
                          color: Color(0xFFD3FF55),
                          fontSize: 17),
                    ),
                  ),
                  Positioned(
                      child: IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: const Icon(
                            Icons.arrow_circle_left,
                            color: Color(0xFFD3FF55),
                            size: 30,
                          )))
                ],
              ),
              const SizedBox(height: 30),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: searchController,
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                      decoration: InputDecoration(
                        hintText: "Search...",
                        prefixIcon: const Icon(Icons.search, color: Colors.grey),
                        filled: true,
                        fillColor: Colors.grey[200],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      onSubmitted: (value) => {
                        setState(() {
                          searchValue = value;
                        })
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  BarCodeScanner(category: widget.category,)
                ],
              ),
              const SizedBox(height: 30),
              DefaultTabController(
                length: 2,
                child: Expanded(
                  child: Column(
                    children: [
                      TabBar(
                        indicator: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Color(0xFFD3FF55),
                              width: 2,
                            ),
                          ),
                        ),
                        tabs: [
                          Tab(text: "Meals".toUpperCase()),
                          Tab(text: "Brands".toUpperCase()),
                        ],
                      ),
                      Expanded(
                        child: TabBarView(
                          children: [
                            SearchMeal(
                                key: ValueKey("generic-$searchValue"),
                                searchValue: searchValue,
                                category: widget.category),
                            SearchMeal(
                                key: ValueKey("brand-$searchValue"),
                                searchValue: searchValue,
                                category: widget.category,
                                brandSearch: true)
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          )),
    );
  }
}
