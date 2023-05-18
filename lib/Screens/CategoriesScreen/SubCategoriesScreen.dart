import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Api/api.dart';
import '../../ColorConstant/ColorConstant.dart';
import '../BottomNavigationBarScreen/BottomNavigationScreen.dart';
import '../ProductsScreen/AllProductsScreen.dart';
import 'package:http/http.dart' as http;

import 'SubCategories Details Screen.dart';

class Subcategory extends StatefulWidget {
  String Categouryid;
  String CategouryName;
  List<dynamic> Sub_Category;

  Subcategory(
      {Key? key,
      required this.Categouryid,
      required this.CategouryName,
      required this.Sub_Category})
      : super(key: key);

  @override
  State<Subcategory> createState() => _SubcategoryState();
}

class _SubcategoryState extends State<Subcategory> {
  bool isReload = false;
  List<dynamic> subcategory = [
    // {
    //   'name': 'Soccer Jerseys',
    //   'QTY': 67,
    // },
    // {
    //   'name': 'Black Stars Jerseys',
    //   'QTY': 11,
    // },
    // {
    //   'name': 'Footballs',
    //   'QTY': 20,
    // },
    // {
    //   'name': 'Ladies Gym Wear',
    //   'QTY': 31,
    // },
    // {
    //   'name': 'Sports Bra',
    //   'QTY': 35,
    // },
    // {
    //   'name': 'Gym Equipment',
    //   'QTY': 167,
    // },
    // {
    //   'name': 'Dumbbells',
    //   'QTY': 13,
    // },
    // {
    //   'name': 'Board Games',
    //   'QTY': 9,
    // },
    // {
    //   'name': 'Female Jersey',
    //   'QTY': 2,
    // },
    // {
    //   'name': 'Swimming Pools',
    //   'QTY': 5,
    // },
    // {
    //   'name': 'Camping Tents',
    //   'QTY': 8,
    // },
    // {
    //   'name': 'Electric Scooters',
    //   'QTY': 12,
    // },
    // {
    //   'name': 'Tenniis Rackets',
    //   'QTY': 7,
    // },
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      subcategory = widget.Sub_Category;
    });
    // HomeScreen_APIcall();
    // OrderIDAPIcall();
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
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_outlined,
              color: maincolor,
            ),
          ),
          title: Transform(
            transform: Matrix4.translationValues(-10, 0, 0),
            child: Text(
              "${widget.CategouryName}",
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          backgroundColor: CupertinoColors.systemGrey5,
          elevation: 0,
          // centerTitle: true,
        ),
        body: (isReload == false)
            ? SingleChildScrollView(
                child: Container(
                  //color: Colors.red,
                  padding: const EdgeInsets.all(15),
                  // height: height,
                  child: Column(
                    children: [
                      Flexible(
                        flex: 0,
                        child: Container(
                          // color: Colors.red,
                          height: subcategory.length * 48,
                          width: width,
                          child: ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              // scrollDirection: ,
                              itemCount: subcategory.length,
                              itemBuilder: (BuildContext cntx, int index) {
                                return Container(
                                  height: height * 0.06,
                                  child: Column(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          String O_Id = subcategory[index]
                                                  ["term_id"]
                                              .toString();
                                          print(O_Id);
                                          String P_Id = subcategory[index]
                                                  ["name"]
                                              .toString();
                                          print(
                                              "P_Id ==> ${subcategory.toString()}");
                                          // Navigator.push(
                                          //   context,
                                          //   MaterialPageRoute(
                                          //     builder: (context) =>
                                          //         SubCAtegoriesdetails_Screen(ProductId: O_Id, ProductName: P_Id,),
                                          //   ),
                                          // );

                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => AllProducts(
                                                ProductId: O_Id,
                                                ProductName: P_Id,
                                                isFrom: 'Category',
                                                searchText: "",
                                              ),
                                            ),
                                          );
                                        },
                                        child: Container(
                                          width: width,
                                          padding:
                                              const EdgeInsets.only(right: 5),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                "${subcategory[index]['name'].toString()}  (${subcategory[index]['count']})",
                                                style: const TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 17,
                                                ),
                                              ),
                                              const Icon(
                                                Icons.arrow_forward_ios_rounded,
                                                color: maincolor,
                                                size: 20,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      const Divider(
                                        thickness: 1,
                                        color: Colors.grey,
                                      )
                                    ],
                                  ),
                                );
                              }),
                        ),
                      ),
                      Container(
                        height: 50,
                        width: width / 1 - 100,
                        //color: Colors.red,
                        child: RaisedButton(
                          elevation: 0,
                          color: maincolor,
                          onPressed: () {


                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>  AllProducts(isFrom: 'Category', ProductName: widget.CategouryName, searchText: '', ProductId: widget.Categouryid,),
                              ),
                            );
                          },
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          child: const Text(
                            'View all',
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
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

  OrderIDAPIcall() async {
    setState(() {
      isReload = true;
    });
    try {
      print("one");
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString("token") ?? "";

      final Header = {
        "Authorization": "Bearer ${token.toString()}",
      };
      print(CategoriesId_Api + "/${widget.Categouryid}");
      //   var response = await http.post(Uri.parse(login), body: body);
      var response = await http.get(
        headers: Header,
        Uri.parse(CategoriesId_Api + "/${widget.Categouryid}"),
      );

      if (response.statusCode == 200) {
        var decode = jsonDecode(response.body);

        subcategory.clear();
        subcategory = decode["categories"];

        if (decode["success"] == true) {
          setState(() {});
        } else {
          final snackBar = SnackBar(
            content: Text(decode["message"].toString()),
            action: SnackBarAction(
              label: '',
              onPressed: () {
                // Some code to undo the change.
              },
            ),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }

        setState(() {
          isReload = false;
        });
      } else {
        print("Error" + response.statusCode.toString());
        print("Error" + response.body.toString());

        setState(() {
          isReload = false;
        });
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
