// // import 'package:flutter/cupertino.dart';
// // import 'package:flutter/material.dart';
// // import '../../ColorConstant/ColorConstant.dart';
// // import '../CategoriesScreen/CategoriesScreen.dart';
// // import '../Drawer/DrawerScreen.dart';
// // import '../HomeScreen/HomeScreen.dart';
// // import '../Search/SearchScreen.dart';
// // import '../Upload/Upload Screen.dart';
// //
// // class BottomNavigationScreen extends StatefulWidget {
// //   final int _selectedIndex;
// //
// //   const BottomNavigationScreen(this._selectedIndex, {super.key});
// //
// //   @override
// //   _BottomNavigationScreenState createState() =>
// //       _BottomNavigationScreenState(_selectedIndex);
// // }
// //
// // class _BottomNavigationScreenState extends State<BottomNavigationScreen>
// //     with SingleTickerProviderStateMixin {
// //   int _selectedIndex = 1;
// //   AnimationController? _controller;
// //
// //   // ignore: non_constant_identifier_names
// //   DateTime pre_backpress = DateTime.now();
// //
// //   final List<Widget> _widgetOptions = <Widget>[
// //     // LoginScreen(),
// //     const HomeScreen(),
// //     const SearchScreen(),
// //     // CategoriesScreen(),
// //     Makenewad_Screen(),
// //     const DrawerScreen(),
// //   ];
// //
// //   List<IconData> BottomList = [
// //     CupertinoIcons.house_fill,
// //     CupertinoIcons.search,
// //     CupertinoIcons.book_fill,
// //     Icons.more_horiz_rounded,
// //   ];
// //   List<dynamic> Bottomname = [
// //     "Home",
// //     "Search",
// //     "Categories",
// //     "More",
// //   ];
// //
// //   _BottomNavigationScreenState(this._selectedIndex);
// //
// //   bool select = false;
// //
// //   bool select1 = false;
// //
// //   bool select2 = false;
// //
// //   bool select3 = false;
// //
// //   bool select4 = false;
// //
// //   @override
// //   void initState() {
// //     _controller = AnimationController(vsync: this);
// //     super.initState();
// //   }
// //
// //   @override
// //   void dispose() {
// //     _controller!.dispose();
// //     super.dispose();
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     DateTime timeBackPressed = DateTime.now();
// //     double height = MediaQuery.of(context).size.height;
// //     double width = MediaQuery.of(context).size.width;
// //     return WillPopScope(
// //       onWillPop: () async {
// //         final timegap = DateTime.now().difference(pre_backpress);
// //         final cantExit = timegap >= const Duration(seconds: 2);
// //         pre_backpress = DateTime.now();
// //         if (cantExit) {
// //           //show snackbar
// //           const snack = SnackBar(
// //             content: Text('Press Back button again to Exit'),
// //             duration: Duration(seconds: 2),
// //           );
// //           ScaffoldMessenger.of(context).showSnackBar(snack);
// //           return false;
// //         } else {
// //           return true;
// //         }
// //       },
// //       child: Scaffold(
// //         backgroundColor: CupertinoColors.systemGrey5,
// //         extendBody: true,
// //         bottomNavigationBar: Container(
// //           color: Colors.white,
// //           height: height * 0.06,
// //           padding: const EdgeInsets.only(bottom: 0.0),
// //           alignment: Alignment.bottomCenter,
// //           child: Stack(
// //             children: [
// //               Positioned(
// //                 left: 0,
// //                 right: 0,
// //                 bottom: 0,
// //                 height: 0,
// //                 child: Container(
// //                   color: Colors.red,
// //                 ),
// //               ),
// //               Positioned(
// //                 left: 0,
// //                 right: 0,
// //                 top: 0,
// //                 bottom: 0,
// //                 child: Container(
// //                   color: Colors.transparent,
// //                   child: GridView.builder(
// //                     physics: const NeverScrollableScrollPhysics(),
// //                     gridDelegate:
// //                         const SliverGridDelegateWithFixedCrossAxisCount(
// //                       crossAxisSpacing: 5,
// //                       mainAxisSpacing: 5,
// //                       childAspectRatio: 1 / 0.60,
// //                       crossAxisCount: 4,
// //                     ),
// //                     shrinkWrap: true,
// //                     itemCount: _widgetOptions.length,
// //                     itemBuilder: (BuildContext context, int index) {
// //                       return GestureDetector(
// //                         onTap: () {
// //                           setState(() {
// //                             _selectedIndex = index;
// //                           });
// //                         },
// //                         child: Column(
// //                           children: [
// //                             Container(
// //                               alignment: Alignment.bottomCenter,
// //                               child: Container(
// //                                 child: Icon(
// //                                   BottomList[index],
// //                                   size: 25,
// //                                   color: (_selectedIndex == index)
// //                                       ? maincolor
// //                                       : Colors.black54,
// //                                 ),
// //                               ),
// //                             ),
// //                             const SizedBox(
// //                               height: 3,
// //                             ),
// //                             Container(
// //                               height: 15,
// //                               alignment: Alignment.bottomCenter,
// //                               child: Container(
// //                                 child: Text(
// //                                   Bottomname[index],
// //                                   style: TextStyle(
// //                                     color: (_selectedIndex == index)
// //                                         ? maincolor
// //                                         : Colors.black54,
// //                                     fontWeight: FontWeight.w500,
// //                                     fontSize: 13,
// //                                   ),
// //                                 ),
// //                               ),
// //                             ),
// //                           ],
// //                         ),
// //                       );
// //                     },
// //                   ),
// //                 ),
// //               ),
// //             ],
// //           ),
// //         ),
// //         body: _widgetOptions.elementAt(_selectedIndex),
// //       ),
// //     );
// //   }
// // }
// import 'dart:convert';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import '../../Api/api.dart';
// import '../../ColorConstant/ColorConstant.dart';
// import '../CategoriesScreen/CategoriesScreen.dart';
// import '../Drawer/DrawerScreen.dart';
// import '../HomeScreen/HomeScreen.dart';
// import '../Search/SearchScreen.dart';
// import 'package:http/http.dart' as http;
// import '../Upload/Make New Ad Screen.dart';
//
//
// class BottomNavigationScreen extends StatefulWidget {
//   final int _selectedIndex;
//
//   const BottomNavigationScreen(this._selectedIndex, {super.key});
//
//   @override
//   _BottomNavigationScreenState createState() =>
//       _BottomNavigationScreenState(_selectedIndex);
// }
//
// class _BottomNavigationScreenState extends State<BottomNavigationScreen>
//     with SingleTickerProviderStateMixin {
//   int _selectedIndex = 1;
//   AnimationController? _controller;
//
//   // ignore: non_constant_identifier_names
//   DateTime pre_backpress = DateTime.now();
//   String userStatus = "";
//   String profilename = "";
//
//
//   bool? isReload;
//
//
//
//   final List<Widget> _widgetOptions = <Widget>[
//     // LoginScreen(),
//     const HomeScreen(),
//     const SearchScreen(),
//      CategoriesScreen(),
//     const DrawerScreen(),
//   ];
//
//   List<IconData> BottomList = [
//     CupertinoIcons.house_fill,
//     CupertinoIcons.search,
//     CupertinoIcons.book_fill,
//     Icons.more_horiz_rounded,
//   ];
//   List<dynamic> Bottomname = [
//     "Home",
//     "Search",
//     "Categories",
//     "More",
//   ];
//
//   final List<Widget> _AuthorwidgetOptions = <Widget>[
//     // LoginScreen(),
//     const HomeScreen(),
//     const SearchScreen(),
//      Makenewad_Screen(),
//     const DrawerScreen(),
//   ];
//
//   List<dynamic> AuthorBottomList = [
//     FontAwesomeIcons.home,
//     FontAwesomeIcons.search,
//     FontAwesomeIcons.upload,
//     Icons.more_horiz_rounded,
//   ];
//   List<dynamic> AuthorBottomname = [
//     "Home",
//     "Search",
//     "+ upload",
//     "More",
//   ];
//
//   _BottomNavigationScreenState(this._selectedIndex);
//
//   bool select = false;
//
//   bool select1 = false;
//
//   bool select2 = false;
//
//   bool select3 = false;
//
//   bool select4 = false;
//
//   @override
//   void initState() {
//     _controller = AnimationController(vsync: this);
//     super.initState();
//     getProfilAPIcall();
//
//   }
//
//   @override
//   void dispose() {
//     _controller!.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     DateTime timeBackPressed = DateTime.now();
//     double height = MediaQuery.of(context).size.height;
//     double width = MediaQuery.of(context).size.width;
//     return WillPopScope(
//       onWillPop: () async {
//         final timegap = DateTime.now().difference(pre_backpress);
//         final cantExit = timegap >= const Duration(seconds: 2);
//         pre_backpress = DateTime.now();
//         if (cantExit) {
//           //show snackbar
//           const snack = SnackBar(
//             content: Text('Press Back button again to Exit'),
//             duration: Duration(seconds: 2),
//           );
//           ScaffoldMessenger.of(context).showSnackBar(snack);
//           return false;
//         } else {
//           return true;
//         }
//       },
//       child: Scaffold(
//         backgroundColor: CupertinoColors.systemGrey5,
//         extendBody: true,
//         bottomNavigationBar:  (userStatus == "author") ? Container(
//           color: Colors.white,
//           height: height * 0.06,
//           padding: const EdgeInsets.only(bottom: 0.0),
//           alignment: Alignment.bottomCenter,
//           child: Stack(
//             children: [
//               Positioned(
//                 left: 0,
//                 right: 0,
//                 bottom: 0,
//                 height: 0,
//                 child: Container(
//                   color: Colors.red,
//                 ),
//               ),
//               Positioned(
//                 left: 0,
//                 right: 0,
//                 top: 0,
//                 bottom: 0,
//                 child: Container(
//                   color: Colors.transparent,
//                   child: GridView.builder(
//                     physics: const NeverScrollableScrollPhysics(),
//                     gridDelegate:
//                     const SliverGridDelegateWithFixedCrossAxisCount(
//                       crossAxisSpacing: 5,
//                       mainAxisSpacing: 5,
//                       childAspectRatio: 1 / 0.60,
//                       crossAxisCount: 4,
//                     ),
//                     shrinkWrap: true,
//                     itemCount: _AuthorwidgetOptions.length,
//                     itemBuilder: (BuildContext context, int index) {
//                       return GestureDetector(
//                         onTap: () {
//                           setState(() {
//                             _selectedIndex = index;
//                           });
//                         },
//                         child: Column(
//                           children: [
//                             Container(
//                               alignment: Alignment.bottomCenter,
//                               child: Container(
//                                 child: Icon(
//                                   AuthorBottomList[index],
//                                   size: 25,
//                                   color: (_selectedIndex == index)
//                                       ? maincolor
//                                       : Colors.black54,
//                                 ),
//                               ),
//                             ),
//                             const SizedBox(
//                               height: 3,
//                             ),
//                             Container(
//                               height: 15,
//                               alignment: Alignment.bottomCenter,
//                               child: Container(
//                                 child: Text(
//                                   AuthorBottomname[index],
//                                   style: TextStyle(
//                                     color: (_selectedIndex == index)
//                                         ? maincolor
//                                         : Colors.black54,
//                                     fontWeight: FontWeight.w500,
//                                     fontSize: 13,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ) : Container(
//           color: Colors.white,
//           height: height * 0.06,
//           padding: const EdgeInsets.only(bottom: 0.0),
//           alignment: Alignment.bottomCenter,
//           child: Stack(
//             children: [
//               Positioned(
//                 left: 0,
//                 right: 0,
//                 bottom: 0,
//                 height: 0,
//                 child: Container(
//                   color: Colors.red,
//                 ),
//               ),
//               Positioned(
//                 left: 0,
//                 right: 0,
//                 top: 0,
//                 bottom: 0,
//                 child: Container(
//                   color: Colors.transparent,
//                   child: GridView.builder(
//                     physics: const NeverScrollableScrollPhysics(),
//                     gridDelegate:
//                     const SliverGridDelegateWithFixedCrossAxisCount(
//                       crossAxisSpacing: 5,
//                       mainAxisSpacing: 5,
//                       childAspectRatio: 1 / 0.60,
//                       crossAxisCount: 4,
//                     ),
//                     shrinkWrap: true,
//                     itemCount: _widgetOptions.length,
//                     itemBuilder: (BuildContext context, int index) {
//                       return GestureDetector(
//                         onTap: () {
//                           setState(() {
//                             _selectedIndex = index;
//                           });
//                         },
//                         child: Column(
//                           children: [
//                             Container(
//                               alignment: Alignment.bottomCenter,
//                               child: Container(
//                                 child: Icon(
//                                   BottomList[index],
//                                   size: 20,
//                                   color: (_selectedIndex == index)
//                                       ? maincolor
//                                       : Colors.black54,
//                                 ),
//                               ),
//                             ),
//                             const SizedBox(
//                               height: 3,
//                             ),
//                             Container(
//                               height: 15,
//                               alignment: Alignment.bottomCenter,
//                               child: Container(
//                                 child: Text(
//                                   Bottomname[index],
//                                   style: TextStyle(
//                                     color: (_selectedIndex == index)
//                                         ? maincolor
//                                         : Colors.black54,
//                                     fontWeight: FontWeight.w500,
//                                     fontSize: 13,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//         body:  (userStatus == "author") ? _AuthorwidgetOptions.elementAt(_selectedIndex) :_widgetOptions.elementAt(_selectedIndex),
//       ),
//     );
//   }
//
//   getProfilAPIcall() async {
//     setState(() {
//       isReload = true;
//     });
//     try {
//       SharedPreferences prefs = await SharedPreferences.getInstance();
//       var token = prefs.getString("token") ?? "";
//       var user_id = prefs.getString("uid") ?? "";
//
//       final Header = {
//         "Authorization": "Bearer ${token.toString()}",
//       };
//       print ("userID ${user_id}");
//
//
//
//       //   var response = await http.post(Uri.parse(login), body: body);
//       var response = await http.get(
//         Uri.parse(getUsertProfile_Api + user_id),
//       );
//       print(getUsertProfile_Api + user_id);
//
//       if (response.statusCode == 200) {
//         var decode = jsonDecode(response.body);
//         print(decode);
//
//         userStatus = decode["data"][0]["role"];
//         profilename = decode["data"][0]["Name"];
//
//         print(userStatus);
//
//
//
//         setState(() {
//           isReload = false;
//         });
//       } else {
//         print("Error" + response.statusCode.toString());
//         print("Error" + response.body.toString());
//
//         setState(() {
//           isReload = false;
//         });
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
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Api/api.dart';
import '../../ColorConstant/ColorConstant.dart';
import '../CategoriesScreen/CategoriesScreen.dart';
import '../Drawer/DrawerScreen.dart';
import '../HomeScreen/HomeScreen.dart';
import '../Search/SearchScreen.dart';
import 'package:http/http.dart' as http;
import '../Upload/Make New Ad Screen.dart';

class BottomNavigationScreen extends StatefulWidget {
  final int _selectedIndex;

  const BottomNavigationScreen(this._selectedIndex, {super.key});

  @override
  _BottomNavigationScreenState createState() =>
      _BottomNavigationScreenState(_selectedIndex);
}

class _BottomNavigationScreenState extends State<BottomNavigationScreen>
    with SingleTickerProviderStateMixin {
  int _selectedIndex = 1;
  AnimationController? _controller;

  // ignore: non_constant_identifier_names
  DateTime pre_backpress = DateTime.now();
  String userStatus = "";
  String profilename = "";

  bool? isReload;

  final List<Widget> _widgetOptions = <Widget>[
    // LoginScreen(),
    const HomeScreen(),
    const SearchScreen(),
    CategoriesScreen(),
    const DrawerScreen(),
  ];

  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

  void _onItemTapped(int index) {
    index == 3
        ? _drawerKey.currentState?.openDrawer()
        : setState(() {
            _selectedIndex = index;
          });
  }

  // List<IconData> BottomList = [
  //   CupertinoIcons.house_fill,
  //   CupertinoIcons.search,
  //   CupertinoIcons.book_fill,
  //   Icons.more_horiz_rounded,
  // ];
  List<dynamic> BottomList = [
    "assets/images/home-solid.svg",
    "assets/images/search-solid.svg",
    "assets/images/book-open-solid.svg",
    "assets/images/ellipsis-h-solid.svg",
  ];

  List<dynamic> Bottomname = [
    "Home",
    "Search",
    "Categories",
    "More",
  ];

  final List<Widget> _AuthorwidgetOptions = <Widget>[
    // LoginScreen(),
    const HomeScreen(),
    const SearchScreen(),
    Makenewad_Screen(),
    const DrawerScreen(),
  ];

  // GlobalKey<ScaffoldState> _drawerKeylogin = GlobalKey();

  void _onItemTappedlogin(int index) {
    index == 3
        ? _drawerKey.currentState?.openDrawer()
        : setState(() {
            _selectedIndex = index;
          });
  }

  // List<dynamic> AuthorBottomList = [
  //   FontAwesomeIcons.home,
  //   FontAwesomeIcons.search,
  //   FontAwesomeIcons.upload,
  //   Icons.more_horiz_rounded,
  // ];
  List<dynamic> AuthorBottomList = [
    "assets/images/home-solid.svg",
    "assets/images/search-solid.svg",
    "assets/images/upload-solid.svg",
    "assets/images/ellipsis-h-solid.svg",
  ];

  List<dynamic> AuthorBottomname = [
    "Home",
    "Search",
    "+ upload",
    "More",
  ];

  _BottomNavigationScreenState(this._selectedIndex);

  bool select = false;

  bool select1 = false;

  bool select2 = false;

  bool select3 = false;

  bool select4 = false;

  @override
  void initState() {
    _controller = AnimationController(vsync: this);
    super.initState();
    getProfilAPIcall();
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
    _onItemTapped(3);
    // _onItemTappedlogin(3);
  }

  @override
  Widget build(BuildContext context) {
    DateTime timeBackPressed = DateTime.now();
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () async {
        final timegap = DateTime.now().difference(pre_backpress);
        final cantExit = timegap >= const Duration(seconds: 2);
        pre_backpress = DateTime.now();
        if (cantExit) {
          //show snackbar
          const snack = SnackBar(
            content: Text('Press Back button again to Exit'),
            duration: Duration(seconds: 2),
          );
          ScaffoldMessenger.of(context).showSnackBar(snack);
          return false;
        } else {
          return true;
        }
      },
      child: Scaffold(
        key: _drawerKey,
        backgroundColor: CupertinoColors.systemGrey5,
        extendBody: true,
        bottomNavigationBar: (userStatus == "author")
            ? Container(
                color: CupertinoColors.systemGrey5,
                height: height * 0.05,
                padding: const EdgeInsets.only(bottom: 0.0),
                alignment: Alignment.bottomCenter,
                child: Stack(
                  children: [
                    Positioned(
                      left: 0,
                      right: 0,
                      bottom: 0,
                      height: 0,
                      child: Container(
                        color: Colors.red,
                      ),
                    ),
                    Positioned(
                      left: 0,
                      right: 0,
                      top: 0,
                      bottom: 0,
                      child: Container(
                        color: Colors.transparent,
                        child: GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisSpacing: 5,
                            mainAxisSpacing: 5,
                            childAspectRatio: 1 / 0.60,
                            crossAxisCount: 4,
                          ),
                          shrinkWrap: true,
                          itemCount: _AuthorwidgetOptions.length,
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  _selectedIndex = index;
                                });
                              },
                              child: Column(
                                children: [
                                  Container(
                                    alignment: Alignment.bottomCenter,
                                    child: Container(
                                      height: 20,
                                      child: SvgPicture.asset(
                                        AuthorBottomList[index],
                                        // size: 17,
                                        color: (_selectedIndex == index)
                                            ? maincolor
                                            : Colors.black54,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 3,
                                  ),
                                  Container(
                                    height: 15,
                                    alignment: Alignment.bottomCenter,
                                    child: Container(
                                      child: Text(
                                        AuthorBottomname[index],
                                        style: TextStyle(
                                          color: (_selectedIndex == index)
                                              ? maincolor
                                              : Colors.black54,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 13,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              )
            : Container(
                color: CupertinoColors.systemGrey5,
                height: height * 0.06,
                padding: const EdgeInsets.only(bottom: 0.0),
                alignment: Alignment.bottomCenter,
                child: Stack(
                  children: [
                    Positioned(
                      left: 0,
                      right: 0,
                      bottom: 0,
                      height: 0,
                      child: Container(
                        color: Colors.red,
                      ),
                    ),
                    Positioned(
                      left: 0,
                      right: 0,
                      top: 0,
                      bottom: 0,
                      child: Container(
                        color: Colors.transparent,
                        child: GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisSpacing: 5,
                            mainAxisSpacing: 5,
                            childAspectRatio: 1 / 0.60,
                            crossAxisCount: 4,
                          ),
                          shrinkWrap: true,
                          itemCount: _widgetOptions.length,
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  _selectedIndex = index;
                                });
                              },
                              child: Column(
                                children: [
                                  Container(
                                    alignment: Alignment.bottomCenter,
                                    child: Container(
                                      height: 20,
                                      child: SvgPicture.asset(
                                        BottomList[index],
                                        // size: 20,
                                        color: (_selectedIndex == index)
                                            ? maincolor
                                            : Colors.black54,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 3,
                                  ),
                                  Container(
                                    height: 15,
                                    alignment: Alignment.bottomCenter,
                                    child: Container(
                                      child: Text(
                                        Bottomname[index],
                                        style: TextStyle(
                                          color: (_selectedIndex == index)
                                              ? maincolor
                                              : Colors.black54,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 13,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
        body: (userStatus == "author")
            ? _AuthorwidgetOptions.elementAt(_selectedIndex)
            : _widgetOptions.elementAt(_selectedIndex),
      ),
    );
  }

  getProfilAPIcall() async {
    setState(() {
      isReload = true;
    });
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString("token") ?? "";
      var user_id = prefs.getString("uid") ?? "";

      final Header = {
        "Authorization": "Bearer ${token.toString()}",
      };
      print("userID ${user_id}");

      //   var response = await http.post(Uri.parse(login), body: body);
      var response = await http.get(
        Uri.parse(getUsertProfile_Api + user_id),
      );
      print(getUsertProfile_Api + user_id);

      if (response.statusCode == 200) {
        var decode = jsonDecode(response.body);
        print(decode);

        userStatus = decode["data"][0]["role"];
        profilename = decode["data"][0]["Name"];

        print(userStatus);

        setState(() {
          isReload = false;
        });
      } else {
        print("Error" + response.statusCode.toString());
        print("Error" + response.body.toString());

        setState(() {
          isReload = false;
        });
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
