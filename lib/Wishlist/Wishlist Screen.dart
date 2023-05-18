import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Api/api.dart';
import '../ColorConstant/ColorConstant.dart';
import '../Screens/BottomNavigationBarScreen/BottomNavigationScreen.dart';
import 'package:http/http.dart' as http;

import '../Screens/ProductsScreen/ProductDetailScreen.dart';

class Wishlist_Screen extends StatefulWidget {
  const Wishlist_Screen({Key? key}) : super(key: key);

  @override
  State<Wishlist_Screen> createState() => _Wishlist_ScreenState();
}

class _Wishlist_ScreenState extends State<Wishlist_Screen> {
  bool isReload = false;
  bool isReloadPaginate = false;

  ScrollController scrollController = ScrollController();
  int pageIndex = 0;
  int currentPage = 0, lastPage = 0;
  List<dynamic> WishList = [];

  @override
  void initState() {
    // dateinput.text = "";
    // dateinput2.text = ""; //set the initial value of text field
    super.initState();

    WishAPIcall(false);

    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
          scrollController.position.pixels) {
        if (currentPage != lastPage) {
          WishAPIcall(true);
        }
        print("pagination");
      }
    });
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
          "Wishlist",
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
          ? Container(
              // color: Colors.red,
              // height: WishList.length * 48,
              width: width,
              child: ListView.builder(
                  controller: scrollController,
                  //physics: NeverScrollableScrollPhysics(),
                  // scrollDirection: ,
                  itemCount: WishList.length,
                  itemBuilder: (BuildContext cntx, int index) {
                    return Container(
                      height: 110,
                      child: Column(
                        children: [
                          InkWell(
                            onTap: () {
                              String O_Id = WishList[index]['ID'].toString();
                              print(O_Id);

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>Productdetail(LocationId: O_Id,)
                                ),
                              );
                            },
                            child: Container(
                              padding: EdgeInsets.only(
                                left: 8,
                                right: 8,
                              ),
                              child: Card(
                                shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                        color: CupertinoColors.systemGrey2),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Container(
                                  width: width,
                                  padding: const EdgeInsets.only(right: 5),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        padding: EdgeInsets.all(8),
                                        height: 100,
                                        width: 100,
                                        child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: Image.network(
                                              WishList[index]['Featured_image']
                                                  .toString(),
                                              fit: BoxFit.fill,
                                            )),
                                      ),
                                      Container(
                                        width: width / 2,
                                        child: Text(
                                          "${WishList[index]['post_title'].toString()}",
                                          maxLines: 2,
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 17,
                                          ),
                                        ),
                                      ),
                                      Container(
                                          padding: EdgeInsets.only(right: 8),
                                          child: IconButton(
                                            onPressed: () {
                                              print(WishList[index]["ID"].toString());

                                              DeleteWishlistApiCall(WishList[index]["ID"].toString());
                                            },
                                            icon: const Icon(
                                              CupertinoIcons.delete,
                                              color: Colors.black,
                                              size: 20,
                                            ),
                                          )),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          // const Divider(
                          //   thickness: 1,
                          //   color: Colors.grey,
                          // )
                        ],
                      ),
                    );
                  }),
            )
          : const Center(
              child: CircularProgressIndicator(
                color: maincolor,
              ),
            ),
    ));
  }

  WishAPIcall(bool isPaginate) async {
    setState(() {
      if (!isPaginate) {
        isReload = true;
      } else {
        isReloadPaginate = true;
      }
    });
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString("token") ?? "";
      var user_id = prefs.getString("uid") ?? "";
      print(user_id);
      var location_id = prefs.getString("location_id") ?? "";
      print(location_id);
      final Header = {
        "Authorization": "Bearer ${token.toString()}",
      };

      currentPage = currentPage + 1;
      // print(Location_Api + "$user_id&location_id=${widget.ProductId}");
      //   var response = await http.post(Uri.parse(login), body: body);
      // var response = await http.get(
      //   headers: Header,
      //  // Uri.parse(Location_Api + "$user_id&location_id=${widget.ProductId}"),
      // );

      print(getWishlist_APi + "$user_id&per_page=10&page=${currentPage}");
      // https://reapp.com.gh/wp-json/wp/v2/search-posts?user_id=0&search=&cat_id=123&per_page=10&page=1
      var response = await http.get(
        headers: Header,
        Uri.parse(getWishlist_APi + "$user_id&per_page=10&page=${currentPage}"),
      );
      print("responce product list ${response.statusCode}");

      //user_id=0&location_id=17066&per_page=10&page=1
      if (response.statusCode == 200) {
        var decode = jsonDecode(response.body);
        print(decode);

        setState(() {
          // currentPage = decode["data"]["current_page"];
          // lastPage = decode["data"]["last_page"];

          if (currentPage == 1) {
            WishList.clear();
          }

          if (decode["data"].length > 0) {
            for (int i = 0; i < decode["data"].length; i++) {
              print("id ${decode["data"][i]["ID"]}");
              WishList.add(decode["data"][i]);
            }
          } else {
            lastPage = currentPage;
          }
        });

        // allproducts.clear();
        // print("responce post ${decode["posts"][0]}");
        // allproducts = decode["posts"];

        setState(() {
          if (!isPaginate) {
            isReload = false;
          } else {
            isReloadPaginate = false;
          }
        });
      } else {
        print("Error${response.statusCode}");
        print("Error${response.body}");

        setState(() {
          isReload = false;
        });
      }
    } catch (e) {
      setState(() {
        if (!isPaginate) {
          isReload = false;
        } else {
          isReloadPaginate = false;
        }
      });
      print("Exception in product list=>$e");
      throw e;
    }
  }

  DeleteWishlistApiCall( String postid) async {
    setState(() {
      isReload = true;
    });
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString("token") ?? "";
      var user_id = prefs.getString("uid") ?? "";
      print(user_id);


      final Header = {
        "Authorization": "Bearer ${token.toString()}",
      };

      final body = {"post_id": postid, "user_id": user_id};



      var response = await http.post(Uri.parse(DeleteWishlist_Api),
          body: body, headers: Header);

      if (response.statusCode == 200) {
        var decode = jsonDecode(response.body);
        print(decode);

        currentPage= 0;
        WishAPIcall(false);

        // if (decode["success"] == true) {
        //   MemberlistAPIcall();
        // } else {
        //   final snackBar = SnackBar(
        //     content: Text(decode["message"].toString()),
        //     action: SnackBarAction(
        //       label: '',
        //       onPressed: () {
        //         // Some code to undo the change.
        //       },
        //     ),
        //   );
        //
        //   // Find the ScaffoldMessenger in the widget tree
        //   // and use it to show a SnackBar.
        //   ScaffoldMessenger.of(context).showSnackBar(snackBar);
        //   setState(() {
        //     isReload = false;
        //   });
        // }
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
