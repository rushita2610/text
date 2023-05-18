// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../Api/api.dart';
import '../../ColorConstant/ColorConstant.dart';
import 'ProductDetailScreen.dart';
import 'package:http/http.dart' as http;


class storeName extends StatefulWidget {
  String StoredetailsId;
 // String PostauthorId;


  storeName({Key? key , required this.StoredetailsId,}) : super(key: key);

  @override
  State<storeName> createState() => _storeNameState();
}

class _storeNameState extends State<storeName> {
  bool isReload = false;
  Map ItemList = {};
  ScrollController scrollController = ScrollController();
  int pageIndex = 0;
  int currentPage = 0, lastPage = 0;
  bool isReloadPaginate = false;


  List<dynamic> allproducts = [
    // {
    //   'name': 'Treadmill with Massager',
    //   'image': 'assets/images/tdm1.jpeg',
    //   'GHC': '6,700',
    // },
    // {
    //   'name': 'Treadmill with Massager',
    //   'image': 'assets/images/tdm2.jpeg',
    //   'GHC': '4,500',
    // },
    // {
    //   'name': 'Treadmill with Massager',
    //   'image': 'assets/images/tdm3.jpeg',
    //   'GHC': '6,500',
    // },
    // {
    //   'name': 'Football Jersey',
    //   'image': 'assets/images/fdb1.jpeg',
    //   'GHC': '450',
    // },
    // {
    //   'name': 'Football Jersey',
    //   'image': 'assets/images/fdb2.jpeg',
    //   'GHC': '780',
    // },
    // {
    //   'name': 'Football Jersey',
    //   'image': 'assets/images/fbj4.jpeg',
    //   'GHC': '500',
    // },
  ];


  @override
  void initState() {
    super.initState();
    StoredetailsAPIcall();
    Storeproduct_APIcall(false);

    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
          scrollController.position.pixels) {
        if (currentPage != lastPage) {
          Storeproduct_APIcall(true);
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
            child:  Text(
              ItemList["Name"].toString(),
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          backgroundColor: CupertinoColors.systemGrey5,
          elevation: 0,
        ),
        body: (isReload == false)
            ? SingleChildScrollView(
         controller: scrollController,
                child: Container(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    children: [
                      Container(
                        child: Center(
                          child: ClipRRect(
                            child: Image.network(
                              ItemList["profile_image"].toString(),
                              //"assets/images/fbj4.jpeg",
                              fit: BoxFit.fitWidth,
                              width: width,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
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
                            Container(
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
                                      text:  TextSpan(
                                        text: "Store Name :",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 15,
                                        ),
                                        children: <TextSpan>[
                                          TextSpan(
                                            text:ItemList["Name"].toString(),
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
                                        text:  TextSpan(
                                          text: "Call :",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 15,
                                          ),
                                          children: <TextSpan>[
                                            TextSpan(
                                              text:ItemList["phone"].toString(),
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
                                        text:  TextSpan(
                                          text: "2nd Telephone Number :",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 15,
                                          ),
                                          children: <TextSpan>[
                                            TextSpan(
                                              text: ItemList["mobile"].toString(),
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
                                        text:  TextSpan(
                                          text: "Whatsapp Number :",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 15,
                                          ),
                                          children: <TextSpan>[
                                            TextSpan(
                                              text:  ItemList["whatsapp"].toString(),
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
                                // _lauchmap();
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

                                      width: width * 0.82,
                                      child: RichText(
                                        text:  TextSpan(
                                          text: "Location :",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 15,
                                          ),
                                          children: <TextSpan>[
                                            TextSpan(
                                              text: ItemList["address"].toString(),
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
                                        text:  TextSpan(
                                          text: "Email : ",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 15,
                                          ),
                                          children: <TextSpan>[
                                            TextSpan(
                                              text: ItemList["user_email"].toString(),
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
                        height: 20,
                      ),
                      allproducts.length > 0
                          ? Container(
                             height: allproducts.length*132.5,
                            child: GridView.builder(
                              // controller: scrollController,
                                itemCount: allproducts.length,
                                physics: NeverScrollableScrollPhysics(),
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 5,
                                  mainAxisSpacing: 5,
                                  childAspectRatio: 0.7,
                                  //mainAxisExtent: 95,
                                ),
                                itemBuilder: (cntx, index) {
                                  return InkWell(
                                    onTap: () {
                                      String O_Id = allproducts[index]['id'].toString();
                                      print( "print ${allproducts[index]}");
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                               Productdetail(LocationId: O_Id,),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      //height: height * 0.2,
                                      child: Card(
                                        elevation: 0,
                                        color: CupertinoColors.systemGrey5,
                                        shape: const RoundedRectangleBorder(
                                          side: BorderSide(
                                              color: Colors.grey),
                                        ),
                                        child: Stack(
                                          children: [
                                            Positioned(
                                              top: 10,
                                              left: 5,
                                              right: 5,
                                              height: height * 0.2,
                                              child: Container(
                                                child: Center(
                                                  child: ClipRRect(
                                                    child: Image.network(
                                                      allproducts[index]["feature_image_url"][0]
                                                          ['img_url'].toString(),
                                                      fit: BoxFit.fitWidth,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                              bottom: height * 0.015,
                                              left: 10,
                                              right: 10,
                                              child: Container(
                                                // color: Colors.red,
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      allproducts[index]
                                                          ['post_title'].toString(),
                                                      textAlign:
                                                          TextAlign.center,
                                                      style:
                                                          const TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 13,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                    Container(
                                                      alignment:
                                                          Alignment.center,
                                                      height: 25,
                                                      width: width * 0.2,
                                                      color: drawericon,
                                                      child: Text(
                                                        allproducts[index]
                                                        ['price'].toString(),
                                                        textAlign: TextAlign
                                                            .center,
                                                        style:
                                                            const TextStyle(
                                                          color:
                                                              Colors.white,
                                                          fontSize: 13,
                                                          fontWeight:
                                                              FontWeight
                                                                  .w400,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            // Positioned(
                                            //   right: 7,
                                            //   top: 7,
                                            //   child: InkWell(
                                            //     onTap: () {
                                            //       print( allproducts[index][""].toString());
                                            //     },
                                            //     child: Container(
                                            //       padding:
                                            //           const EdgeInsets.all(
                                            //               3),
                                            //       alignment:
                                            //           Alignment.center,
                                            //       height: 30,
                                            //       decoration: BoxDecoration(
                                            //         shape: BoxShape.circle,
                                            //         border: Border.all(
                                            //           color: CupertinoColors
                                            //               .systemGrey5,
                                            //           width: 2,
                                            //         ),
                                            //         color: Colors.white,
                                            //       ),
                                            //       child: const Center(
                                            //         child: Icon(
                                            //           Icons.favorite_border,
                                            //           color: Colors.red,
                                            //           size: 20,
                                            //         ),
                                            //       ),
                                            //     ),
                                            //   ),
                                            // ),
                                          ],
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
              )
            : const Center(
                child: CircularProgressIndicator(
                  color: maincolor,
                ),
              ),
      ),
    );
  }

  static const double lat = 23.0398491,  long = 72.5602797;
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

  static Future<void> openMap(double lat,double long) async {
    String googleUrl = 'https://www.google.com/maps/search/?api=1&query=$lat,$long';
    if(await canLaunch(googleUrl) != null) {
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

  StoredetailsAPIcall() async {
    setState(() {
      isReload = true;
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
      print("$getUsertProfile_Api${widget.StoredetailsId}");
      //   var response = await http.post(Uri.parse(login), body: body);
      var response = await http.get(
        headers: Header,
        Uri.parse("$getUsertProfile_Api${widget.StoredetailsId}"),
      );
      print("responce product ${response.statusCode}");

      if (response.statusCode == 200) {
        var decode = jsonDecode(response.body);
        print(decode);



        ItemList.clear();
        ItemList = decode["data"][0];



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

  Storeproduct_APIcall(bool isPaginate) async {
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
      print(Fetchpost_Api + "${widget.StoredetailsId}&per_page=10&page=${currentPage}");
      //   var response = await http.post(Uri.parse(login), body: body);
      var response = await http.get(
        headers: Header,
        Uri.parse(Fetchpost_Api + "${widget.StoredetailsId}&per_page=10&page=${currentPage}"),
      );
      print("responce product ${response.statusCode}");

      if (response.statusCode == 200) {
        print("responce product ${response.statusCode}");
        var decode = jsonDecode(response.body);
         print(decode);


        allproducts.clear();
        print("responce post ${decode["data"][0]}");
        allproducts = decode["data"];


        setState(() {
          currentPage = decode["data"]["current_page"];
          lastPage = decode["data"]["last_page"];

          if (currentPage == 1) {
            allproducts.clear();
          }

          for (int i = 0; i < decode["data"]["data"].length; i++) {
            allproducts.add(decode["data"]["data"][i]);
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
      print("Exception in product =>$e");
      throw e;
    }
  }



}
