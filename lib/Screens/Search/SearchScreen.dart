// ignore_for_file: deprecated_member_use

import 'dart:convert';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reapp_ghana_project/Screens/ProductsScreen/AllProductsScreen.dart';

import '../../Api/api.dart';
import '../../ColorConstant/ColorConstant.dart';
import '../BottomNavigationBarScreen/BottomNavigationScreen.dart';
import 'SearchResultScreen.dart';
import 'package:http/http.dart' as http;



class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  bool isReload = false;
  TextEditingController searchController = TextEditingController();

  String dropdownvalue = 'All Categories';
  List<dynamic> categoriesData = [];
  List<String> categories = <String>[
    // 'All Categories',
    // 'Uncategorized',
    // 'Sports and Recreation',
    // 'Mobile Devices and Accessories',
    // 'Arts and Crafts',
    // 'Beauty and Cosmetics',
    // 'Computers and Accessories',
    // 'Eyewear',
    // 'Fashion for Men',
    // 'Fashion for Women',
    // 'Food and Beverages',
    // 'Home and Living',
    // 'Electronics',
    // 'Kids',
    // 'Health and Wellness',
    // 'Services',
    // 'Books and Stationery',
    // 'Cars and Auto Parts',
    // 'Perfumes',
    // 'Real Estate And Construction',
    // 'Watches',
  ];

  String selectedCategoryId = "";
  String selectedSubcategoryId = "";

  String dropdownvalue2 = 'All Items';
  List<dynamic> subcategoriesData = [];
  List<dynamic> subcategory = <String>[
    // 'All Items',
    // 'Fashion for Men',
    // 'Fashion for Women',
    // 'Food and Beverages',
    // 'Home and Living',
    // 'Electronics',
    // 'Kids',
  ];

  @override
  void initState() {
    searchController.text = '';
    super.initState();
    HomeScreen_APIcall();
    subcategory.add("All Items");
    subcategoriesData.add({"name": "All Items", "cat_ID": "0"});
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        backgroundColor: CupertinoColors.systemGrey5,
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const BottomNavigationScreen(0),
                ),
              );
            },
            icon: const Icon(
              Icons.arrow_back_outlined,
              color: maincolor,
            ),
          ),
          title: const Text(
            "Search",
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.w800,
            ),
          ),
          backgroundColor: CupertinoColors.systemGrey5,
          elevation: 0,
          centerTitle: true,
        ),
        body: (isReload == false)
            ? Form(
                child: SingleChildScrollView(
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      children: [
                        Container(
                          alignment: Alignment.topLeft,
                          height: 26,
                          child: const Text(
                            "Search",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w300,
                              fontSize: 16.5,
                            ),
                          ),
                        ),
                        Container(
                          height: height * 0.058,
                          width: width,
                          child: TextFormField(
                            textAlignVertical: TextAlignVertical.bottom,
                            controller: searchController,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: BorderSide.none,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: BorderSide.none,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: BorderSide.none,
                              ),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  searchController.clear();
                                },
                                icon: const Icon(
                                  Icons.close,
                                  color: Colors.black45,
                                  size: 20,
                                ),
                              ),
                              hintText: "Search by Keywords",
                              hintStyle: const TextStyle(
                                color: Colors.grey,
                                fontSize: 15.5,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 13,
                        ),
                        Container(
                          alignment: Alignment.topLeft,
                          height: 26,
                          child: const Text(
                            "Main Categories",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w300,
                              fontSize: 16.5,
                            ),
                          ),
                        ),
                        Container(
                          height: height * 0.058,
                          width: width,
                          padding: const EdgeInsets.only(right: 11),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.white),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton2<String>(
                              selectedItemHighlightColor: maincolor,
                              value: dropdownvalue,
                              dropdownMaxHeight: height * 0.57,
                              offset: const Offset(0, 0),
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w400
                              ),
                              icon: const Icon(
                                Icons.keyboard_arrow_down,
                                color: Colors.black,
                              ),
                              onChanged: (String? value) {
                                // This is called when the user selects an item.
                                setState(() {
                                  dropdownvalue = value!;

                                  int indexCat = categoriesData.indexWhere((element) => element["name"] == value);
                                  selectedCategoryId = categoriesData[indexCat]["cat_ID"].toString();
                                  if ( selectedCategoryId != "0"){
                                    getCategory_APIcall(selectedCategoryId);
                                  }else{
                                    selectedCategoryId = "";
                                  }
                                  print("dropdownvalue $dropdownvalue");
                                  //dropdownValuedata = value;
                                });
                                //print(dropdownValuedata);
                              },
                              items: categories.map<DropdownMenuItem<String>>(
                                  (dynamic value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 13,
                        ),




                        subcategory.length > 0 ? Container(
                          alignment: Alignment.topLeft,
                          height: 26,
                          child: const Text(
                            "Sub Categories",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w300,
                              fontSize: 16.5,
                            ),
                          ),
                        ):SizedBox(),
                        subcategory.length > 0
                            ? Container(
                          height: height * 0.058,
                          width: width,
                          padding: const EdgeInsets.only(right: 11),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.white),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton2<String>(
                              value: dropdownvalue2,
                              selectedItemHighlightColor: maincolor,

                              dropdownMaxHeight: height * 0.57,
                              offset: const Offset(0, 0),
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                              ),
                              icon: const Icon(
                                Icons.keyboard_arrow_down,
                                color: Colors.black,
                              ),
                              onChanged: (String? value) {
                                // This is called when the user selects an item.
                                setState(() {
                                  dropdownvalue2 = value!;
                                  //dropdownValuedata = value;


                                  int indexCat = subcategoriesData.indexWhere((element) => element["name"] == value);
                                  selectedSubcategoryId = subcategoriesData[indexCat]["cat_ID"].toString();
                                  print("selectedSubcategoryId $selectedSubcategoryId");
                                  if (selectedSubcategoryId == "0"){
                                    selectedSubcategoryId = "";
                                  }

                                });
                                //print(dropdownValuedata);
                              },
                              items: subcategory.map<DropdownMenuItem<String>>(
                                  (dynamic value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ),
                        )
                            : SizedBox(),




                        const SizedBox(
                          height: 30,
                        ),
                        Container(
                          height: height * 0.065,
                          width: width * 0.7,
                          child: RaisedButton(
                            elevation: 0,
                            color: maincolor,
                            onPressed: () {
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (context) => const SearchResult(),
                              //   ),
                              // );

                              String ProductName = "Product List";
                              String Product_Id = "0";

                              if (selectedCategoryId != ""){
                                ProductName = dropdownvalue;
                                Product_Id = selectedCategoryId;
                              }

                              if (selectedSubcategoryId != ""){
                                ProductName = dropdownvalue2;
                                Product_Id = selectedSubcategoryId;
                              }



                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        AllProducts(ProductId: Product_Id, ProductName: ProductName, isFrom: 'Category',searchText: searchController.text,)                                          ),
                              );
                            },
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5)),
                            child: Container(
                              //color: Colors.red,
                              width: width * 0.22,
                              alignment: Alignment.center,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: const [
                                  Icon(
                                    Icons.search_rounded,
                                    color: Colors.white,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "Reapp",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            : const Center(
                child: CircularProgressIndicator(
                  color: maincolor,
                ),
              ),
      ),
    );
  }
  HomeScreen_APIcall() async {
    setState(() {
      isReload = true;
    });
    try {
      //   var response = await http.post(Uri.parse(login), body: body);
      var response = await http.get(Uri.parse(Homescreen_Api));
      if (response.statusCode == 200) {
        var decode = jsonDecode(response.body);

        print("decode${decode["categories"].length}");
        // // print(" Data ${categories = decode["categories"]}");
        // categories.clear();
        // categories = decode["categories"];

        categories.clear();
        categoriesData.clear();
        categories.add("All Categories");
        categoriesData.add({"name": "All Categories", "cat_ID": "0"});
        for (int i = 0; i < decode["categories"].length; i++) {
          categories.add("${decode["categories"][i]["name"].toString()}");
          categoriesData.add(decode["categories"][i]);
        }
        // categories = decode["categories"][0]["name"];
        // dropdownvalue = categories.first.toString();
        // if (decode["success"] == true) {
        //   setState(() {
        //     print("decode data${decode}");
        //     categories.clear();
        //     categories = decode["categories"];
        //     // print("decode data${decode}");
        //   });
        // } else {}

        setState(() {
          isReload = false;
        });
      } else {
        print("Error" + response.statusCode.toString());
        print("Error" + response.body.toString());
      }
    } catch (e) {
      setState(() {
        isReload = false;
      });
      print("Exception in Today Attendance=>" + e.toString());
      throw e;
    }
  }

  getCategory_APIcall(String C_Id) async {
    setState(() {
      isReload = true;
    });
    try {
      var response = await http.get(Uri.parse(getCategory_Api+C_Id));
      if (response.statusCode == 200) {
        var decode = jsonDecode(response.body);

        print("decode get category ${decode}");

        subcategory.clear();
        subcategoriesData.clear();

        if (decode["data"].length>0){
          subcategory.add("All Items");
          subcategoriesData.add({"name": "All Items", "cat_ID": "0"});
          for (int i = 0; i < decode["data"].length; i++) {
            subcategory.add("${decode["data"][i]["name"].toString()}");
            subcategoriesData.add(decode["data"][i]);
          }
        }else{

        }
        // print(" Data ${categories = decode["categories"]}");


        setState(() {
          isReload = false;
        });
      } else {
        print("Error" + response.statusCode.toString());
        print("Error" + response.body.toString());
      }
    } catch (e) {
      setState(() {
        isReload = false;
      });
      print("Exception in Today Attendance=>" + e.toString());
      throw e;
    }
  }

}
