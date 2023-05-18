import 'dart:convert';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../Api/api.dart';
import '../../ColorConstant/ColorConstant.dart';
import 'package:http/http.dart' as http;

import 'Make New Ad Screen.dart';

class Categorylist_Screen extends StatefulWidget {
  const Categorylist_Screen({Key? key}) : super(key: key);

  @override
  State<Categorylist_Screen> createState() => _Categorylist_ScreenState();
}

class _Categorylist_ScreenState extends State<Categorylist_Screen> {
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
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_outlined,
            color: maincolor,
          ),
        ),
        title: const Text(
          "Category",
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w800,
          ),
        ),
        backgroundColor: Colors.white,
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
                      height: height * 0.058,
                      width: width,
                      padding: const EdgeInsets.only(right: 11),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: CupertinoColors.systemGrey5),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton2<String>(
                          selectedItemHighlightColor: maincolor,
                          //focusNode: primaryFocus,
                          value: dropdownvalue,
                          dropdownMaxHeight: height * 0.57,
                          offset: const Offset(0, 0),
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w400),
                          icon: const Icon(
                            Icons.keyboard_arrow_down,
                            color: Colors.black,
                          ),
                          onChanged: (String? value) {
                            // This is called when the user selects an item.
                            setState(() {
                              dropdownvalue = value!;

                              int indexCat = categoriesData.indexWhere(
                                  (element) => element["name"] == value);
                              selectedCategoryId =
                                  categoriesData[indexCat]["cat_ID"].toString();
                              if (selectedCategoryId != "0") {
                                getCategory_APIcall(selectedCategoryId);
                              } else {
                                selectedCategoryId = "";
                              }
                              print("dropdownvalue $dropdownvalue");
                              //dropdownValuedata = value;
                            });
                            //print(dropdownValuedata);
                          },
                          items: categories
                              .map<DropdownMenuItem<String>>((dynamic value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    subcategory.length > 0
                        ? Container(
                            height: height * 0.058,
                            width: width,
                            padding: const EdgeInsets.only(right: 11),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: CupertinoColors.systemGrey5),
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

                                    int indexCat = subcategoriesData.indexWhere(
                                        (element) => element["name"] == value);
                                    selectedSubcategoryId =
                                        subcategoriesData[indexCat]["cat_ID"]
                                            .toString();
                                    print(
                                        "selectedSubcategoryId $selectedSubcategoryId");
                                    if (selectedSubcategoryId == "0") {
                                      selectedSubcategoryId = "";
                                    }
                                  });
                                  //print(dropdownValuedata);
                                },
                                items: subcategory
                                    .map<DropdownMenuItem<String>>(
                                        (dynamic value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              ),
                            ),
                          )
                        : const SizedBox(),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: width / 1 - 100,
                      color: maincolor,
                      child: TextButton(
                          onPressed: () {
                            setState(() {
                              String ProductName = "Categories";
                              String Product_Id = "0";

                              if (selectedCategoryId != "") {
                                ProductName = dropdownvalue;
                                Product_Id = selectedCategoryId;
                              }

                              if (selectedSubcategoryId != "") {
                                ProductName = dropdownvalue2;
                                Product_Id = selectedSubcategoryId;
                              }

                              selectedADCategory = ProductName;
                            });
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Makenewad_Screen()),
                                ModalRoute.withName("/"));
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) => Makenewad_Screen(categories: dropdownvalue,subcategory: dropdownvalue2,)));
                          },
                          child: (selectedCategoryId == "")
                              ? const Text(
                                  "Close",
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.white),
                                )
                              : const Text(
                                  "Save",
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.white),
                                )),
                    ),
                  ],
                ),
              ),
            ))
          : const Center(
              child: CircularProgressIndicator(
                color: maincolor,
              ),
            ),
    ));
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
      var response = await http.get(Uri.parse(getCategory_Api + C_Id));
      if (response.statusCode == 200) {
        var decode = jsonDecode(response.body);

        print("decode get category ${decode}");

        subcategory.clear();
        subcategoriesData.clear();

        if (decode["data"].length > 0) {
          subcategory.add("All Items");
          subcategoriesData.add({"name": "All Items", "cat_ID": "0"});
          for (int i = 0; i < decode["data"].length; i++) {
            subcategory.add("${decode["data"][i]["name"].toString()}");
            subcategoriesData.add(decode["data"][i]);
          }
        } else {}
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
