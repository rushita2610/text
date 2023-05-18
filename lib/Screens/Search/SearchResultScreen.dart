import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../ColorConstant/ColorConstant.dart';
import '../ProductsScreen/ProductDetailScreen.dart';

class SearchResult extends StatefulWidget {
  const SearchResult({Key? key}) : super(key: key);

  @override
  State<SearchResult> createState() => _SearchResultState();
}

class _SearchResultState extends State<SearchResult> {
  bool isReload = false;
  List<dynamic> allproducts = [
    {
      'name': 'Treadmill with Massager',
      'image': 'assets/images/tdm1.jpeg',
      'GHC': '6,700',
    },
    {
      'name': 'Treadmill with Massager',
      'image': 'assets/images/tdm2.jpeg',
      'GHC': '4,500',
    },
    {
      'name': 'Treadmill with Massager',
      'image': 'assets/images/tdm3.jpeg',
      'GHC': '6,500',
    },
    {
      'name': 'Football Jersey',
      'image': 'assets/images/fdb1.jpeg',
      'GHC': '450',
    },
    {
      'name': 'Football Jersey',
      'image': 'assets/images/fdb2.jpeg',
      'GHC': '780',
    },
    {
      'name': 'Football Jersey',
      'image': 'assets/images/fbj4.jpeg',
      'GHC': '500',
    },
  ];

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
            child: const Text(
              "SEARCH RESULT FOR:",
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
                  child: Column(
                    children: [
                      allproducts.length > 0
                          ? Flexible(
                              flex: 0,
                              child: Container(
                                height: height,
                                child: GridView.builder(
                                    itemCount: allproducts.length,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
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
                                          // Navigator.push(
                                          //   context,
                                          //   MaterialPageRoute(
                                          //     builder: (context) =>
                                          //          Productdetail(),
                                          //   ),
                                          // );
                                        },
                                        child: Container(
                                          //height: height * 0.2,
                                          child: Card(
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
                                                        child: Image.asset(
                                                          allproducts[index]
                                                              ['image'],
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
                                                          allproducts[index]
                                                              ['name'],
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
                                                            "GHC ${allproducts[index]['GHC']}",
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
                                                Positioned(
                                                  right: 7,
                                                  top: 7,
                                                  child: InkWell(
                                                    onTap: () {},
                                                    child: Container(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              3),
                                                      alignment:
                                                          Alignment.center,
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
                            )
                          : Column(
                              children: [
                                Container(
                                  width: width * 0.8,
                                  child: const Text(
                                    "Oops, No results found for selected search criteria.",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Container(
                                  width: width,
                                  // color: Colors.red,
                                  alignment: Alignment.topLeft,
                                  child: const Text(
                                    "Possible Remedies:",
                                    // textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Container(
                                  width: width,
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        height: 15,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            color: Colors.black,
                                          ),
                                        ),
                                        child: Container(
                                          margin: const EdgeInsets.all(4),
                                          height: 10,
                                          width: 10,
                                          decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Container(
                                        width: width * 0.859,
                                        alignment: Alignment.topLeft,
                                        child: const Text(
                                          "Please search using short, simple or generic keywords like fridges, dell laptops, women's dresses, bags etc.",
                                          // textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Colors.black,
                                            //fontWeight: FontWeight.bold,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 7,
                                ),
                                Container(
                                  width: width,
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        height: 15,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            color: Colors.black,
                                          ),
                                        ),
                                        child: Container(
                                          margin: const EdgeInsets.all(4),
                                          height: 10,
                                          width: 10,
                                          decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Container(
                                        width: width * 0.859,
                                        alignment: Alignment.topLeft,
                                        child: const Text(
                                          "Kindly check forn possible spelling mistakes in your search criteria or keyword.",
                                          // textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Colors.black,
                                            //fontWeight: FontWeight.bold,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 7,
                                ),
                                Container(
                                  width: width,
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        height: 15,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            color: Colors.black,
                                          ),
                                        ),
                                        child: Container(
                                          margin: const EdgeInsets.all(4),
                                          height: 10,
                                          width: 10,
                                          decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Container(
                                        width: width * 0.859,
                                        alignment: Alignment.topLeft,
                                        child: RichText(
                                          text: const TextSpan(
                                            text:
                                                "Still not getting the desired results? Send us an e-mail-",
                                            style: TextStyle(
                                              color: Colors.black,
                                              //fontWeight: FontWeight.bold,
                                              fontSize: 14,
                                            ),
                                            children: <TextSpan>[
                                              TextSpan(
                                                text: "support@reapp.com.gh ",
                                                style: TextStyle(
                                                  color: maincolor,
                                                  //fontWeight: FontWeight.bold,
                                                  fontSize: 14,
                                                ),
                                              ),
                                              TextSpan(
                                                text: "or call/WhatsApp us on ",
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  //fontWeight: FontWeight.bold,
                                                  fontSize: 14,
                                                ),
                                              ),
                                              TextSpan(
                                                text: "+233 54 6090864 ",
                                                style: TextStyle(
                                                  color: maincolor,
                                                  //fontWeight: FontWeight.bold,
                                                  fontSize: 14,
                                                ),
                                              ),
                                              TextSpan(
                                                text:
                                                    "and we will help you find a shop that has that specific product in stock. Yes all that just for you!",
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  //fontWeight: FontWeight.bold,
                                                  fontSize: 14,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
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
}
