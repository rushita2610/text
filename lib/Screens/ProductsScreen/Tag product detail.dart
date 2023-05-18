import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Api/api.dart';
import '../../ColorConstant/ColorConstant.dart';
import 'ProductDetailScreen.dart';
import 'package:http/http.dart' as http;

class TagProducts extends StatefulWidget {
  String TagProductId;
  String TagProductName;

  TagProducts({Key? key,required this.TagProductId, required this.TagProductName}) : super(key: key);

  @override
  State<TagProducts> createState() => _TagProductsState();
}

class _TagProductsState extends State<TagProducts> {
  bool isReload = false;

  List<dynamic> TagProducts = [
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
    // TODO: implement initState
    super.initState();
    LocationAPIcall();
    //print(LocationAPIcall);
    // print(widget.ProductName+" 123");
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
              //"Products",
              "${widget.TagProductName}",
              style: TextStyle(
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
            ? SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(15),
            //height: height,
            child: Column(
              children: [
                Flexible(
                  flex: 0,
                  child: Container(
                    height: height,
                    child: GridView.builder(
                        itemCount: TagProducts.length,
                        physics: const NeverScrollableScrollPhysics(),
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
                              String O_Id = TagProducts[index]['ID'].toString();
                              print(O_Id);

                              //TagProducts[index]
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
                                              TagProducts[index]['Featured_image'].toString(),
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
                                              TagProducts[index]['post_title'].toString(),
                                              textAlign: TextAlign.center,
                                              style: const TextStyle(
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
                                              alignment: Alignment.center,
                                              height: 25,
                                              width: width * 0.2,
                                              color: drawericon,
                                              child: Text(
                                                TagProducts[index]['normal_price'].toString(),
                                                //"GHC ${TagProducts[index]['GHC']}",
                                                textAlign:
                                                TextAlign.center,
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 13,
                                                  fontWeight:
                                                  FontWeight.w400,
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
                                        onTap: () {},
                                        child: Container(
                                          padding:
                                          const EdgeInsets.all(3),
                                          alignment: Alignment.center,
                                          height: 30,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                              color: CupertinoColors
                                                  .systemGrey5,
                                              width: 2,
                                            ),
                                            color: Colors.white,
                                          ),
                                          child: const Center(
                                            child: Icon(
                                              Icons.favorite_border,
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
      print(location_id);
      final Header = {
        "Authorization": "Bearer ${token.toString()}",
      };
      print(ProductTag_Api + "${widget.TagProductId}");
      //   var response = await http.post(Uri.parse(login), body: body);
      var response = await http.get(
        headers: Header,
        Uri.parse(ProductTag_Api + "${widget.TagProductId}"),
      );
      print("responce product ${response.statusCode}");

      if (response.statusCode == 200) {
        var decode = jsonDecode(response.body);
        // print(decode);

        TagProducts.clear();
        print("responce post ${decode}");
        TagProducts = decode;




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
}
