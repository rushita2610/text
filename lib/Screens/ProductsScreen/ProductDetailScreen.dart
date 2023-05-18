// ignore_for_file: deprecated_member_use

import 'dart:convert';
import 'dart:developer';
import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:url_launcher/url_launcher.dart';
import '../../Api/api.dart';
import '../../ColorConstant/ColorConstant.dart';
import '../Login/LoginScreen.dart';
import '../Login/Sellerregistration.dart';
import 'AllProductsScreen.dart';
import 'Review Product Screen.dart';
import 'StoreNameScreen.dart';
import 'package:http/http.dart' as http;

import 'Tag product detail.dart';

class Productdetail extends StatefulWidget {
  String LocationId;

  Productdetail({
    Key? key,
    required this.LocationId,
  }) : super(key: key);
  String strtitle = "";

  @override
  State<Productdetail> createState() => _ProductdetailState();
}

class _ProductdetailState extends State<Productdetail> {
  bool isReload = false;
  List<dynamic> productbannerimg = [
    // 'assets/images/fdb2.jpeg',
    // 'assets/images/fbj4.jpeg',
    // 'assets/images/fdb1.jpeg',
  ];
  int _currentIndex = 0;
  String isFav = "false";


  List<dynamic> tags = [
    // 'manchchester united ladies away jersey',
    // 'manchester united womens jersey',
  ];

  List<dynamic> moreitem = [
    // {
    //   'image': 'assets/images/fdb2.jpeg',
    //   'name': 'Manchester United Home Jersey 2022/23',
    // },
    // {
    //   'image': 'assets/images/fbj4.jpeg',
    //   'name': 'Manchester United Home Jersey 2022/23',
    // },
    // {
    //   'image': 'assets/images/fdb1.jpeg',
    //   'name': 'Manchester United Home Jersey 2022/23',
    // },
  ];
  Map ItemList = {};

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    LocationAPIcall();
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
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) =>  AllProducts(),
              //   ),
              // );
            },
            icon: const Icon(
              Icons.arrow_back_outlined,
              color: maincolor,
            ),
          ),
          title: Transform(
            transform: Matrix4.translationValues(-10, 0, 0),
            child: Text(
              ItemList["post_title"].toString(),
              //"${widget.LocationId}",
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
                  padding: const EdgeInsets.all(15),
                  // /height: height,
                  child: Column(
                    children: [
                      Container(
                        // color: Colors.red,
                        height: height * 0.28,
                        child: Stack(
                          children: [
                            Positioned(
                              child: Container(
                                child: (productbannerimg.length > 0)
                                    ? Container(
                                        child: CarouselSlider(
                                          options: CarouselOptions(
                                            height: height * 0.25,
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
                                          items: productbannerimg
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
                                                        child: Image.network(
                                                          item["url"]
                                                              .toString(),
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
                              height: height * 0.4,
                              child: (productbannerimg.length > 0)
                                  ? Container(
                                      // color: Colors.red,
                                      width: width,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children:
                                            productbannerimg.map((urlOfItem) {
                                          int index = productbannerimg
                                              .indexOf(urlOfItem);
                                          return Container(
                                            width: 10.0,
                                            height: 10.0,
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
                              top: height * 0.24,
                              right: 15,
                              height: height * 0.03,
                              child: Container(
                                alignment: Alignment.center,
                                height: 25,
                                width: width * 0.2,
                                color: drawericon,
                                child: Text(
                                  ItemList["normal_price"].toString(),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              right: 5,
                              top: 5,
                              child: InkWell(
                                onTap: () {
                                  print( ItemList["ID"].toString());

                                  setState(() {
                                    isFav = "true";
                                  });
                                  SaveWishlistApiCall(ItemList["ID"].toString());

                                },
                                child: Container(
                                  padding: const EdgeInsets.all(3),
                                  alignment: Alignment.center,
                                  height: 30,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: CupertinoColors.systemGrey5,
                                      width: 2,
                                    ),
                                    color: Colors.white,
                                  ),
                                  child: Center(
                                    child: (isFav == "false") ? Icon(
                                      Icons.favorite_border,
                                      color: Colors.red,
                                      size: 20,
                                    ):  Icon(
                                      Icons.favorite,
                                      color: Colors.red,
                                      size: 20,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Divider(
                        thickness: 1.3,
                        color: Colors.white,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 30,
                        child: const Text(
                          "Remember you saw it on Reapp Ghana",
                          style: TextStyle(
                            color: maincolor,
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Container(
                        height: height * 0.3,
                        alignment: Alignment.centerLeft,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InkWell(
                              onTap: () {
                                String O_Id =
                                    ItemList['post_author'].toString();
                                print(O_Id);

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => storeName(
                                      StoredetailsId: O_Id,
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                width: width,
                                child: Row(
                                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(5),
                                      alignment: Alignment.center,
                                      height: 25,
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        // border: Border.all(
                                        //   color: CupertinoColors.systemGrey5,
                                        //   width: 2,
                                        // ),
                                        color: Colors.black,
                                      ),
                                      child: const Center(
                                        child: Icon(
                                          Icons.shopping_cart_rounded,
                                          color: Colors.white,
                                          size: 17,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                      child: RichText(
                                        text: TextSpan(
                                          text: "Store Name :",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 15,
                                          ),
                                          children: <TextSpan>[
                                            TextSpan(
                                              text:
                                                  ItemList["sname"].toString(),
                                              style: TextStyle(
                                                color: maincolor,
                                                fontSize: 15,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                _launchCaller();
                              },
                              child: Container(
                                width: width,
                                child: Row(
                                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(5),
                                      alignment: Alignment.center,
                                      height: 25,
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        // border: Border.all(
                                        //   color: CupertinoColors.systemGrey5,
                                        //   width: 2,
                                        // ),
                                        color: Colors.black,
                                      ),
                                      child: const Center(
                                        child: Icon(
                                          Icons.call,
                                          color: Colors.white,
                                          size: 17,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                      child: RichText(
                                        text: TextSpan(
                                          text: "Call :",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 15,
                                          ),
                                          children: <TextSpan>[
                                            TextSpan(
                                              text: ItemList["call_number"]
                                                  .toString(),
                                              style: TextStyle(
                                                color: maincolor,
                                                fontSize: 15,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                _launchCaller();
                              },
                              child: Container(
                                width: width,
                                child: Row(
                                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(5),
                                      alignment: Alignment.center,
                                      height: 25,
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        // border: Border.all(
                                        //   color: CupertinoColors.systemGrey5,
                                        //   width: 2,
                                        // ),
                                        color: Colors.black,
                                      ),
                                      child: const Center(
                                        child: Icon(
                                          Icons.call,
                                          color: Colors.white,
                                          size: 17,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                      child: RichText(
                                        text: TextSpan(
                                          text: "2nd Telephome Number :",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 15,
                                          ),
                                          children: <TextSpan>[
                                            TextSpan(
                                              text: ItemList["call_number2"]
                                                  .toString(),
                                              style: TextStyle(
                                                color: maincolor,
                                                fontSize: 15,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                _WplaunchUrl();
                              },
                              child: Container(
                                width: width,
                                child: Row(
                                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(5),
                                      alignment: Alignment.center,
                                      height: 25,
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        // border: Border.all(
                                        //   color: CupertinoColors.systemGrey5,
                                        //   width: 2,
                                        // ),
                                        color: Colors.green,
                                      ),
                                      child: const Center(
                                        child: Icon(
                                          Icons.whatsapp,
                                          color: Colors.white,
                                          size: 17,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                      child: RichText(
                                        text: TextSpan(
                                          text: "Whatsapp Number :",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 15,
                                          ),
                                          children: <TextSpan>[
                                            TextSpan(
                                              text: ItemList["call_numberwp"]
                                                  .toString(),
                                              style: TextStyle(
                                                color: maincolor,
                                                fontSize: 15,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                openMap(23.0398491, 72.5602797);
                              },
                              child: Container(
                                width: width,
                                child: Row(
                                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(5),
                                      alignment: Alignment.center,
                                      height: 25,
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        // border: Border.all(
                                        //   color: CupertinoColors.systemGrey5,
                                        //   width: 2,
                                        // ),
                                        color: Colors.black,
                                      ),
                                      child: const Center(
                                        child: Icon(
                                          Icons.location_on_sharp,
                                          color: Colors.white,
                                          size: 17,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                      width: width*0.80,
                                      child: RichText(
                                        text: TextSpan(
                                          text: "Location :",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 15,
                                          ),
                                          children: <TextSpan>[
                                            TextSpan(
                                              text: ItemList["address"]
                                                  .toString(),
                                              style: TextStyle(
                                                color: maincolor,
                                                fontSize: 15,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                _sendemail();
                              },
                              child: Container(
                                width: width,
                                child: Row(
                                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(5),
                                      alignment: Alignment.center,
                                      height: 25,
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        // border: Border.all(
                                        //   color: CupertinoColors.systemGrey5,
                                        //   width: 2,
                                        // ),
                                        color: Colors.black,
                                      ),
                                      child: const Center(
                                        child: Icon(
                                          Icons.email,
                                          color: Colors.white,
                                          size: 17,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                      child: RichText(
                                        text: TextSpan(
                                          text: "Email :",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 15,
                                          ),
                                          children: <TextSpan>[
                                            TextSpan(
                                              text:
                                                  ItemList["email"].toString(),
                                              style: TextStyle(
                                                color: maincolor,
                                                fontSize: 15,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Container(
                        height: height * 0.055,
                        width: width * 0.8,
                        child: RaisedButton(
                          elevation: 0,
                          color: maincolor,
                          onPressed: () {
                            String O_Id = ItemList['post_author'].toString();
                            print(O_Id);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => storeName(
                                  StoredetailsId: O_Id,
                                ),
                              ),
                            );
                          },
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50)),
                          child: const Text(
                            'VIEW STORE PROFILE',
                            style: TextStyle(
                              fontSize: 17,
                              color: Colors.white,
                              //fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Container(
                        height: 30,
                        alignment: Alignment.centerLeft,
                        child: const Text(
                          "DESCRIPTION",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Container(
                        //height: 30,
                        alignment: Alignment.centerLeft,
                        child: Text(
                          ItemList["description"].toString(),
                          //"Want to know exactly where to buy female jersey in Ghana? Want to know female jersey price in Ghana? You can get all the products and shop information you desire right here on reapp.com.gh, your product information you desire right here! Shop the easy way! General specitfication at glace",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15.5,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      // Column(
                      //   children: [
                      //     Container(
                      //       // padding: const EdgeInsets.only(top: 2),
                      //       // color: Colors.red,
                      //       width: width * 0.8,
                      //       child: Row(
                      //         mainAxisAlignment: MainAxisAlignment.start,
                      //         crossAxisAlignment: CrossAxisAlignment.center,
                      //         children: [
                      //           Container(
                      //             padding: const EdgeInsets.only(top: 10),
                      //             alignment: Alignment.centerLeft,
                      //             height: 7,
                      //             width: 7,
                      //             decoration: const BoxDecoration(
                      //               shape: BoxShape.circle,
                      //               color: Colors.black,
                      //             ),
                      //           ),
                      //           Container(
                      //             alignment: Alignment.bottomLeft,
                      //             padding:
                      //                 const EdgeInsets.only(left: 8, bottom: 6),
                      //             // color: Colors.blue,
                      //             width: width * 0.7,
                      //             height: 25,
                      //             child: const Text(
                      //               "Dreamchase Female Jersey",
                      //               textAlign: TextAlign.left,
                      //               style: TextStyle(
                      //                 fontSize: 13,
                      //                 color: Colors.black,
                      //               ),
                      //             ),
                      //           ),
                      //         ],
                      //       ),
                      //     ),
                      //     // Container(
                      //     //   // padding: const EdgeInsets.only(top: 2),
                      //     //   // color: Colors.red,
                      //     //   width: width * 0.8,
                      //     //   child: Row(
                      //     //     mainAxisAlignment: MainAxisAlignment.start,
                      //     //     crossAxisAlignment: CrossAxisAlignment.center,
                      //     //     children: [
                      //     //       Container(
                      //     //         padding: const EdgeInsets.only(top: 10),
                      //     //         alignment: Alignment.centerLeft,
                      //     //         height: 7,
                      //     //         width: 7,
                      //     //         decoration: const BoxDecoration(
                      //     //           shape: BoxShape.circle,
                      //     //           color: Colors.black,
                      //     //         ),
                      //     //       ),
                      //     //       Container(
                      //     //         alignment: Alignment.bottomLeft,
                      //     //         padding:
                      //     //             const EdgeInsets.only(left: 8, bottom: 6),
                      //     //         // color: Colors.blue,
                      //     //         width: width * 0.7,
                      //     //         height: 25,
                      //     //         child: const Text(
                      //     //           "High quality Female Jersey",
                      //     //           textAlign: TextAlign.left,
                      //     //           style: TextStyle(
                      //     //             fontSize: 13,
                      //     //             color: Colors.black,
                      //     //           ),
                      //     //         ),
                      //     //       ),
                      //     //     ],
                      //     //   ),
                      //     // ),
                      //   ],
                      // ),
                      // const SizedBox(
                      //   height: 10,
                      // ),
                      // Container(
                      //   //height: 30,
                      //   alignment: Alignment.centerLeft,
                      //   child: const Text(
                      //     "Want to know exactly where to buy female jersey in Ghana? Want to know female jersey price in Ghana? You can get all the products and shop information you desire right here on reapp.com.gh, your product information you desire right here! Shop the easy way! General specitfication at glace",
                      //     textAlign: TextAlign.left,
                      //     style: TextStyle(
                      //       color: Colors.black,
                      //       fontSize: 15.5,
                      //       // fontWeight: FontWeight.bold,
                      //     ),
                      //   ),
                      // ),
                      const SizedBox(
                        height: 20,
                      ),
                      tags.length > 0
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: const [
                                Icon(
                                  CupertinoIcons.tag_solid,
                                  color: Colors.black,
                                  size: 20,
                                ),
                                SizedBox(
                                  width: 12,
                                ),
                                Text(
                                  "Tags :",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            )
                          : const SizedBox(),
                      tags.length > 0
                          ? Flexible(
                              flex: 0,
                              child: Container(
                                height: height * 0.07,
                                child: ListView.builder(
                                    itemCount: tags.length,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder:
                                        (BuildContext cntx, int index) {
                                      return Container(
                                        // height: height * 0.0,
                                        // width: width,
                                        padding: const EdgeInsets.all(10),
                                        child: RaisedButton(
                                          elevation: 0,
                                          color: tagbutton,
                                          onPressed: () {
                                            String O_Id = tags[index]["term_id"]
                                                .toString();
                                            log(O_Id);
                                            String P_Id =
                                                tags[index]["name"].toString();
                                            log(
                                                "P_Id ==> ${P_Id.toString()}");
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      AllProducts(ProductId: O_Id, ProductName: P_Id, isFrom: 'tags',searchText: "",)                                          ),
                                            );
                                            // Navigator.push(
                                            //     context,
                                            //     MaterialPageRoute(
                                            //         builder: (context) =>
                                            //             TagProducts(
                                            //               TagProductId: O_Id,
                                            //               TagProductName: P_Id,
                                            //             )));
                                          },
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                          child: Text(
                                            tags[index]["name"].toString(),
                                            style: const TextStyle(
                                              fontSize: 16,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      );
                                    }),
                              ),
                            )
                          : const SizedBox(),
                      const SizedBox(
                        height: 5,
                      ),
                      Container(
                        height: 30,
                        alignment: Alignment.centerLeft,
                        child: const Text(
                          "USER'S RATING AND REVIEWS",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const Text(
                        "No reviews found",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          // fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Container(
                        height: height * 0.055,
                        width: width * 0.8,
                        child: RaisedButton(
                          elevation: 0,
                          color: maincolor,
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ReviewProduct_Screen(),
                              ),
                            );
                          },
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50)),
                          child: const Text(
                            'GIVE REVIEW FOR THIS PRODUCT',
                            style: TextStyle(
                              fontSize: 17,
                              color: Colors.white,
                              //fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: width,
                        child: Row(
                          children: [
                            Container(
                              alignment: Alignment.bottomLeft,
                              child: const Text(
                                "Share with your friends :",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  // fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                FontAwesomeIcons.facebookF,
                                color: Color(0xFF4267B2),
                                size: 18,
                              ),
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                FontAwesomeIcons.twitter,
                                color: Color(0xFF1DA1F2),
                                size: 18,
                              ),
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                FontAwesomeIcons.googlePlusG,
                                color: Colors.red,
                                size: 18,
                              ),
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                FontAwesomeIcons.linkedinIn,
                                color: Color(0xFF0072b1),
                                size: 18,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Flexible(
                        flex: 0,
                        child: Container(
                          child: Column(
                            children: [
                              moreitem.length > 0
                                  ? Container(
                                      alignment: Alignment.bottomLeft,
                                      child: const Text(
                                        "You Should See These Too:",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    )
                                  : const SizedBox(),
                              const SizedBox(
                                height: 5,
                              ),
                              moreitem.length > 0
                                  ? Container(
                                      height: height * 0.15,
                                      // width: width * 0.15,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: CupertinoColors.systemGrey5,
                                          width: 1.5,
                                        ),
                                      ),
                                      child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          physics:
                                              const AlwaysScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          itemCount: (moreitem.length >= 5)
                                              ? 5
                                              : moreitem.length,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return Container(
                                              // color: Colors.blue,
                                              //width: width * 0.45,
                                              // height: 100,
                                              child: Card(
                                                elevation: 4,
                                                // shape: RoundedRectangleBorder(
                                                //   // side: const BorderSide(
                                                //   //     color: Colors.grey),
                                                //   // borderRadius:
                                                //   //     BorderRadius.circular(
                                                //   //         10.0),
                                                // ),
                                                color: Colors.white,
                                                child: GestureDetector(
                                                  onTap: () {
                                                    String O_Id = moreitem[index]['ID'].toString();
                                                    print( "print ${moreitem[index]}");
                                                    Navigator.of(context).push(
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                             Productdetail(LocationId: O_Id,),
                                                      ),
                                                    );
                                                  },
                                                  child: Container(
                                                    padding:
                                                        const EdgeInsets.all(8),
                                                    child: Stack(
                                                      children: [
                                                        Positioned(
                                                          child: ClipRRect(
                                                            // borderRadius:
                                                            //     BorderRadius
                                                            //         .circular(
                                                            //             10),
                                                            child:
                                                                Image.network(
                                                              moreitem[index][
                                                                      'Featured_image']
                                                                  .toString(),
                                                              fit: BoxFit
                                                                  .fitWidth,
                                                            ),
                                                          ),
                                                        ),
                                                        Positioned(
                                                          //left: 8,
                                                          top: height * 0.09,
                                                          width: width * 0.4,
                                                          bottom: 0,
                                                          child: Container(
                                                            width: width * 0.35,
                                                            // color: Colors.red,
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  const BorderRadius
                                                                      .only(
                                                                topLeft: Radius
                                                                    .circular(
                                                                        5),
                                                                topRight: Radius
                                                                    .circular(
                                                                        5),
                                                              ),
                                                              color: Colors
                                                                  .black
                                                                  .withOpacity(
                                                                      0.65),
                                                            ),
                                                            child: Text(
                                                              moreitem[index][
                                                                      'post_title']
                                                                  .toString(),
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                              style:
                                                                  const TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 11.5,
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
                                              ),
                                            );
                                          }),
                                    )
                                  : const SizedBox(),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: width,
                        alignment: Alignment.bottomLeft,
                        child: const Text(
                          "ENJOY MORE OF US BY LIKING OUR SOCIALMEDIA PAGES",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Container(
                        width: width * 0.85,
                        child: Row(
                          children: [
                            Container(
                              height: 30,
                              //width: 20,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xFF4267B2),
                              ),
                              child: IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  FontAwesomeIcons.facebookF,
                                  color: Colors.white,
                                  size: 15,
                                ),
                              ),
                            ),
                            Container(
                              height: 30,
                              //width: 20,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xFF1DA1F2),
                              ),
                              child: IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  FontAwesomeIcons.twitter,
                                  color: Colors.white,
                                  size: 15,
                                ),
                              ),
                            ),
                            Container(
                              height: 30,
                              //width: 20,
                              decoration: const BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topRight,
                                  end: Alignment.bottomLeft,
                                  colors: [
                                    Color(0xff4f5bd5),
                                    Color(0xff962fbf),
                                    Color(0xffd62976),
                                    Color(0xfffa7e1e),
                                    Color(0xfffeda75),
                                  ],
                                ),
                                shape: BoxShape.circle,
                                // color: Color(0xFF4267B2),
                              ),
                              child: IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  FontAwesomeIcons.instagram,
                                  color: Colors.white,
                                  size: 15,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Container(
                        alignment: Alignment.bottomLeft,
                        child: const Text(
                          "Own a business?",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            // fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 3,
                      ),
                      Container(
                        alignment: Alignment.bottomLeft,
                        child: const Text(
                          "Have product to sell?",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            // fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 3,
                      ),
                      Container(
                        alignment: Alignment.bottomLeft,
                        child: const Text(
                          "Register and sell your products here.",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            // fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 3,
                      ),
                      Container(
                        alignment: Alignment.bottomLeft,
                        child: const Text(
                          "No Registration fee!",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            // fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: height * 0.055,
                        width: width * 0.8,
                        child: RaisedButton(
                          elevation: 0,
                          color: maincolor,
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SellerReg(),
                              ),
                            );
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: const Text(
                            'SELLER REGISTRATION',
                            style: TextStyle(
                              fontSize: 17,
                              color: Colors.white,
                              //fontWeight: FontWeight.w600,
                            ),
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

  static const double lat = 23.0398491, long = 72.5602797;

  // static const String map_api= "AIzaSyAHx53uKmJGKm79InBqHU2qr12pOGIMICg";
  //
  // _lauchmap() async {
  //   var url = 'geo:$lat,$long';
  //   if (Platform.isAndroid) {
  //     // iOS
  //    // String query = Uri.encodeComponent(address);
  //     //url = 'https://www.google.com/maps/search/?api=1&query=$lat,$long';
  //     // url = 'https://play.google.com/store/apps/details?id=com.google.android.apps.maps&hl=en&gl=US';
  //     url = 'https://www.google.com/store/apps/details?id=com.google.android.apps.maps&hl=en&gl=US';
  //   }
  //   if (await canLaunch(url)) {
  //     await launch(url);
  //   } else {
  //     throw 'Could not launch $url';
  //   }
  // }

  static Future<void> openMap(double lat, double long) async {
    String googleUrl =
        'https://www.google.com/maps/search/?api=1&query=$lat,$long';
    if (await canLaunch(googleUrl) != null) {
      await launch(googleUrl);
    } else {
      throw 'Could not open the map.';
    }
  }

  final Uri _url = Uri.parse('whatsapp://send?phone="+whatsapp+"&text=hello"');

  var whatsapp = "0209012668";

  _WplaunchUrl() async {
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }

  _sendemail() async {
    const url = 'mailto:abrahamgaitu@gmail.com';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _launchCaller() async {
    const url = "tel:0209012668";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  LocationAPIcall() async {
    setState(() {
      isReload = true;
    });
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString("token") ?? "";
      var user_id = prefs.getString("uid") ?? "";
      print(user_id);
      var location_id = prefs.getString("location_id") ?? "";
      // print(location_id);
      final Header = {
        "Authorization": "Bearer ${token.toString()}",
      };
      print("$Singleproduct_api${widget.LocationId}");
      //   var response = await http.post(Uri.parse(login), body: body);
      var response = await http.get(
        headers: Header,
        Uri.parse("$Singleproduct_api${widget.LocationId}"),
      );
      print("responce product ${response.statusCode}");

      if (response.statusCode == 200) {
        var decode = jsonDecode(response.body);
        print(decode);

        ItemList.clear();
        ItemList = decode;
        productbannerimg.clear();
        productbannerimg = decode["main_attachment"];
        // print(productbannerimg);
        tags.clear();
        tags = decode['tags'];
        print("tages ${tags}");

        moreitem.clear();
        moreitem = decode["related_posts"];
        print("moreitems $moreitem");

        // allproducts.clear();
        // print("responce post ${decode["posts"][0]}");
        // allproducts = decode["posts"];

        setState(() {
          isReload = false;
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
        isReload = false;
      });
      print("Exception in product list=>$e");
      throw e;
    }
  }
  SaveWishlistApiCall( String postid) async {
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



      var response = await http.post(Uri.parse(SaveWishlist),
          body: body, headers: Header);

      if (response.statusCode == 200) {
        var decode = jsonDecode(response.body);
        print(decode);



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
