import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Api/api.dart';
import '../../ColorConstant/ColorConstant.dart';
import 'package:http/http.dart' as http;


class Forgetpwd extends StatefulWidget {
  const Forgetpwd({Key? key}) : super(key: key);

  @override
  State<Forgetpwd> createState() => _ForgetpwdState();
}

class _ForgetpwdState extends State<Forgetpwd> {
  bool isReload = false;
  TextEditingController email = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        backgroundColor: CupertinoColors.systemGrey5,
        body: (isReload == false)
            ? GestureDetector(
                onTap: () {
                  FocusScope.of(context).requestFocus();
                  FocusScope.of(context).unfocus();
                },
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Container(
                      padding: const EdgeInsets.all(15),
                      height: height,
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: Container(
                              height: height * 0.05,
                              child: IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: const Icon(
                                  Icons.arrow_back_outlined,
                                  color: maincolor,
                                  size: 30,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Container(
                            height: height * 0.093,
                            child: Image.asset("assets/images/logo2.png"),
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          Container(
                            height: height * 0.05,
                            child: const Text(
                              "Forget Password",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                // fontFamily: "assets/fonts/Raleway-SemiBold.ttf"
                              ),
                            ),
                          ),
                          Container(
                            height: height * 0.08,
                            width: width,
                            child: Card(
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(7),
                              ),
                              color: Colors.white,
                              child: TextFormField(
                                controller: email,
                                autofocus: true,
                                // onChanged: (val) {
                                //   WidgetsBinding
                                //       .instance.focusManager.primaryFocus
                                //       ?.unfocus();
                                // },
                                decoration: InputDecoration(
                                  alignLabelWithHint: true,
                                  fillColor: Colors.white,
                                  filled: true,
                                  //contentPadding: const EdgeInsets.all(5.0),
                                  labelText: '   Email Address',
                                  //hintText: 'widget.user.name',
                                  labelStyle: const TextStyle(
                                    color: maincolor,
                                    fontSize: 17,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(7),
                                    borderSide:
                                        const BorderSide(color: Colors.grey),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(7),
                                    borderSide:
                                        const BorderSide(color: Colors.grey),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(7),
                                    borderSide: const BorderSide(
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 18,
                          ),
                          Container(
                            height: 20,
                            padding: const EdgeInsets.only(left: 5),
                            alignment: Alignment.topLeft,
                            child: const Text(
                              "Enter your e-mail address to reset password",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Container(
                            height: height * 0.065,
                            width: width * 0.9,
                            child: RaisedButton(
                              elevation: 0,
                              color: maincolor,
                              onPressed: () {
                                // if (_formKey.currentState!.validate()) {
                                //
                                //
                                // }
                                ForgetpasswordApiCall();
                               // _showdialogbox(context);
                              },
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                              child: const Text(
                                'Submit Now',
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
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

  Future<void> _showdialogbox(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) => Container(
        height: 60,
        width: MediaQuery.of(context).size.width,
        child: AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          title: Column(
            children: [
              Container(
                height: 40,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10),
                    topLeft: Radius.circular(10),
                  ),
                  color: maincolor,
                ),
                child: const Center(
                  child: Icon(
                    Icons.warning_rounded,
                    color: Colors.white,
                    size: 23,
                  ),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              const Text(
                "Forget Password",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w900,
                  color: Colors.black,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Please enter valid e-mail address",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  //fontWeight: FontWeight.w300,
                  color: Colors.black,
                ),
              ),
              const SizedBox(
                height: 3,
              ),
              const Divider(
                thickness: 1,
                color: Colors.grey,
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  "Close",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  ForgetpasswordApiCall() async {
    setState(() {
      isReload = true;
    });
    try {
      final body = {

        "email": email.text.toString(),

      };


      var response = await http.post(Uri.parse(Forgotpassword), body: body);

      if (response.statusCode == 200) {

        var decode = jsonDecode(response.body);

        print("Sucess${decode}");


        _showdialogbox;

        // if (decode["success"] == true) {
        //
        //
        //   // print("registration$decode");
        //
        //   //  MakePaymentAPIcall();
        //
        //   // SharedPreferences sharedPreferences =
        //   // await SharedPreferences.getInstance();
        //   // sharedPreferences.setString('id', decode['data'][0]['id'].toString());
        //   // sharedPreferences.setString(
        //   //     "name", decode["data"][0]["name"].toString());
        //   // sharedPreferences.setString(
        //   //     "email", decode["data"][0]["email"].toString());
        //   // sharedPreferences.setString(
        //   //     "mobile", decode["data"][0]["mobile"].toString());
        //   // sharedPreferences.setString(
        //   //     "profile_image", decode["data"][0]["profile_image"].toString());
        //   // sharedPreferences.setString(
        //   //     "gender", decode["data"][0]["gender"].toString());
        //   // sharedPreferences.setString(
        //   //     "token", decode["data"][0]["token"].toString());
        //   //
        //   // Navigator.of(context).push(MaterialPageRoute(
        //   //   builder: (context) {
        //   //     return SubmitScreen();
        //   //   },
        //   // ));
        //
        // } else {
        //   // print("1");
        //   // String errorMsg = json.decode(response.body)["message"].toString();
        //   // print("2");
        //   // // if (json.decode(response.body)["data"]){
        //   // //   print("3");
        //   // //   var errorList = json.decode(response.body)["data"];
        //   // //
        //   // //   for (int i = 0; i < errorList.length; i++) {
        //   // //     Map errorMap = errorList[i];
        //   // //     for(String k in errorMap.keys){
        //   // //       print(errorMap[k]);
        //   // //       errorMsg = errorMap[k][0] ?? json.decode(response.body)["message"].toString();
        //   // //       break;
        //   // //     }
        //   // //   }
        //   // // }
        //   // final snackBar = SnackBar(
        //   //   content: Text(errorMsg),
        //   //   action: SnackBarAction(
        //   //     label: '',
        //   //     onPressed: () {},
        //   //   ),
        //   // );
        //   //
        //   // ScaffoldMessenger.of(context).showSnackBar(snackBar);
        // }

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
