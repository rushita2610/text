import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Api/api.dart';
import '../ColorConstant/ColorConstant.dart';
import '../Screens/Drawer/DrawerScreen.dart';
import 'package:http/http.dart' as http;

class Myads_Screen extends StatefulWidget {
  const Myads_Screen({Key? key}) : super(key: key);

  @override
  State<Myads_Screen> createState() => _Myads_ScreenState();
}

class _Myads_ScreenState extends State<Myads_Screen> {
  bool isReload = false;
  ScrollController scrollController = ScrollController();
  int pageIndex = 0;
  int currentPage = 0, lastPage = 0;
  bool isReloadPaginate = false;

  List<dynamic> MyadsList = [
    // {
    //   "image": "assets/images/banner.png",
    //   "name": "Test",
    //   "view": "0 view",
    //   "private": "private",
    //   "date": "date",
    //   "pricename": "GHC 200",
    //   "pricename2": "GHC 100",
    // }
  ];

  @override
  void initState() {
    super.initState();
    // StoredetailsAPIcall();
    MyAds_APIcall(false);

    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
          scrollController.position.pixels) {
        if (currentPage != lastPage) {
          MyAds_APIcall(true);
        }
        print("pagination");
      }
    });
  }

  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SafeArea(
        child: Scaffold(
      key: _drawerKey,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            _drawerKey.currentState?.openDrawer();
          },
          icon: Container(
            height: 50,
            width: 50,
            decoration:
                const BoxDecoration(shape: BoxShape.circle, color: maincolor),
            child: const Icon(
              Icons.menu,
              color: Colors.white,
            ),
          ),
        ),
        title: const Text(
          "My Ads",
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
      drawer: DrawerScreen(),
      body: (isReload == false)
          ? Container(
              // color: Colors.red,
              //height: MyadsList.length * 48,
              width: width,
              child: ListView.builder(
                  controller: scrollController,
                  // physics: NeverScrollableScrollPhysics(),
                  // scrollDirection: ,
                  itemCount: MyadsList.length,
                  itemBuilder: (BuildContext cntx, int index) {
                    return Container(
                      // height: 110,
                      child: Column(
                        children: [
                          InkWell(
                            onTap: () {},
                            child: Container(
                              padding: const EdgeInsets.only(
                                left: 8,
                                right: 8,
                              ),
                              child: Card(
                                shape: const RoundedRectangleBorder(
                                  side: BorderSide(
                                      color: CupertinoColors.systemGrey2),
                                  // borderRadius: BorderRadius.circular(10)
                                ),
                                child: Container(
                                  width: width,
                                  // padding: const EdgeInsets.only(right: 5),
                                  child: Column(
                                    children: [
                                      Row(
                                        // mainAxisAlignment:
                                        // MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          // MyadsList[index]["feature_image_url"][index]["img_url"].toString()==null?Container(
                                          //   height: 100,
                                          //   width: 100,
                                          // ):

                                          Stack(
                                            children: [
                                              Container(
                                                padding:
                                                    const EdgeInsets.all(8),
                                                height: 100,
                                                width: 100,
                                                child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    child: MyadsList[index][
                                                                    'feature_image_url']
                                                                .length >
                                                            0
                                                        ? Image.network(
                                                            MyadsList[index][
                                                                        'feature_image_url']
                                                                    [
                                                                    0]["img_url"]
                                                                .toString(),
                                                            fit: BoxFit.fill,
                                                          )
                                                        : SizedBox()),
                                              ),
                                              MyadsList[index]['price_discount']
                                                          .toString() ==
                                                      ""
                                                  ? SizedBox()
                                                  : Positioned(
                                                      top: 12,
                                                      left: 14,
                                                      child: Container(
                                                        color: Colors.red,
                                                        height: 18,
                                                        width: 45,
                                                        child: Text(
                                                          "SALE",
                                                          style: TextStyle(
                                                              fontSize: 13,
                                                              color:
                                                                  Colors.white),
                                                          textAlign:
                                                              TextAlign.center,
                                                        ),
                                                      ))
                                            ],
                                          ),

                                          Container(
                                            // height: 50,
                                            // height: height/2,
                                            //width: width/3,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  child: Text(
                                                    MyadsList[index]
                                                            ['post_title']
                                                        .toString(),
                                                    // maxLines: 2,
                                                    style: const TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 15,
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                Row(
                                                  // crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      child: const Icon(
                                                        Icons
                                                            .check_box_outlined,
                                                        color: Colors.red,
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      width: 5,
                                                    ),
                                                    Container(
                                                      child: Text(
                                                        MyadsList[index]
                                                                ['post_status']
                                                            .toString(),
                                                      ),
                                                    )
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 35,
                                          ),
                                          Container(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    Container(
                                                        // padding: EdgeInsets.only(right: 8),
                                                        child: IconButton(
                                                      onPressed: () {},
                                                      icon: const Icon(
                                                        CupertinoIcons.eye,
                                                        color: Colors.black,
                                                        size: 18,
                                                      ),
                                                    )),
                                                    MyadsList[index][
                                                                    'total_views']
                                                                .toString() ==
                                                            null
                                                        ? Container(
                                                            child: Text(
                                                              MyadsList[index][
                                                                      'total_views']
                                                                  .toString(),
                                                            ),
                                                          )
                                                        : Container(
                                                            child: Text(
                                                                "0 Viewer(s)"),
                                                          )
                                                  ],
                                                ),
                                                //SizedBox(height: 5,),
                                                Row(
                                                  children: [
                                                    Container(
                                                        // padding: EdgeInsets.only(right: 8),
                                                        child: IconButton(
                                                      onPressed: () {},
                                                      icon: const Icon(
                                                        CupertinoIcons.calendar,
                                                        color: Colors.black,
                                                        size: 18,
                                                      ),
                                                    )),
                                                    Container(
                                                      child: Text(
                                                        MyadsList[index]
                                                                ['post_date']
                                                            .toString(),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      MyadsList[index]['price_discount']
                                                  .toString() ==
                                              ""
                                          ? Container(
                                              width: width,
                                              alignment: Alignment.center,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    padding:
                                                        const EdgeInsets.all(5),
                                                    color: maincolor,
                                                    child: Text(
                                                      MyadsList[index]['price']
                                                          .toString(),
                                                      style: TextStyle(),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                          : Container(
                                              width: width,
                                              alignment: Alignment.center,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    padding:
                                                        const EdgeInsets.all(5),
                                                    color: maincolor,
                                                    child: Text(
                                                      MyadsList[index]['price']
                                                          .toString(),
                                                      style: TextStyle(
                                                          decoration:
                                                              TextDecoration
                                                                  .lineThrough),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 5,
                                                  ),
                                                  Container(
                                                    //  width: 70,
                                                    padding:
                                                        const EdgeInsets.all(5),
                                                    color: maincolor,
                                                    child: Text(
                                                      MyadsList[index]
                                                              ['price_discount']
                                                          .toString(),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          print(MyadsList[index]["id"]);
                                          DeleteMyAdsApiCall(
                                              MyadsList[index]["id"]);
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.all(5),
                                          width: 80,
                                          color: Colors.red,
                                          alignment: Alignment.center,
                                          child: Row(
                                            children: [
                                              const Icon(
                                                CupertinoIcons.delete_solid,
                                                color: Colors.white,
                                                size: 20,
                                              ),
                                              Container(
                                                child: const Text(
                                                  "Delete",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 13),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
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

  MyAds_APIcall(bool isPaginate) async {
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
      // currentPage = currentPage+1;
      currentPage++;
      print(Fetchpost_Api + "${user_id}&per_page=10&page=${currentPage}");
      //   var response = await http.post(Uri.parse(login), body: body);
      var response = await http.get(
        headers: Header,
        Uri.parse(Fetchpost_Api + "${user_id}&per_page=10&page=${currentPage}"),
      );
      print("responce product ${response.statusCode}");

      if (response.statusCode == 200) {
        print("responce product ${response.statusCode}");
        var decode = jsonDecode(response.body);
        print(decode);

        MyadsList.clear();
        // print("responce post ${decode["data"][0]}");
        MyadsList = decode["data"];

        setState(() {
          currentPage = decode["data"]["current_page"];
          lastPage = decode["data"]["last_page"];

          if (currentPage == 1) {
            MyadsList.clear();
          }

          for (int i = 0; i < decode["data"]["data"].length; i++) {
            MyadsList.add(decode["data"]["data"][i]);
          }
        });

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
          if (!isPaginate) {
            isReload = false;
          } else {
            isReloadPaginate = false;
          }
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

  DeleteMyAdsApiCall(String postid) async {
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

      final body = {"id": postid};

      var response = await http.post(Uri.parse(DeleteMyAds_Api),
          body: body, headers: Header);

      if (response.statusCode == 200) {
        var decode = jsonDecode(response.body);
        print(decode);

        currentPage = 0;
        MyAds_APIcall(false);

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
