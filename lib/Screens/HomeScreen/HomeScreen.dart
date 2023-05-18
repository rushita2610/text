// ignore_for_file: prefer_is_empty

import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../Api/api.dart';
import '../../ColorConstant/ColorConstant.dart';
import '../BottomNavigationBarScreen/BottomNavigationScreen.dart';
import '../CategoriesScreen/CategoriesScreen.dart';
import '../CategoriesScreen/SubCategoriesScreen.dart';
import '../ProductsScreen/AllProductsScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isReload = false;

  List<dynamic> categories = [
    // {
    //   'name': 'Uncategorized',
    // },
    // {
    //   'name': 'Sports and Recreation',
    // },
    // {
    //   'name': 'Mobile Devices and Accessories',
    // },
    // {
    //   'name': 'Arts and Crafts',
    // },
    // {
    //   'name': 'Beauty and Cosmetics',
    // },
    // {
    //   'name': 'Computers and Accessories',
    // },
    // {
    //   'name': 'Eyewear',
    // },
    // {
    //   'name': 'Fashion for Men',
    // },
    // {
    //   'name': 'Fashion for Women',
    // },
    // {
    //   'name': 'Food and Beverages',
    // },
    // {
    //   'name': 'Home and Living',
    // },
    // {
    //   'name': 'More',
    // },
  ];

  List<dynamic> popularloc = [
    // {
    //   'image': 'assets/images/trip-1.jpg',
    //   'name': "18th Lane, Osu, Accra-Ghana",
    // },
    // {
    //   'image': 'assets/images/trip-2.jpg',
    //   'name': "1st Avenue, Greda Estate, Teshie-Nu...",
    // },
    // {
    //   'image': 'assets/images/trip-3.jpg',
    //   'name': "3 Waterworks Link, Dodowa (GP.GPS =...",
    // },
    // {
    //   'image': 'assets/images/trip-4.jpg',
    //   'name': "18th Lane, Osu, Accra-Ghana",
    // },
  ];

  List<dynamic> bannerlist = [
    'assets/images/banner.png',
    'assets/images/banner1.png',
  ];
  int _currentIndex = 0;

  TextEditingController searchcontroller = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    HomeScreen_APIcall();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        backgroundColor: CupertinoColors.systemGrey5,
        // extendBody: true,
        body: (isReload == false)
            ? SingleChildScrollView(
                child: Container(
                  child: Column(
                    children: [
                      Container(
                        height: height * 0.28,
                        child: Stack(
                          children: [
                            Positioned(
                              child: Container(
                                child: (bannerlist.length > 0)
                                    ? Container(
                                        child: CarouselSlider(
                                          options: CarouselOptions(
                                            height: height * 0.2,
                                            viewportFraction: 1,
                                            padEnds: false,
                                            enlargeCenterPage: false,
                                            autoPlay: true,
                                            aspectRatio: 1.0,
                                            onPageChanged: (index, reason) {
                                              setState(
                                                () {
                                                  print("$index : index");
                                                  _currentIndex = index;
                                                },
                                              );
                                            },
                                          ),
                                          items: bannerlist
                                              .map(
                                                (item) => GestureDetector(
                                                  onTap: () {
                                                    // if (item["movie_event_id"] != null) {
                                                    //   Navigator.of(context)
                                                    //       .push(MaterialPageRoute(
                                                    //     builder: (context) {
                                                    //       return Eventdetails(
                                                    //         EventId:
                                                    //             item["movie_event_id"]
                                                    //                 .toString(),
                                                    //       );
                                                    //     },
                                                    //   ));
                                                    // }
                                                  },
                                                  child: Container(
                                                    child: Center(
                                                      child: ClipRRect(
                                                        child: Image.asset(
                                                          item,
                                                          fit: BoxFit.fitWidth,
                                                          width: width,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              )
                                              .toList(),
                                        ),
                                      )
                                    : const SizedBox(),
                              ),
                            ),
                            Positioned(
                              height: height * 0.28,
                              child: (bannerlist.length > 0)
                                  ? Container(
                                      // color: Colors.red,
                                      width: width,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: bannerlist.map((urlOfItem) {
                                          int index =
                                              bannerlist.indexOf(urlOfItem);
                                          return Container(
                                            width: 8.0,
                                            height: 8.0,
                                            margin: const EdgeInsets.symmetric(
                                                vertical: 10.0,
                                                horizontal: 4.0),
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: _currentIndex == index
                                                  ? maincolor
                                                  : Colors.black
                                                      .withOpacity(0.8),
                                            ),
                                          );
                                        }).toList(),
                                      ),
                                    )
                                  : const SizedBox(),
                            ),
                            Positioned(
                              top: height * 0.16,
                              left: 15,
                              right: 15,
                              height: height * 0.08,
                              child: Container(
                                //color: Colors.red,
                                height: height * 0.07,
                                width: width,
                                child: Card(
                                  elevation: 0,
                                  color: CupertinoColors.systemGrey5,
                                  shape: RoundedRectangleBorder(
                                      side:
                                          const BorderSide(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(8)),
                                  child: Container(
                                    padding:
                                        const EdgeInsets.fromLTRB(10, 8, 10, 8),
                                    child: TextFormField(
                                      textAlignVertical:
                                          TextAlignVertical.bottom,
                                      textAlign: TextAlign.left,
                                      readOnly: true,
                                      keyboardType: TextInputType.none,
                                      controller: searchcontroller,
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const BottomNavigationScreen(1),
                                          ),
                                        );
                                      },
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: Colors.white,
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          borderSide: BorderSide.none,
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          borderSide: BorderSide.none,
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          borderSide: BorderSide.none,
                                        ),
                                        prefixIcon: IconButton(
                                          onPressed: () {
                                            FocusScope.of(context).unfocus();
                                            searchcontroller.clear();
                                          },
                                          icon: const Icon(
                                            Icons.search,
                                            color: Colors.black45,
                                            size: 20,
                                          ),
                                        ),
                                        hintText: "Search",
                                        hintStyle: const TextStyle(
                                          color: Colors.grey,
                                          fontSize: 15.5,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Stack(
                        children: [
                          Positioned(
                            child: Container(
                              // color: Colors.red,
                              height: categories.length * 12,
                              padding:
                                  const EdgeInsets.only(left: 15, right: 15),
                              child: GridView.builder(
                                  itemCount: 11,
                                  physics: const NeverScrollableScrollPhysics(),
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 4,
                                    // crossAxisSpacing: 50,
                                    mainAxisSpacing: 0,
                                    childAspectRatio: 0.6,
                                    mainAxisExtent: 95,
                                  ),
                                  itemBuilder: (cntx, index) {
                                    return GestureDetector(
                                      onTap: () {
                                        print(
                                            "popularloc.toString() ${categories}");
                                        String C_Id = categories[index]
                                                ["cat_ID"]
                                            .toString();
                                        print(C_Id);
                                        String N_Id = categories[index]["name"]
                                            .toString();
                                        print("N_Id ==> ${categories[index]}");
                                        getCategory_APIcall(C_Id, N_Id);

                                        // if (categories[index]["name"].toString() == "uncategorized"){
                                        //   String O_Id = popularloc[index]["term_id"].toString();
                                        //   print(O_Id);
                                        //   String P_Id = popularloc[index]["name"].toString();
                                        //   print("P_Id ==> ${popularloc.toString()}");
                                        //   Navigator.push(
                                        //     context,
                                        //     MaterialPageRoute(
                                        //         builder: (context) =>
                                        //             AllProducts(ProductId: O_Id, ProductName: P_Id,)                                          ),
                                        //   );
                                        // }
                                        // else{
                                        //   Navigator.push(
                                        //     context,
                                        //     MaterialPageRoute(
                                        //         builder: (context) =>
                                        //             Subcategory(Categouryid: C_Id, CategouryName: N_Id,)                                          ),
                                        //   );
                                        // }
                                      },
                                      child: Column(
                                        children: [
                                          Container(
                                            height: 35,
                                            decoration: const BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.blueAccent),
                                            child: Center(
                                                child: Image.network(
                                              categories[index]
                                                      ["category_image"]
                                                  .toString(),
                                            )
                                                // Icon(
                                                //   Icons.fastfood_outlined,
                                                //   color: Colors.white,
                                                //   size: 20,
                                                // ),
                                                ),
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Container(
                                            //color: Colors.blueAccent,
                                            // height: 0.2,
                                            width: width * 0.3,
                                            child: Text(
                                              categories[index]["name"]
                                                  .toString(),
                                              textAlign: TextAlign.center,
                                              style: const TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 10,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  }),
                            ),
                          ),
                          Positioned(
                            bottom: 9,
                            right: 40,
                            //height: 50,
                            child: Column(
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                CategoriesScreen()));
                                  },
                                  child: Container(
                                    height: 35,
                                    width: 35,
                                    decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Color(0xFF5B696B)),
                                    child: const Center(
                                      child: Icon(
                                        Icons.more_horiz_rounded,
                                        size: 35,
                                        color: Colors.white,
                                      ),
                                      // Icon(
                                      //   Icons.fastfood_outlined,
                                      //   color: Colors.white,
                                      //   size: 20,
                                      // ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  child: const Text(
                                    "More",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 10,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      popularloc.length > 0
                          ? Flexible(
                              flex: 0,
                              child: Container(
                                // padding: const EdgeInsets.only(bottom: 10),
                                // height: Sizee.height,
                                color: Colors.transparent,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    (popularloc.isNotEmpty)
                                        ? Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                padding: const EdgeInsets.only(
                                                    left: 15, right: 15),
                                                //height: 25,
                                                alignment: Alignment.centerLeft,
                                                child: const Text(
                                                  "Popular Locations",
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 17,
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                padding: const EdgeInsets.only(
                                                  left: 15,
                                                  right: 15,
                                                  top: 3,
                                                ),
                                                // height: 30,
                                                alignment: Alignment.centerLeft,
                                                child: const Text(
                                                  "Looking for a product from a shop in a particular location?",
                                                  style: TextStyle(
                                                    color: Colors.grey,
                                                    //fontWeight: FontWeight.bold,
                                                    fontSize: 14,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )
                                        : const SizedBox(),
                                    (popularloc.length > 0)
                                        ? Container(
                                            padding: const EdgeInsets.only(
                                                top: 10, left: 13),
                                            height: height * 0.167,
                                            child: ListView.builder(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                physics:
                                                    const AlwaysScrollableScrollPhysics(),
                                                shrinkWrap: true,
                                                itemCount: popularloc.length,
                                                itemBuilder:
                                                    (BuildContext context,
                                                        int index) {
                                                  return Container(
                                                    // color: Colors.blue,
                                                    //width: width * 0.45,
                                                    // height: 100,
                                                    child: Card(
                                                      elevation: 0,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        // side: const BorderSide(
                                                        //     color: Colors.grey),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10.0),
                                                      ),
                                                      color: Colors.white,
                                                      child: GestureDetector(
                                                        onTap: () {
                                                          String O_Id =
                                                              popularloc[index][
                                                                      "term_id"]
                                                                  .toString();
                                                          print(O_Id);
                                                          String P_Id =
                                                              popularloc[index]
                                                                      ["name"]
                                                                  .toString();
                                                          print(
                                                              "P_Id ==> ${popularloc.toString()}");
                                                          Navigator.of(context)
                                                              .push(
                                                            MaterialPageRoute(
                                                              builder: (context) =>
                                                                  AllProducts(
                                                                      ProductId:
                                                                          O_Id,
                                                                      ProductName:
                                                                          P_Id,
                                                                      isFrom:
                                                                          'Location',
                                                                      searchText:
                                                                          ""),
                                                            ),
                                                          );
                                                        },
                                                        child: Stack(
                                                          children: [
                                                            Positioned(
                                                              child: ClipRRect(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10),
                                                                child: Image
                                                                    .network(
                                                                  popularloc[index]
                                                                          [
                                                                          'location_image']
                                                                      .toString(),
                                                                  fit: BoxFit
                                                                      .fitWidth,
                                                                ),
                                                              ),
                                                            ),
                                                            Positioned(
                                                              left: 8,
                                                              //top: height * 0.1,
                                                              bottom: 10,
                                                              child: Container(
                                                                width: width *
                                                                    0.25,
                                                                // color: Colors.red,
                                                                child: Text(
                                                                  popularloc[index]
                                                                          [
                                                                          "name"]
                                                                      .toString(),
                                                                  textAlign:
                                                                      TextAlign
                                                                          .left,
                                                                  maxLines: 2,
                                                                  style:
                                                                      const TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        11.5,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                }),
                                          )
                                        : const SizedBox(),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : const SizedBox(),
                    ],
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

        print("decode${decode}");
        // print(" Data ${categories = decode["categories"]}");
        categories.clear();
        categories = decode["categories"];
        popularloc.clear();
        popularloc = decode["location"];

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

  getCategory_APIcall(String C_Id, String N_Id) async {
    setState(() {
      isReload = true;
    });
    try {
      var response = await http.get(Uri.parse(getCategory_Api + C_Id));
      if (response.statusCode == 200) {
        var decode = jsonDecode(response.body);

        print("decode get category ${decode}");

        if (decode["data"].length > 0) {
          List<dynamic> catList = decode["data"];
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Subcategory(
                      Categouryid: C_Id,
                      CategouryName: N_Id,
                      Sub_Category: catList,
                    )),
          );
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => AllProducts(
                      ProductId: C_Id,
                      ProductName: N_Id,
                      isFrom: 'Category',
                      searchText: "",
                    )),
          );
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
