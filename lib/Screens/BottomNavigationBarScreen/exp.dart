import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../CategoriesScreen/CategoriesScreen.dart';
import '../Drawer/DrawerScreen.dart';
import '../HomeScreen/HomeScreen.dart';
import '../Search/SearchScreen.dart';

class abc extends StatefulWidget {
  final int selectedIndex;
  const abc(this.selectedIndex, {super.key});

  @override
  State<abc> createState() => _abcState(selectedIndex);
}

class _abcState extends State<abc> {
  PageController _myPage = PageController(initialPage: 0);
  var scaffoldKey = GlobalKey<ScaffoldState>();
  int selectedIndex = 1;
  _abcState(this.selectedIndex);
  final List<Widget> _widgetOptions = <Widget>[
    // LoginScreen(),
    const HomeScreen(),
    const SearchScreen(),
     CategoriesScreen(),
    // const DrawerScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        child: Container(
          height: 75,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconButton(
                iconSize: 30.0,
                padding: EdgeInsets.only(left: 28.0),
                icon: Icon(Icons.home),
                onPressed: () {
                  setState(() {
                    _myPage.jumpToPage(0);
                  });
                },
              ),
              IconButton(
                iconSize: 30.0,
                padding: EdgeInsets.only(right: 28.0),
                icon: Icon(Icons.search),
                onPressed: () {
                  setState(() {
                    _myPage.jumpToPage(1);
                  });
                },
              ),
              IconButton(
                iconSize: 30.0,
                padding: EdgeInsets.only(left: 28.0),
                icon: Icon(Icons.search),
                onPressed: () {
                  setState(() {
                    _myPage.jumpToPage(2);
                  });
                },
              ),
              IconButton(
                iconSize: 30.0,
                padding: EdgeInsets.only(right: 28.0),
                icon: Icon(CupertinoIcons.book_fill),
                onPressed: () {
                  setState(() {
                    _myPage.jumpToPage(3);
                  });
                },
              ),
              IconButton(
                iconSize: 30.0,
                padding: EdgeInsets.only(right: 28.0),
                icon: Icon(Icons.more_horiz_rounded),
                onPressed: () {
                  setState(() {
                    scaffoldKey.currentState?.openDrawer();
                  });
                },
              )
            ],
          ),
        ),
      ),
      body: _widgetOptions.elementAt(selectedIndex)
    );
  }
}
