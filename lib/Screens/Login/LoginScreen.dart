// import 'dart:convert';
//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_styled_toast/flutter_styled_toast.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// import '../../Api/api.dart';
// import '../../ColorConstant/ColorConstant.dart';
// import '../BottomNavigationBarScreen/BottomNavigationScreen.dart';
// import '../Drawer/DrawerScreen.dart';
// import 'ForgetPassword.dart';
// import 'Sellerregistration.dart';
// import 'UserReg.dart';
// import 'package:http/http.dart' as http;
//
// class LoginScreen extends StatefulWidget {
//   const LoginScreen({Key? key}) : super(key: key);
//
//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }
//
// class _LoginScreenState extends State<LoginScreen> {
//   bool isReload = false;
//   var scaffoldKey = GlobalKey<ScaffoldState>();
//   bool selected = false;
//   bool isobscure = false;
//   bool ispressed = true;
//   TextEditingController password = TextEditingController();
//   TextEditingController username = TextEditingController();
//
//   final _formKey = GlobalKey<FormState>();
//
//   @override
//   Widget build(BuildContext context) {
//     double width = MediaQuery.of(context).size.width;
//     double height = MediaQuery.of(context).size.height;
//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: CupertinoColors.systemGrey5,
//         key: scaffoldKey,
//         body: (isReload == false)
//             ? GestureDetector(
//                 onTap: () {
//                   FocusScope.of(context).requestFocus();
//                   FocusScope.of(context).unfocus();
//                 },
//                 child: Form(
//                   key: _formKey,
//                   child: SingleChildScrollView(
//                     child: Container(
//                       padding: const EdgeInsets.all(15),
//                       height: height,
//                       child: Column(
//                         children: [
//                           Align(
//                             alignment: Alignment.topLeft,
//                             child: Container(
//                               height: height * 0.05,
//                               decoration: const BoxDecoration(
//                                 shape: BoxShape.circle,
//                                 color: maincolor,
//                               ),
//                               child: IconButton(
//                                 onPressed: () {
//                                   scaffoldKey.currentState!.openDrawer();
//                                 },
//                                 icon: const Icon(
//                                   Icons.menu,
//                                   color: Colors.white,
//                                   size: 25,
//                                 ),
//                               ),
//                             ),
//                           ),
//                           const SizedBox(
//                             height: 5,
//                           ),
//                           Container(
//                             height: height * 0.093,
//                             child: Image.asset("assets/images/logo2.png"),
//                           ),
//                           const SizedBox(
//                             height: 25,
//                           ),
//                           Container(
//                             height: height * 0.05,
//                             child: const Text(
//                               "Login",
//                               style: TextStyle(
//                                 fontSize: 20,
//                                 fontWeight: FontWeight.w800,
//                                 // fontFamily: "assets/fonts/Raleway-SemiBold.ttf"
//                               ),
//                             ),
//                           ),
//                           // const SizedBox(
//                           //   height: 10,
//                           // ),
//                           Container(
//                             height: height * 0.05,
//                             child: const Text(
//                               "Login into your reapp account",
//                               style: TextStyle(
//                                 fontSize: 17,
//                                 fontWeight: FontWeight.w500,
//                                 // fontFamily: "assets/fonts/Raleway-SemiBold.ttf"
//                               ),
//                             ),
//                           ),
//                           const SizedBox(
//                             height: 10,
//                           ),
//                           Container(
//                             // height: height * 0.08,
//                             width: width,
//                             child: Card(
//                               elevation: 0,
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(7),
//                               ),
//                               color: Colors.white,
//                               child: TextFormField(
//                                 controller: username,
//                                 //autofocus: true,
//                                 // onChanged: (val) {
//                                 //   WidgetsBinding
//                                 //       .instance.focusManager.primaryFocus
//                                 //       ?.unfocus();
//                                 // },
//                                 decoration: InputDecoration(
//                                   alignLabelWithHint: true,
//                                   fillColor: Colors.white,
//                                   filled: true,
//                                   //contentPadding: const EdgeInsets.all(5.0),
//                                   labelText: '   Username',
//                                   //hintText: 'widget.user.name',
//                                   labelStyle: const TextStyle(
//                                     color: maincolor,
//                                     fontSize: 17,
//                                     fontWeight: FontWeight.w500,
//                                   ),
//                                   border: OutlineInputBorder(
//                                     borderRadius: BorderRadius.circular(7),
//                                     borderSide:
//                                         const BorderSide(color: Colors.grey),
//                                   ),
//                                   focusedBorder: OutlineInputBorder(
//                                     borderRadius: BorderRadius.circular(7),
//                                     borderSide:
//                                         const BorderSide(color: Colors.grey),
//                                   ),
//                                   enabledBorder: OutlineInputBorder(
//                                     borderRadius: BorderRadius.circular(7),
//                                     borderSide:
//                                         const BorderSide(color: Colors.grey),
//                                   ),
//                                 ),
//                                 // validator: (value) {
//                                 //   if (value == null || value.isEmpty) {
//                                 //     return 'Please enter email id';
//                                 //   } else if (!value.isValidname()) {
//                                 //     return "Please enter valid email id";
//                                 //   }
//                                 //   return null;
//                                 // },
//                               ),
//                             ),
//                           ),
//                           const SizedBox(
//                             height: 15,
//                           ),
//                           Container(
//                             //height: height * 0.08,
//                             width: width,
//                             child: Card(
//                               elevation: 0,
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(7),
//                               ),
//                               color: Colors.white,
//                               child: TextFormField(
//                                 obscureText: isobscure,
//                                 controller: password,
//                                 decoration: InputDecoration(
//                                   alignLabelWithHint: true,
//                                   fillColor: Colors.white,
//                                   filled: true,
//                                   floatingLabelAlignment:
//                                       FloatingLabelAlignment.start,
//                                   floatingLabelBehavior:
//                                       FloatingLabelBehavior.auto,
//                                   labelText: '   Password',
//                                   //hintText: 'widget.user.name',
//                                   labelStyle: const TextStyle(
//                                     color: maincolor,
//                                     fontSize: 17,
//                                     fontWeight: FontWeight.w500,
//                                   ),
//                                   suffixIcon: IconButton(
//                                     icon: Icon(
//                                       (isobscure == false)
//                                           ? Icons.visibility_outlined
//                                           : Icons.visibility_off_outlined,
//                                       color: Colors.grey,
//                                       size: 20,
//                                     ),
//                                     onPressed: () {
//                                       setState(() {
//                                         isobscure = !isobscure;
//                                       });
//                                     },
//                                   ),
//                                   border: OutlineInputBorder(
//                                     borderRadius: BorderRadius.circular(7),
//                                     borderSide:
//                                         const BorderSide(color: Colors.grey),
//                                   ),
//                                   focusedBorder: OutlineInputBorder(
//                                     borderRadius: BorderRadius.circular(7),
//                                     borderSide:
//                                         const BorderSide(color: Colors.grey),
//                                   ),
//                                   enabledBorder: OutlineInputBorder(
//                                     borderRadius: BorderRadius.circular(7),
//                                     borderSide:
//                                         const BorderSide(color: Colors.grey),
//                                   ),
//                                 ),
//                                 // validator: (value) {
//                                 //   if (value == null || value.isEmpty) {
//                                 //     return 'Please enter email id';
//                                 //   } else if (!value.isValidPassword()) {
//                                 //     return "Please enter valid email id";
//                                 //   }
//                                 //   return null;
//                                 // },
//                               ),
//                             ),
//                           ),
//                           const SizedBox(
//                             height: 15,
//                           ),
//                           Container(
//                             width: width * 0.9,
//                             //color: Colors.blueAccent,
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               crossAxisAlignment: CrossAxisAlignment.center,
//                               children: [
//                                 Container(
//                                   width: width * 0.3,
//                                   //color: Colors.red,
//                                   child: Row(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceBetween,
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.center,
//                                     children: [
//                                       (selected == true)
//                                           ? GestureDetector(
//                                               onTap: () {
//                                                 setState(() {
//                                                   selected = !selected;
//                                                 });
//                                               },
//                                               child: Container(
//                                                 height: 15,
//                                                 width: 15,
//                                                 child: Image.asset(
//                                                   "assets/images/checked@3x.png",
//                                                 ),
//                                               ),
//                                             )
//                                           : GestureDetector(
//                                               onTap: () {
//                                                 setState(() {
//                                                   selected = !selected;
//                                                 });
//                                               },
//                                               child: Container(
//                                                 height: 15,
//                                                 width: 15,
//                                                 child: Image.asset(
//                                                   "assets/images/checkbox@3x.png",
//                                                 ),
//                                               ),
//                                             ),
//                                       Container(
//                                         height: 20,
//                                         alignment: Alignment.centerRight,
//                                         child: const Text(
//                                           "Remember me",
//                                           style: TextStyle(
//                                             color: Colors.black,
//                                             fontSize: 13,
//                                             fontWeight: FontWeight.w400,
//                                           ),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                                 GestureDetector(
//                                   onTap: () {
//                                     setState(() {
//                                       ispressed = !ispressed;
//                                     });
//                                     Navigator.push(
//                                       context,
//                                       MaterialPageRoute(
//                                         builder: (context) => const Forgetpwd(),
//                                       ),
//                                     );
//                                   },
//                                   child: Container(
//                                     height: 20,
//                                     child: const Text(
//                                       "Forget your password ?",
//                                       style: TextStyle(
//                                         color: Colors.black,
//                                         fontSize: 13,
//                                         fontWeight: FontWeight.w500,
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           const SizedBox(
//                             height: 20,
//                           ),
//                           Container(
//                             height: height * 0.065,
//                             width: width,
//                             child: RaisedButton(
//                               elevation: 0,
//                               color: maincolor,
//                               onPressed: () {
//                                 LoginApi();
//
//                                 if (password.text.trim().isEmpty) {
//                                   print(password.text);
//                                   _showfluttertoast(
//                                       msg: 'Please Enter Password');
//                                 } else if (password.text.trim().length < 10) {
//                                   _showfluttertoast(msg: 'Invalid Password');
//                                 } else {
//                                   if (_formKey.currentState!.validate()) {
//                                     // Navigator.of(context).push(
//                                     //   MaterialPageRoute(
//                                     //     builder: (context) =>
//                                     //         const BottomNavigationScreen(0),
//                                     //   ),
//                                     // );
//                                   }
//                                 }
//                               },
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(8),
//                               ),
//                               child: const Text(
//                                 'Login Now',
//                                 style: TextStyle(
//                                   fontSize: 18,
//                                   color: Colors.white,
//                                   fontWeight: FontWeight.w600,
//                                 ),
//                               ),
//                             ),
//                           ),
//                           const SizedBox(
//                             height: 15,
//                           ),
//                           Container(
//                             height: height * 0.065,
//                             width: width * 0.75,
//                             child: RaisedButton(
//                               elevation: 0,
//                               color: drawericon,
//                               onPressed: () {
//                                 Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                     builder: (context) => const SellerReg(),
//                                   ),
//                                 );
//                               },
//                               shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(50)),
//                               child: const Text(
//                                 'Seller Registration',
//                                 style: TextStyle(
//                                     fontSize: 18,
//                                     color: Colors.white,
//                                     fontWeight: FontWeight.w600),
//                               ),
//                             ),
//                           ),
//                           const SizedBox(
//                             height: 15,
//                           ),
//                           Container(
//                             height: height * 0.065,
//                             width: width * 0.75,
//                             child: RaisedButton(
//                               elevation: 0,
//                               color: Userreg,
//                               onPressed: () {
//                                 Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                     builder: (context) => const UserReg(),
//                                   ),
//                                 );
//                               },
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(50),
//                               ),
//                               child: const Text(
//                                 'User Registration',
//                                 style: TextStyle(
//                                     fontSize: 18,
//                                     color: Colors.white,
//                                     fontWeight: FontWeight.w600),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               )
//             : const Center(
//                 child: CircularProgressIndicator(
//                   color: maincolor,
//                 ),
//               ),
//         drawer: const DrawerScreen(),
//       ),
//     );
//   }
//
//   Future<void> _showfluttertoast({required String msg}) async {
//     showToast(
//       msg,
//       context: context,
//       textAlign: TextAlign.center,
//       textStyle: const TextStyle(
//         fontSize: 16.0,
//         fontWeight: FontWeight.bold,
//         color: Colors.white,
//       ),
//       fullWidth: false,
//       animation: StyledToastAnimation.slideFromBottom,
//       reverseAnimation: StyledToastAnimation.slideToBottom,
//       position: StyledToastPosition.bottom,
//       startOffset: const Offset(0, 3.0),
//       backgroundColor: Colors.black.withOpacity(0.7),
//       borderRadius: BorderRadius.circular(5),
//       reverseEndOffset: const Offset(0, 3.0),
//       duration: const Duration(seconds: 5),
//       // Animation duration   animDuration * 2 <= duration
//       animDuration: const Duration(seconds: 1),
//       curve: Curves.fastOutSlowIn,
//       reverseCurve: Curves.easeInOut,
//     );
//   }
//
//   LoginApi() async {
//     setState(() {
//       isReload = true;
//     });
//     try {
//       final body = {
//         "username": username.text.toString(),
//         "password": password.text.toString(),
//       };
//
//       var response = await http.post(Uri.parse(Login_Api), body: body);
//
//       if (response.statusCode == 200) {
//         var decode = jsonDecode(response.body);
//         // print("${ decode["data"]["uid"].toString()}");
//
//         // print("registration$decode");
//
//         if (decode["success"] == true) {
//           //  print("registration$decode");
//
//           //  MakePaymentAPIcall();
//
//           SharedPreferences sharedPreferences =
//               await SharedPreferences.getInstance();
//           sharedPreferences.setString('id', decode['data'][0]['id'].toString());
//           sharedPreferences.setString(
//               "username", decode["data"]["uid"].toString());
//           sharedPreferences.setString(
//               "password", decode["data"]["Name"].toString());
//
//           Navigator.of(context).push(MaterialPageRoute(
//             builder: (context) {
//               //return const BottomNavigationScreen(0);
//               return BottomNavigationScreen(0);
//             },
//           ));
//         } else {
//           print("1");
//           String errorMsg = json.decode(response.body)["message"].toString();
//           print("2");
//           if (json.decode(response.body)["data"] != null) {
//             print("3");
//             var errorList = json.decode(response.body)["data"];
//             Navigator.of(context).push(MaterialPageRoute(
//               builder: (context) {
//                 //return const BottomNavigationScreen(0);
//                 return BottomNavigationScreen(0);
//               },
//             ));
//
//             // for (int i = 0; i < errorList.length; i++) {
//             //   Map errorMap = errorList[i];
//             //   for (String k in errorMap.keys) {
//             //     print(errorMap[k]);
//             //     errorMsg = errorMap[k][0] ??
//             //         json.decode(response.body)["message"].toString();
//             //     break;
//             //   }
//             // }
//           }
//           // final snackBar = SnackBar(
//           //   content: Text(errorMsg),
//           //   action: SnackBarAction(
//           //     label: '',
//           //     onPressed: () {},
//           //   ),
//           // );
//
//           // ScaffoldMessenger.of(context).showSnackBar(snackBar);
//         }
//
//         setState(() {
//           isReload = false;
//         });
//       } else {
//         print("Error" + response.statusCode.toString());
//         print("Error" + response.body.toString());
//       }
//     } catch (e) {
//       setState(() {
//         isReload = false;
//       });
//       print("Exception in Today Attendance=>" + e.toString());
//       throw e;
//     }
//   }
// }
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Api/api.dart';
import '../../ColorConstant/ColorConstant.dart';
import '../BottomNavigationBarScreen/BottomNavigationScreen.dart';
import '../Drawer/DrawerScreen.dart';
import 'ForgetPassword.dart';
import 'Sellerregistration.dart';
import 'UserReg.dart';
import 'package:http/http.dart' as http;

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isReload = false;
  var scaffoldKey = GlobalKey<ScaffoldState>();
  bool selected = false;
  bool isobscure = false;
  bool ispressed = true;
  TextEditingController password = TextEditingController();
  TextEditingController username = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        backgroundColor: CupertinoColors.systemGrey5,
        key: scaffoldKey,
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
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: maincolor,
                        ),
                        child: IconButton(
                          onPressed: () {
                            scaffoldKey.currentState!.openDrawer();
                          },
                          icon: const Icon(
                            Icons.menu,
                            color: Colors.white,
                            size: 25,
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
                        "Login",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                          // fontFamily: "assets/fonts/Raleway-SemiBold.ttf"
                        ),
                      ),
                    ),
                    // const SizedBox(
                    //   height: 10,
                    // ),
                    Container(
                      height: height * 0.05,
                      child: const Text(
                        "Login into your reapp account",
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                          // fontFamily: "assets/fonts/Raleway-SemiBold.ttf"
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      // height: height * 0.08,
                      width: width,
                      child: Card(
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7),
                        ),
                        color: Colors.white,
                        child: TextFormField(
                          controller: username,
                          //autofocus: true,
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
                            labelText: '   Username',
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
                              borderSide:
                              const BorderSide(color: Colors.grey),
                            ),
                          ),
                          // validator: (value) {
                          //   if (value == null || value.isEmpty) {
                          //     return 'Please enter email id';
                          //   } else if (!value.isValidname()) {
                          //     return "Please enter valid email id";
                          //   }
                          //   return null;
                          // },
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                      //height: height * 0.08,
                      width: width,
                      child: Card(
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7),
                        ),
                        color: Colors.white,
                        child: TextFormField(
                          obscureText: isobscure,
                          controller: password,
                          decoration: InputDecoration(
                            alignLabelWithHint: true,
                            fillColor: Colors.white,
                            filled: true,
                            floatingLabelAlignment:
                            FloatingLabelAlignment.start,
                            floatingLabelBehavior:
                            FloatingLabelBehavior.auto,
                            labelText: '   Password',
                            //hintText: 'widget.user.name',
                            labelStyle: const TextStyle(
                              color: maincolor,
                              fontSize: 17,
                              fontWeight: FontWeight.w500,
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
                              borderSide:
                              const BorderSide(color: Colors.grey),
                            ),
                          ),
                          // validator: (value) {
                          //   if (value == null || value.isEmpty) {
                          //     return 'Please enter email id';
                          //   } else if (!value.isValidPassword()) {
                          //     return "Please enter valid email id";
                          //   }
                          //   return null;
                          // },
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                      width: width * 0.9,
                      //color: Colors.blueAccent,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: width * 0.3,
                            //color: Colors.red,
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              crossAxisAlignment:
                              CrossAxisAlignment.center,
                              children: [
                                (selected == true)
                                    ? GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selected = !selected;
                                    });
                                  },
                                  child: Container(
                                    height: 15,
                                    width: 15,
                                    child: Image.asset(
                                      "assets/images/checked@3x.png",
                                    ),
                                  ),
                                )
                                    : GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selected = !selected;
                                    });
                                  },
                                  child: Container(
                                    height: 15,
                                    width: 15,
                                    child: Image.asset(
                                      "assets/images/checkbox@3x.png",
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 20,
                                  alignment: Alignment.centerRight,
                                  child: const Text(
                                    "Remember me",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                ispressed = !ispressed;
                              });
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const Forgetpwd(),
                                ),
                              );
                            },
                            child: Container(
                              height: 20,
                              child: const Text(
                                "Forget your password ?",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: height * 0.065,
                      width: width,
                      child: RaisedButton(
                        elevation: 0,
                        color: maincolor,
                        onPressed: () {
                          LoginApi();


                          if (password.text.trim().isEmpty) {
                            print(password.text);
                            _showfluttertoast(
                                msg: 'Please Enter Password');
                          } else if (password.text.trim().length < 10) {
                            _showfluttertoast(msg: 'Invalid Password');
                          } else {
                            if (_formKey.currentState!.validate()) {
                              // Navigator.of(context).push(
                              //   MaterialPageRoute(
                              //     builder: (context) =>
                              //         const BottomNavigationScreen(0),
                              //   ),
                              // );
                            }
                          }
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Text(
                          'Login Now',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                      height: height * 0.065,
                      width: width * 0.75,
                      child: RaisedButton(
                        elevation: 0,
                        color: drawericon,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SellerReg(),
                            ),
                          );
                        },
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50)),
                        child: const Text(
                          'Seller Registration',
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                      height: height * 0.065,
                      width: width * 0.75,
                      child: RaisedButton(
                        elevation: 0,
                        color: Userreg,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const UserReg(),
                            ),
                          );
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: const Text(
                          'User Registration',
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
        drawer: const DrawerScreen(),
      ),
    );
  }

  Future<void> _showfluttertoast({required String msg}) async {
    showToast(
      msg,
      context: context,
      textAlign: TextAlign.center,
      textStyle: const TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      fullWidth: false,
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

  LoginApi() async {
    setState(() {
      isReload = true;
    });
    try {
      final body = {
        "username": username.text.toString(),
        "password": password.text.toString(),
      };

      var response = await http.post(Uri.parse(Login_Api), body: body);

      if (response.statusCode == 200) {
        var decode = jsonDecode(response.body);

        SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
        sharedPreferences.setString('uid', decode['data']['uid'].toString());
        sharedPreferences.setString(
            "Name", decode["data"]["Name"].toString());
        sharedPreferences.setString(
            "Email", decode["data"]["Email"].toString());
        sharedPreferences.setString(
            "userRole", decode["data"]["userRole"].toString());
        sharedPreferences.setString(
            "token", decode["data"]["token"].toString());
        print( decode["data"]["token"].toString());
        sharedPreferences.setBool("isLoggedIn", true);


        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) {
            //return const BottomNavigationScreen(0);
            return BottomNavigationScreen(0);
          },
        ));


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
