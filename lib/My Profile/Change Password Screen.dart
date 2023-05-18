import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:reapp_ghana_project/My%20Profile/My%20Profile%20Screen.dart';
import 'package:reapp_ghana_project/Screens/Validation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Api/api.dart';
import '../ColorConstant/ColorConstant.dart';
import '../Screens/BottomNavigationBarScreen/BottomNavigationScreen.dart';
import 'package:http/http.dart' as http;

class Changepassword_Screen extends StatefulWidget {
  const Changepassword_Screen({Key? key}) : super(key: key);

  @override
  State<Changepassword_Screen> createState() => _Changepassword_ScreenState();
}

class _Changepassword_ScreenState extends State<Changepassword_Screen> {
  bool isReload = false;
  bool isobscure = false;
  bool isobscure1 = false;

  final GlobalKey<FormState> _formKey = GlobalKey();
  TextEditingController Newpassword = TextEditingController();
  TextEditingController Confirmpassword = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
          "Change Password",
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
          ? Form(
              key: _formKey,
              child: SingleChildScrollView(
                physics: const NeverScrollableScrollPhysics(),
                child: Container(
                  height: height,
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        alignment: AlignmentDirectional.topStart,
                        child: const Text(
                          "New Password",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: height * 0.058,
                        width: width,
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          controller: Newpassword,
                          textAlignVertical: TextAlignVertical.bottom,
                          obscureText: isobscure,
                          //controller: search,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: CupertinoColors.systemGrey5,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: BorderSide.none,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: BorderSide.none,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: BorderSide.none,
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                (isobscure == false)
                                    ? Icons.visibility_outlined
                                    : Icons.visibility_off_outlined,
                                color: Colors.grey,
                                size: 20,
                              ),
                              onPressed: () {
                                setState(() {
                                  isobscure = !isobscure;
                                });
                              },
                            ),
                            hintText: "Password",
                            hintStyle: const TextStyle(
                              color: Colors.grey,
                              fontSize: 15.5,
                            ),
                          ),
                          validator: (text) {
                            if (text == null || text.isEmpty) {
                              return null;
                            } else if (text.isValidPassword() == false) {}
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Container(
                        alignment: AlignmentDirectional.topStart,
                        child: const Text(
                          "Confirm Password",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: height * 0.058,
                        width: width,
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          controller: Confirmpassword,
                          textAlignVertical: TextAlignVertical.bottom,
                          obscureText: isobscure1,
                          //controller: search,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: CupertinoColors.systemGrey5,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: BorderSide.none,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: BorderSide.none,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: BorderSide.none,
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                (isobscure1 == false)
                                    ? Icons.visibility_outlined
                                    : Icons.visibility_off_outlined,
                                color: Colors.grey,
                                size: 20,
                              ),
                              onPressed: () {
                                setState(() {
                                  isobscure1 = !isobscure1;
                                });
                              },
                            ),
                            hintText: "Password Confirm",
                            hintStyle: const TextStyle(
                              color: Colors.grey,
                              fontSize: 15.5,
                            ),
                          ),
                          validator: (text) {
                            if (text == null || text.isEmpty) {
                              return  "" ;
                            } else if (text.isValidPassword() == false) {}
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: maincolor),
                        height: 50,
                        width: width,
                        child: TextButton(
                          onPressed: () {


                            //if (_formKey.currentState!.validate()) {

                            if (Newpassword.text != "") {
                              if ( Newpassword.text == Confirmpassword.text){
                                Changepassword_Api();
                              }else{

                                  _showfluttertoast(
                                      msg: 'New password and Confirm password incorrect');

                               // }
                              }

                            }


                           // }
                          },
                          child: const Text(
                            "Update",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                                color: Colors.white),
                          ),
                        ),
                      )
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
  Future<void> _showfluttertoast({required String msg}) async {
    showToast(
      msg,
      context: context,
      textAlign: TextAlign.center,
      textStyle: const TextStyle(
        fontSize: 14.0,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      fullWidth: true,
      animation: StyledToastAnimation.slideFromBottom,
      reverseAnimation: StyledToastAnimation.slideToBottom,
      position: StyledToastPosition.bottom,
      startOffset: const Offset(0, 3.0),
      backgroundColor: Colors.black.withOpacity(0.7),
      borderRadius: BorderRadius.circular(5),
      reverseEndOffset: const Offset(0, 3.0),
      duration: const Duration(seconds: 5),
      // Animation duration   animDuration * 2 <= duration
      animDuration: const Duration(seconds: 1),
      curve: Curves.fastOutSlowIn,
      reverseCurve: Curves.easeInOut,
    );
  }


  Changepassword_Api() async {
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

      final body = {
        "user_id": user_id,
        "password": Newpassword.text.toString(),
      };
      print(body);
      print("Api ${Changepassword_APi}");

      var response = await http.post(Uri.parse(Changepassword_APi),
          body: body, headers: Header);
      print(response);

      if (response.statusCode == 200) {
        var decode = jsonDecode(response.body);
        print(" Decod  ${decode}");
        // print(user_id);
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const MyProfile_Screen()));

        // SharedPreferences sharedPreferences =
        //       await SharedPreferences.getInstance();
        //       sharedPreferences.setString('uid', decode['data']['uid'].toString());

        // currentPage = 0;
        // MyAds_APIcall(false);

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
