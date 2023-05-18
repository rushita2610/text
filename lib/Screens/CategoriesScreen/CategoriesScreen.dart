import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../Api/api.dart';
import '../../ColorConstant/ColorConstant.dart';
import '../ProductsScreen/AllProductsScreen.dart';
import 'SubCategoriesScreen.dart';
import '../BottomNavigationBarScreen/BottomNavigationScreen.dart';
import 'package:http/http.dart' as http;

class CategoriesScreen extends StatefulWidget {

   CategoriesScreen({Key? key}) : super(key: key);

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  String O_Id='';


  bool isReload = false;

  List<dynamic> categories = [
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
          title: Transform(
            transform: Matrix4.translationValues(-10, 0, 0),
            child: const Text(
              "All Categories",
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
                physics: const NeverScrollableScrollPhysics(),
                child: Container(
                  //height: height,
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    children: [
                      Flexible(
                        flex: 0,
                        child: Container(
                          height: height,
                          child: GridView.builder(
                              itemCount: categories.length,
                              physics: const NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 4,
                                // crossAxisSpacing: 20,
                                mainAxisSpacing: 0,
                                mainAxisExtent: 90,
                                childAspectRatio: 0.6,
                              ),
                              itemBuilder: (cntx, index) {
                                return GestureDetector(
                                  onTap: () {
                                    print("popularloc.toString() ${categories}");
                                    String C_Id = categories[index]["cat_ID"].toString();
                                    print(C_Id);
                                    String N_Id = categories[index]["name"].toString();
                                    print("N_Id ==> ${categories[index]}");
                                    getCategory_APIcall(C_Id,N_Id);

                                    // Navigator.push(
                                    //   context,
                                    //   MaterialPageRoute(
                                    //     builder: (context) =>
                                    //          Subcategory(Categouryid: O_Id,),
                                    //   ),
                                    // );
                                  },
                                  child: Column(
                                    children: [
                                      Container(
                                        height: 35,
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.green,
                                        ),
                                        child:  Center(
                                          child: Image.network(
                                            categories[index]["category_image"].toString(),
                                          )
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
                                          categories[index]["name"].toString(),
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
        setState(() {

          O_Id = categories[0]["cat_ID"].toString();

        });
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
      var response = await http.get(Uri.parse(getCategory_Api+C_Id));
      if (response.statusCode == 200) {
        var decode = jsonDecode(response.body);

        print("decode get category ${decode}");

        if (decode["data"].length>0){

          List<dynamic> catList = decode["data"];
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    Subcategory(Categouryid: C_Id, CategouryName: N_Id, Sub_Category: catList,)                                          ),
          );
        }else{
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    AllProducts(ProductId: C_Id, ProductName: N_Id, isFrom: 'Category',searchText: "",)                                          ),
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
