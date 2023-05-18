import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../ColorConstant/ColorConstant.dart';
import '../../My Ads/My Ads Screen.dart';
import '../../My Profile/My Profile Screen.dart';
import '../../Wishlist/Wishlist Screen.dart';
import '../BlogWebViewScreen/WebViewscreen.dart';
import '../BottomNavigationBarScreen/BottomNavigationScreen.dart';
import '../CategoriesScreen/CategoriesScreen.dart';
import '../Login/Contactus.dart';
import '../Login/FAQ.dart';
import '../Login/LoginScreen.dart';
import '../Login/Sellerregistration.dart';
import '../Login/UserReg.dart';
import '../Policies/About Us.dart';
import '../Policies/PrivacyPolicy.dart';
import '../Policies/T & C.dart';
import '../Upload/Make New Ad Screen.dart';

class DrawerScreen extends StatefulWidget {
  const DrawerScreen({Key? key}) : super(key: key);

  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  bool isLogin = false;
  String userStatus = "";
  String profilename = "";
  String profileEmail = "";
  String profileImage = "";


  List<IconData> menuicon = [];
  List<dynamic> menuname = [];
  List<IconData> menuiconDrawer = [
    CupertinoIcons.house_fill,
    FontAwesomeIcons.arrowRightToBracket,
    CupertinoIcons.arrow_right_to_line,
    CupertinoIcons.arrow_right_to_line,
    FontAwesomeIcons.exclamation,
    Icons.add_call,
    Icons.question_mark,
    FontAwesomeIcons.copy,
    FontAwesomeIcons.solidFileText,
    FontAwesomeIcons.shield,
  ];

  List<dynamic> menunameDrawer = [
    "Home",
    "Login",
    "Seller Registration",
    "General User Registration",
    "About us",
    "Contact us",
    "FAQ",
    "Blog",
    "Terms and Conditions",
    "Privacy Policy",
  ];
  List<IconData> Sellericon = [
    FontAwesomeIcons.edit,
    CupertinoIcons.person_fill,
    FontAwesomeIcons.volumeMute,
    FontAwesomeIcons.edit,
    Icons.favorite,
    Icons.supervised_user_circle,
    FontAwesomeIcons.exclamation,
    Icons.call,
    Icons.question_mark,
    Icons.speaker_notes,
    FontAwesomeIcons.solidFileText,
    Icons.price_change_rounded,
  ];
  List<dynamic> sellername = [
    "Home",
    "Categories",
    "New Ads",
    "My Ads",
    "My Wishlist",
    "My Profile",
    "About Us",
    "Contact Us",
    "FAQ",
    "Blog",
    "Terms and Conditions",
    "Privacy Policy",
  ];
  bool isReload = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setdata();
    GetProfilData();
  }

  setdata() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userStatus = prefs.getString("userRole") ?? "";
    profilename = prefs.getString("Name") ?? "";
    isLogin = prefs.getBool("isLoggedIn") ?? false;

    setState(() {
      if (isLogin) {
        menuname = sellername.toList();
        menuicon = Sellericon.toList();
      } else {
        menuicon = menuiconDrawer.toList();
        menuname = menunameDrawer.toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return (isReload == false)
        ? Drawer(
            backgroundColor: CupertinoColors.systemGrey5,
            child: ListView(
              children: [
                Container(
                  color: Colors.white,
                  padding: const EdgeInsets.only(left: 18, right: 18),
                  //height: height * 0.7,
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () {
                          // Navigator.of(context).push(
                          //   MaterialPageRoute(builder: (context) {
                          //     return const EditProfile();
                          //   }),
                          // );
                        },
                        child: (userStatus == "author" ||
                                userStatus == "subscriber")
                            ? Container(
                                height: height * 0.1,
                                width: width,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: height * 0.07,
                                      width: width * 0.15,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(50),
                                        child:
                                            profileImage == ""
                                                ? Container(
                                                    height: height * 0.07,
                                                    width: width * 0.15,
                                                  )
                                                : Image.network(
                                              profileImage,
                                                    fit: BoxFit.fill,
                                                  ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 25,
                                    ),
                                    Container(
                                      //   height: 40,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          Text(
                                            profilename,
                                            textAlign: TextAlign.left,
                                            style: const TextStyle(
                                              color: colorblack,
                                              //fontWeight: FontWeight.w300,
                                              fontFamily:
                                                  "assets/fonts/Raleway-Thin.ttf",
                                              fontSize: 17,
                                            ),
                                          ),
                                          Container(
                                            child: Text(
                                              profileEmail,
                                              style: const TextStyle(
                                                  fontSize: 14,
                                                  color: CupertinoColors
                                                      .systemGrey),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : Container(
                                height: height * 0.1,
                                width: width,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: height * 0.07,
                                      width: width * 0.15,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(50),
                                        child: Image.asset(
                                          "assets/images/user.png",
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 25,
                                    ),
                                    Container(
                                      //   height: 40,
                                      child: const Text(
                                        "Guest Login",
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          color: colorblack,
                                          //fontWeight: FontWeight.w300,
                                          fontFamily:
                                              "assets/fonts/Raleway-Thin.ttf",
                                          fontSize: 20,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      const Divider(
                        thickness: 1.5,
                        color: maincolor,
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      (userStatus != "author")
                          ? Column(
                              children: [
                                Container(
                                  height: menuiconDrawer.length * 47,
                                  child: ListView.builder(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: menuiconDrawer.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Container(
                                        height: 46,
                                        // width: 200,
                                        child: InkWell(
                                          onTap: () async {
                                            if (menunameDrawer[index] == "Home") {
                                              Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) {
                                                  return const BottomNavigationScreen(
                                                      0);
                                                }),
                                              );
                                            } else if (menunameDrawer[index] ==
                                                "Login") {
                                              Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) {
                                                  return const LoginScreen();
                                                }),
                                              );
                                            } else if (menunameDrawer[index] ==
                                                "Seller Registration") {
                                              Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) {
                                                  return const SellerReg();
                                                }),
                                              );
                                              // GetNotification_ApiCall();
                                            } else if (menunameDrawer[index] ==
                                                "General User Registration") {
                                              Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) {
                                                  return const UserReg();
                                                }),
                                              );
                                            } else if (menunameDrawer[index] ==
                                                "About us") {
                                              Navigator.of(context).push(
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      const Aboutus(),
                                                ),
                                              );
                                            } else if (menunameDrawer[index] ==
                                                "Contact us") {
                                              Navigator.of(context).push(
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      const Contactus(),
                                                ),
                                              );
                                            } else if (menunameDrawer[index] ==
                                                "FAQ") {
                                              Navigator.of(context).push(
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      const FAQ(),
                                                ),
                                              );
                                            } else if (menunameDrawer[index] ==
                                                "Blog") {
                                              Navigator.of(context).push(
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      const Webviewscreen(),
                                                ),
                                              );
                                            } else if (menunameDrawer[index] ==
                                                "Terms and Conditions") {
                                              Navigator.of(context).push(
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      const termscondition(),
                                                ),
                                              );
                                            } else if (menunameDrawer[index] ==
                                                "Privacy Policy") {
                                              Navigator.of(context).push(
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      const privacypolicy(),
                                                ),
                                              );
                                            }
                                            // else if (menuname[index] == "Categories") {
                                            //   Navigator.of(context).push(
                                            //     MaterialPageRoute(
                                            //       builder: (context) =>
                                            //           CategoriesScreen(),
                                            //     ),
                                            //   );
                                            // } else if (menuname[index] == "New Ads") {
                                            //   Navigator.of(context).push(
                                            //     MaterialPageRoute(
                                            //       builder: (context) => Makenewad_Screen(
                                            //         categories: '',
                                            //         subcategory: '',
                                            //       ),
                                            //     ),
                                            //   );
                                            // } else if (menuname[index] == "My Ads") {
                                            //   Navigator.of(context).push(
                                            //     MaterialPageRoute(
                                            //       builder: (context) => Myads_Screen(),
                                            //     ),
                                            //   );
                                            // } else if (menuname[index] == "My Wishlist") {
                                            //   Navigator.of(context).push(
                                            //     MaterialPageRoute(
                                            //       builder: (context) => Wishlist_Screen(),
                                            //     ),
                                            //   );
                                            // } else if (menuname[index] == "My Profile") {
                                            //   Navigator.of(context).push(
                                            //     MaterialPageRoute(
                                            //       builder: (context) =>
                                            //           MyProfile_Screen(),
                                            //     ),
                                            //   );
                                            // }
                                          },
                                          child: Container(
                                            // height: 60,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                      alignment:
                                                          Alignment.topCenter,
                                                      padding:
                                                          const EdgeInsets.all(
                                                              5),
                                                      height: 30,
                                                      decoration:
                                                          const BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        color: drawericon,
                                                      ),
                                                      child: Center(
                                                        child: Icon(
                                                          menuiconDrawer[index],
                                                          color: Colors.white,
                                                          size: 15,
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      width: 20,
                                                    ),
                                                    Container(
                                                      width: width * 0.5,
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Text(
                                                        menunameDrawer[index],
                                                        textAlign:
                                                            TextAlign.left,
                                                        style: const TextStyle(
                                                          fontSize: 17,
                                                          color: colorblack,
                                                          fontWeight:
                                                              FontWeight.w300,
                                                          // fontFamily:
                                                          //     "assets/fonts/Raleway-Thin.ttf"
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                const Divider(
                                                  thickness: 1.5,
                                                  color: CupertinoColors
                                                      .systemGrey5,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                (userStatus == "subscriber")
                                    ? Container(
                                        height: 50,
                                        width: 200,
                                        decoration: BoxDecoration(
                                            color: maincolor,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: TextButton(
                                          onPressed: () {},
                                          child: const Text(
                                            "Logout",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 16),
                                          ),
                                        ),
                                      )
                                    : const SizedBox(),
                              ],
                            )
                          : Column(
                              children: [
                                const SizedBox(
                                  height: 15,
                                ),
                                Container(
                                  height: Sellericon.length * 50,
                                  child: ListView.builder(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: Sellericon.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Container(
                                        height: 48,
                                        // width: 200,
                                        // color: Colors.red,
                                        child: InkWell(
                                          onTap: () async {
                                            if (sellername[index] == "Home") {
                                              Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) {
                                                  return const BottomNavigationScreen(
                                                      0);
                                                }),
                                              );
                                            } else if (sellername[index] ==
                                                "Categories") {
                                              Navigator.of(context).push(
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      CategoriesScreen(),
                                                ),
                                              );
                                            } else if (sellername[index] ==
                                                "New Ads") {
                                              Navigator.of(context).push(
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      Makenewad_Screen(),
                                                ),
                                              );
                                            } else if (sellername[index] ==
                                                "My Ads") {
                                              Navigator.of(context).push(
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      const Myads_Screen(),
                                                ),
                                              );
                                            } else if (sellername[index] ==
                                                "My Wishlist") {
                                              Navigator.of(context).push(
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      const Wishlist_Screen(),
                                                ),
                                              );
                                            } else if (sellername[index] ==
                                                "My Profile") {
                                              Navigator.of(context).push(
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      const MyProfile_Screen(),
                                                ),
                                              );
                                            } else if (sellername[index] ==
                                                "About us") {
                                              Navigator.of(context).push(
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      const Aboutus(),
                                                ),
                                              );
                                            } else if (sellername[index] ==
                                                "Contact us") {
                                              Navigator.of(context).push(
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      const Contactus(),
                                                ),
                                              );
                                            } else if (sellername[index] ==
                                                "FAQ") {
                                              Navigator.of(context).push(
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      const FAQ(),
                                                ),
                                              );
                                            } else if (sellername[index] ==
                                                "Blog") {
                                              Navigator.of(context).push(
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      const Webviewscreen(),
                                                ),
                                              );
                                            } else if (sellername[index] ==
                                                "Terms and Conditions") {
                                              Navigator.of(context).push(
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      const termscondition(),
                                                ),
                                              );
                                            } else if (sellername[index] ==
                                                "Privacy Policy") {
                                              Navigator.of(context).push(
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      const privacypolicy(),
                                                ),
                                              );
                                            }
                                          },
                                          child: Container(
                                            child: Column(
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                      alignment:
                                                          Alignment.topCenter,
                                                      padding:
                                                          const EdgeInsets.all(
                                                              5),
                                                      height: 30,
                                                      decoration:
                                                          const BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        color: drawericon,
                                                      ),
                                                      child: Center(
                                                        child: Icon(
                                                          Sellericon[index],
                                                          color: Colors.white,
                                                          size: 15,
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      width: 20,
                                                    ),
                                                    Container(
                                                      width: width * 0.5,
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Text(
                                                        sellername[index],
                                                        textAlign:
                                                            TextAlign.left,
                                                        style: const TextStyle(
                                                            fontSize: 15,
                                                            color: colorblack,
                                                            //fontWeight: FontWeight.w300,
                                                            fontFamily:
                                                                "assets/fonts/Raleway-Thin.ttf"),
                                                      ),
                                                    ),
                                                    const Divider(
                                                      thickness: 1.5,
                                                      color: Colors.grey,
                                                    ),
                                                  ],
                                                ),
                                                const Divider(
                                                  thickness: 1.5,
                                                  color: CupertinoColors
                                                      .systemGrey5,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                Container(
                                  height: 50,
                                  width: 200,
                                  decoration: BoxDecoration(
                                      color: maincolor,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: TextButton(
                                    onPressed: () {},
                                    child: const Text(
                                      "Logout",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                      const SizedBox(
                        height: 10,
                      )
                    ],
                  ),
                ),
              ],
            ),
          )
        : const Center(
            child: CircularProgressIndicator(
              color: maincolor,
            ),
          );
  }

  GetProfilData() async {
    setState(() {
      isReload = true;
    });
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      profilename = prefs.getString("Name").toString() == "null" ? "" :prefs.getString("Name").toString();
      profileEmail = prefs.getString("Email").toString() == "null" ? "" :prefs.getString("Email").toString();
      profileImage = prefs.getString("profile_image").toString() == "null" ? "" :prefs.getString("profile_image").toString();

      setState(() {
        isReload = false;
      });
    } catch (e) {
      setState(() {
        isReload = false;
      });
      print("Exception Drawer=>" + e.toString());
      throw e;
    }
  }
}
