import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../Api/api.dart';
import '../../ColorConstant/ColorConstant.dart';
import 'package:http/http.dart' as http;

import 'Make New Ad Screen.dart';

class Stocklist_Screen extends StatefulWidget {
 // String StockId;

   Stocklist_Screen({Key? key}) : super(key: key);

  @override
  State<Stocklist_Screen> createState() => _Stocklist_ScreenState();
}

class _Stocklist_ScreenState extends State<Stocklist_Screen> {
  bool isReload = false;
  List<dynamic> stocklist=[
    // 'In Stock',
    // 'Out of stock'
  ];
  String Stockcolour= "0";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Stock_APIcall();
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
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_outlined,
            color: maincolor,
          ),
        ),
        title: const Text(
          "Stock",
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w800,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: (isReload == false)
          ? Form(
              child: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(15),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 8, right: 8),
                      height: height * 0.058,
                      width: width,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: CupertinoColors.systemGrey5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Choose Stock",
                            style: TextStyle(
                                fontSize: 14,
                                color: CupertinoColors.systemGrey),
                          ),
                          IconButton(onPressed: (){
                            Navigator.pop(context);
                          }, icon: Icon(Icons.close))
                        ],
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: CupertinoColors.systemGrey5),
                          //color: Colors.red
                      ),
                      height: height*0.60,
                      width: width,
                      child: ListView.builder(
                        itemCount: stocklist.length,

                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              InkWell(

                                onTap: (){
                                  setState(() {
                                    Stockcolour =stocklist[index]["id"].toString();
                                    print(Stockcolour);

                                  });

                                  setState(() {
                                    selectedADStock = stocklist[index]["name"].toString();
                                  });
                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Makenewad_Screen()
                                      ),
                                      ModalRoute.withName("/")
                                  );
                                  },
                                child: Container(
                                //  height: 30,
                                  color: ( Stockcolour == stocklist[index]["id"].toString())
                                      ? maincolor
                                      : Colors.white,
                                  child: ListTile(

                                    title: Text(stocklist[index]["name"].toString(),style: TextStyle(fontSize: 14,),),
                                  ),
                                ),
                              ),
                              Container(
                                  padding: EdgeInsets.only(left: 5,right: 5),
                                  child: Divider(color: Colors.black,))
                            ],
                          );
                        },
                      ),
                    ),


                  ],
                ),
              ),
            ))
          : const Center(
              child: CircularProgressIndicator(
                color: maincolor,
              ),
            ),
    ));
  }

  Stock_APIcall() async {
    setState(() {
      isReload = true;
    });
    try {
      //   var response = await http.post(Uri.parse(login), body: body);
      var response = await http.get(Uri.parse(Stock_Api));
      if (response.statusCode == 200) {
        var decode = jsonDecode(response.body);

        print("decode${decode}");
        // print(" Data ${categories = decode["categories"]}");
        stocklist.clear();
        stocklist = decode["data"];

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

}
