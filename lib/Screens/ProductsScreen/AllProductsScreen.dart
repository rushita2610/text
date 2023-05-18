import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Api/api.dart';
import '../../ColorConstant/ColorConstant.dart';
import 'ProductDetailScreen.dart';
import 'package:http/http.dart' as http;

class AllProducts extends StatefulWidget {
  String ProductId;
  String ProductName;
  String isFrom;
  String searchText;

  AllProducts(
      {Key? key,
      required this.ProductId,
      required this.ProductName,
      required this.isFrom,
      required this.searchText})
      : super(key: key);

  @override
  State<AllProducts> createState() => _AllProductsState();
}

class _AllProductsState extends State<AllProducts> {
  bool isReload = false;
  bool isReloadPaginate = false;
  String isFav = "false";

  ScrollController scrollController = ScrollController();
  int pageIndex = 0;
  int currentPage = 0, lastPage = 0;

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
    // dateinput.text = "";
    // dateinput2.text = ""; //set the initial value of text field
    super.initState();
    //GetlistAPIcall(false);

    if (widget.isFrom == "Category") {
      productListAPIcall(false);
    } else if (widget.isFrom == "tags") {
      ProductTagAPIcall(false);
    } else {
      LocationAPIcall(false);
    }

    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
          scrollController.position.pixels) {
        if (currentPage != lastPage) {
          if (widget.isFrom == "Category") {
            productListAPIcall(true);
          } else if (widget.isFrom == "tags") {
            ProductTagAPIcall(true);
          } else {
            LocationAPIcall(true);
          }
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
            child: Text(
              //"Products",
              "${widget.ProductName}",
              style: const TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          backgroundColor: CupertinoColors.systemGrey5,
          elevation: 0,
          //centerTitle: true,
        ),
        body: (isReload == false)
            ? Container(
                padding: const EdgeInsets.all(15),
                height: height,
                child: GridView.builder(
                    controller: scrollController,
                    itemCount: allproducts.length,
                    // physics: const NeverScrollableScrollPhysics(),
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
                          String O_Id = allproducts[index]['ID'].toString();
                          print(O_Id);

                          //allproducts[index]
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Productdetail(
                                LocationId: O_Id,
                              ),
                            ),
                          );
                        },
                        child: Container(
                          //height: height * 0.2,
                          child: Card(
                            elevation: 0,
                            color: CupertinoColors.systemGrey5,
                            shape: const RoundedRectangleBorder(
                              side: BorderSide(color: Colors.grey),
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
                                          allproducts[index]['Featured_image']
                                              .toString(),
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
                                    // /color: Colors.red,
                                    child: Column(
                                      children: [
                                        Text(
                                          allproducts[index]['post_title']
                                              .toString(),
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 13,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Container(
                                          alignment: Alignment.center,
                                          height: 25,
                                          width: width * 0.2,
                                          color: drawericon,
                                          child: Text(
                                            allproducts[index]['normal_price']
                                                .toString(),
                                            //"GHC ${allproducts[index]['GHC']}",
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 13,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Positioned(
                                  right: 7,
                                  top: 7,
                                  child: InkWell(
                                    onTap: () {
                                      // print( allproducts[index].toString());
                                      SaveWishlistApiCall(
                                          allproducts[index]["ID"].toString(),
                                          index);
                                    },
                                    child: widget.isFrom == "tags"
                                        ? ((allproducts[index]["wishlist"]
                                                    .toString() ==
                                                "enable")
                                            ? const Icon(Icons.favorite_border,
                                                color: Colors.red)
                                            : const Icon(Icons.favorite,
                                                color: Colors.red))
                                        : (allproducts[index]["wishlist"]
                                                    .toString() ==
                                                "enable")
                                            ? const Icon(Icons.favorite_border,
                                                color: Colors.red)
                                            : const Icon(Icons.favorite,
                                                color: Colors.red),
                                    // Container(
                                    //   decoration: BoxDecoration(
                                    //       shape: BoxShape.circle,
                                    //       color: Colors.white),
                                    //   child: (allproducts[index]["wishlist"]
                                    //               .toString() ==
                                    //           "enable")
                                    //       ? Icon(Icons.favorite_border,
                                    //           color: Colors.red)
                                    //       : Icon(Icons.favorite,
                                    //           color: Colors.red),
                                    // ),
                                    // Container(
                                    //   padding:
                                    //   const EdgeInsets.all(3),
                                    //   alignment: Alignment.center,
                                    //   height: 30,
                                    //   decoration: BoxDecoration(
                                    //     shape: BoxShape.circle,
                                    //     border: Border.all(
                                    //       color: CupertinoColors
                                    //           .systemGrey5,
                                    //       width: 2,
                                    //     ),
                                    //     color: Colors.white,
                                    //   ),
                                    //   child: const Center(
                                    //     child: Icon(
                                    //       Icons.favorite_border,
                                    //       color: Colors.red,
                                    //       size: 20,
                                    //     ),
                                    //   ),
                                    // ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
              )
            : const Center(
                child: CircularProgressIndicator(
                  color: maincolor,
                ),
              ),
      ),
    );
  }

  LocationAPIcall(bool isPaginate) async {
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

      var response = await http.get(
        headers: Header,
        Uri.parse(Location_Api +
            "$user_id&location_id=${widget.ProductId}&per_page=10&page=${currentPage}"),
      );
      print("responce product ${response.statusCode}");

      //user_id=0&location_id=17066&per_page=10&page=1
      if (response.statusCode == 200) {
        var decode = jsonDecode(response.body);
        print(decode);

        setState(() {
          // currentPage = decode["data"]["current_page"];
          // lastPage = decode["data"]["last_page"];

          if (currentPage == 1) {
            allproducts.clear();
          }

          if (decode["posts"].length > 0) {
            for (int i = 0; i < decode["posts"].length; i++) {
              print("id ${decode["posts"][i]["ID"]}");
              allproducts.add(decode["posts"][i]);
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

  productListAPIcall(bool isPaginate) async {
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

      print(getProductList +
          "$user_id&search=&cat_id=${widget.ProductId}&per_page=10&page=${currentPage}");

      // https://reapp.com.gh/wp-json/wp/v2/search-posts?user_id=0&search=&cat_id=123&per_page=10&page=1
      var response = await http.get(
        headers: Header,
        Uri.parse(getProductList +
            "$user_id&search=${widget.searchText}&cat_id=${widget.ProductId}&per_page=10&page=${currentPage}"),
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
            allproducts.clear();
          }

          if (decode["posts"].length > 0) {
            for (int i = 0; i < decode["posts"].length; i++) {
              print("id ${decode["posts"][i]["ID"]}");
              allproducts.add(decode["posts"][i]);
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

  ProductTagAPIcall(bool isPaginate) async {
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

      print(ProductTag_Api +
          "$user_id&tags=${widget.ProductId}&per_page=10&page=${currentPage}");
      var response = await http.get(
        headers: Header,
        Uri.parse(ProductTag_Api +
            "$user_id&tags=${widget.ProductId}&per_page=10&page=${currentPage}"),
      );
      print("responce product list ${response.statusCode}");

      if (response.statusCode == 200) {
        var decode = jsonDecode(response.body);
        print(decode);

        setState(() {
          // currentPage = decode["data"]["current_page"];
          // lastPage = decode["data"]["last_page"];

          if (currentPage == 1) {
            allproducts.clear();
          }

          if (decode.length > 0) {
            for (int i = 0; i < decode.length; i++) {
              print("id ${decode[i]["ID"]}");
              allproducts.add(decode[i]);
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

  SaveWishlistApiCall(String postid, int indexProduct) async {
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

      var response =
          await http.post(Uri.parse(SaveWishlist), body: body, headers: Header);

      if (response.statusCode == 200) {
        var decode = jsonDecode(response.body);
        print(decode);

        currentPage = 0;
        if (widget.isFrom == "Category") {
          productListAPIcall(false);
        } else if (widget.isFrom == "tags") {
          ProductTagAPIcall(false);
        } else {
          LocationAPIcall(false);
        }

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

  GetlistAPIcall(bool isPaginate) async {
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
      print(GetList_Api +
          "$user_id&search=&cat_id=${widget.ProductId}&per_page=10&page=${currentPage}");
      var response = await http.get(
        headers: Header,
        Uri.parse(GetList_Api +
            "$user_id&search=&cat_id=${widget.ProductId}&per_page=10&page=${currentPage}"),
      );
      print("responce product list ${response.statusCode}");

      if (response.statusCode == 200) {
        var decode = jsonDecode(response.body);
        print(decode);

        setState(() {
          if (currentPage == 1) {
            allproducts.clear();
          }

          if (decode.length > 0) {
            for (int i = 0; i < decode.length; i++) {
              print("id ${decode[i]["ID"]}");
              allproducts.add(decode[i]);
            }
          } else {
            lastPage = currentPage;
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
}
