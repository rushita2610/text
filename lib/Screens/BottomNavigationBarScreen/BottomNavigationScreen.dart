import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:reapp_ghana_project/ColorConstant/ColorConstant.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Api/api.dart';
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
  bool colorchng = false;
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
    // const DrawerScreen(),
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
    // const DrawerScreen(),
  ];

  // GlobalKey<ScaffoldState> _drawerKeylogin = GlobalKey();

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

  List<Widget> _bottomNavBarScreens() {
    // Define your bottom navigation bar screens here
    return [
      const HomeScreen(),
      const SearchScreen(),
      CategoriesScreen(),
      DrawerScreen(),
    ];
  }

  List<Widget> _bottomNavBarScreens2() {
    // Define your bottom navigation bar screens here
    return [
      const HomeScreen(),
      const SearchScreen(),
      Makenewad_Screen(),
      DrawerScreen(),
    ];
  }

  List<PersistentBottomNavBarItem> _bottomNavBarItems() {
    // Define your bottom navigation bar items here
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(
          CupertinoIcons.house_fill,
          size: 20,
        ),
        title: "Home",
        activeColorPrimary: maincolor,
        inactiveColorPrimary: Colors.black54,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(
          FontAwesomeIcons.search,
          size: 20,
        ),
        title: "Search",
        activeColorPrimary: maincolor,
        inactiveColorPrimary: Colors.black54,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(
          FontAwesomeIcons.bookOpen,
          size: 20,
        ),
        title: "Category",
        activeColorPrimary: maincolor,
        inactiveColorPrimary: Colors.black54,
      ),
      PersistentBottomNavBarItem(
          icon: const Icon(
            FontAwesomeIcons.ellipsisH,
            size: 20,
          ),
          title: "More",
          activeColorPrimary: maincolor,
          inactiveColorPrimary: Colors.black54,
          onPressed: (_) {
            _drawerKey.currentState?.openDrawer();
          }),
    ];
  }

  List<PersistentBottomNavBarItem> _bottomNavBarItems2() {
    // Define your bottom navigation bar items here
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(
          CupertinoIcons.house_fill,
          size: 20,
        ),
        title: "Home",
        activeColorPrimary: maincolor,
        inactiveColorPrimary: Colors.black54,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(
          FontAwesomeIcons.search,
          size: 20,
        ),
        title: "Search",
        activeColorPrimary: maincolor,
        inactiveColorPrimary: Colors.black54,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(
          FontAwesomeIcons.upload,
          size: 20,
        ),
        title: "+ Upload",
        activeColorPrimary: maincolor,
        inactiveColorPrimary: Colors.black54,
      ),
      PersistentBottomNavBarItem(
          icon: const Icon(
            FontAwesomeIcons.ellipsisH,
            size: 20,
          ),
          title: "More",
          activeColorPrimary: maincolor,
          inactiveColorPrimary: Colors.black54,
          onPressed: (_) {
            _drawerKey.currentState?.openDrawer();
          }),
    ];
  }

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
      child: SafeArea(
        child: Scaffold(
          key: _drawerKey,
          backgroundColor: CupertinoColors.systemGrey5,
          // extendBody: true,
          bottomNavigationBar: PersistentTabView(
            context,
            controller: PersistentTabController(initialIndex: _selectedIndex),
            screens: _bottomNavBarScreens(),
            items: (userStatus != "author")
                ? _bottomNavBarItems()
                : _bottomNavBarItems2(),
            // confineInSafeArea: true,
            backgroundColor: CupertinoColors.systemGrey5,
            // handleAndroidBackButtonPress: true,
            // resizeToAvoidBottomInset: true,
            hideNavigationBarWhenKeyboardShows: true,
            decoration: NavBarDecoration(
              borderRadius: BorderRadius.circular(10.0),
              colorBehindNavBar: CupertinoColors.systemGrey5,
            ),
            popAllScreensOnTapOfSelectedTab: true,
            popActionScreens: PopActionScreensType.all,
            itemAnimationProperties: const ItemAnimationProperties(
              duration: Duration(milliseconds: 200),
              curve: Curves.ease,
            ),
            screenTransitionAnimation: const ScreenTransitionAnimation(
              animateTabTransition: true,
              curve: Curves.ease,
              duration: Duration(milliseconds: 200),
            ),
            navBarStyle: NavBarStyle.simple,
            onItemSelected: (int index) {
              index == 3
                  ? _drawerKey.currentState?.openDrawer()
                  : setState(() {
                      _selectedIndex = index;
                    });
            },
          ),
          drawer: const DrawerScreen(),
          body: (userStatus == "author")
              ? _bottomNavBarScreens2()[_selectedIndex]
              : _bottomNavBarScreens()[_selectedIndex],
        ),
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
