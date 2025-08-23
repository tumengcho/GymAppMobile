import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gymapp/components/component_barcode_scanner.dart';

class SearchMealPage extends StatefulWidget {
  const SearchMealPage({super.key});

  @override
  State<SearchMealPage> createState() => _SearchMealPageState();
}

class _SearchMealPageState extends State<SearchMealPage> {

  TextEditingController searchController = TextEditingController();
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          padding: EdgeInsets.symmetric(horizontal: 25, vertical: 30),
          color: const Color(0xFF323230),
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    width: double.maxFinite,
                    height: 50,
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(10)),
                    child: Text(
                      "ADD MEAL",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.w900, letterSpacing: 1, color: Color(0xFFD3FF55), fontSize: 17),
                    ),
                  ),
                  Positioned(
                      child: IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.arrow_circle_left, color: Color(0xFFD3FF55),size: 30,)))
                ],
              ),
              SizedBox(height: 30),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: searchController,
                      decoration: InputDecoration(
                        hintText: "Search...",
                        prefixIcon: Icon(Icons.search, color: Colors.grey),
                        filled: true,
                        fillColor: Colors.grey[200],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  BarCodeScanner()
                ],
              ),
              SizedBox(height: 30),

              DefaultTabController(
                length: 2,
                child: Expanded(
                  child: Column(
                    children: [
                      TabBar(
                        indicator: BoxDecoration(
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
                            Center(child: Column(
                              children: [
                                Image.asset("assets/images/fond_search_page.png"),
                                Text("Search a meal".toUpperCase(), style: TextStyle(fontWeight: FontWeight.bold),),
                              ],
                            )),
                            Center(child: Column(
                              children: [
                                Image.asset("assets/images/fond_search_page.png"),
                                Text("Search a brand".toUpperCase(), style: TextStyle(fontWeight: FontWeight.bold),),
                              ],
                            )),
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
