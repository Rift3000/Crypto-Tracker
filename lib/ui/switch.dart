import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:crypto_wallet/ui/add_view.dart';
import 'package:crypto_wallet/ui/home.dart';
import 'package:crypto_wallet/ui/prices.dart';
import 'package:flutter/material.dart';

class Switcheroo extends StatefulWidget {
  @override
  _SwitcherooState createState() => _SwitcherooState();
}

class _SwitcherooState extends State<Switcheroo> {
  int _currentIndex = 0;
  PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Color secondaryColor = Color(0xff232c51);

    return Scaffold(
      body: SizedBox.expand(
        child: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() => _currentIndex = index);
          },
          children: <Widget>[
            Home2(),
            AddView(),
            Prices(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavyBar(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        backgroundColor: secondaryColor,
        selectedIndex: _currentIndex,
        onItemSelected: (index) {
          setState(() => _currentIndex = index);
          _pageController.jumpToPage(index);
        },
        items: <BottomNavyBarItem>[
          BottomNavyBarItem(
              title: Text('Portfolio'),
              icon: Icon(Icons.tv_sharp),
              textAlign: TextAlign.center),
          BottomNavyBarItem(
              title: Text('Add'),
              icon: Icon(Icons.article_sharp),
              textAlign: TextAlign.center),
          BottomNavyBarItem(
              title: Text('Coins'),
              icon: Icon(Icons.watch_later),
              textAlign: TextAlign.center),
        ],
      ),
    );
  }
}
