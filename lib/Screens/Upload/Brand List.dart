import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../Api/api.dart';
import '../../ColorConstant/ColorConstant.dart';
import 'package:http/http.dart' as http;

import 'Make New Ad Screen.dart';


class Brandlist_Screen extends StatefulWidget {
  const Brandlist_Screen({Key? key}) : super(key: key);

  @override
  State<Brandlist_Screen> createState() => _Brandlist_ScreenState();
}

class _Brandlist_ScreenState extends State<Brandlist_Screen> {
  bool isReload = false;
  List<dynamic> Brandlist=[
    // 'Nike',
    // 'Adidas',
    // 'Samsung',
    // 'Hp',
    // 'Nokia',
    // 'Dell',
    // 'Mac',
    // 'Maybelline'
  ];

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
    return SafeArea(child: Scaffold(
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
          "Brand",
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
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    height: height * 0.058,
                    width: width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: CupertinoColors.systemGrey5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Choose Brand",
                          style: TextStyle(
                              fontSize: 14,
                              color: CupertinoColors.systemGrey),
                        ),
                        IconButton(onPressed: (){
                          Navigator.pop(context);
                        }, icon: const Icon(Icons.close))
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: CupertinoColors.systemGrey5),
                      //color: Colors.red
                    ),
                    height: Brandlist.length*19,
                    width: width,
                    child: ListView.builder(
                      itemCount: Brandlist.length,

                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            InkWell(
                              onTap: (){

                                setState(() {
                                  selectedADBrand = Brandlist[index]["name"].toString();
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
                                padding: EdgeInsets.only(left: 15,top: 10),
                                  height: 30,
                                // color: Colors.green,
                                child:
                                  Container(
                                    alignment: AlignmentDirectional.topStart,
                                      child: Text(Brandlist[index]["name"], style: const TextStyle(fontSize: 14,),)),

                              ),
                            ),
                            Container(
                                padding: const EdgeInsets.only(left: 15,right: 15),
                                child: const Divider(color: Colors.black,))
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
      var response = await http.get(Uri.parse(Brand_Api));
      if (response.statusCode == 200) {
        var decode = jsonDecode(response.body);

        print("decode${decode}");
        // print(" Data ${categories = decode["categories"]}");
        Brandlist.clear();
        Brandlist = decode["data"];

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
