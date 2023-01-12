// ignore_for_file: non_constant_identifier_names

import "package:flutter/material.dart";
import 'package:minews/pages/home.dart';
import 'package:minews/pages/search.dart';
import 'package:minews/pages/settings.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({super.key});

  @override
  State<Wrapper> createState() => _HomWrapperState();
}

class _HomWrapperState extends State<Wrapper> {
  int currentIndex = 0;
  List screens = [const Home(), const Search(), const Settings()];

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        key: _scaffoldKey,
        bottomNavigationBar: BottomNavigationBar(
          showSelectedLabels: false,
          showUnselectedLabels: false,
          selectedIconTheme: const IconThemeData(color: Colors.black),
          unselectedIconTheme: const IconThemeData(color: Colors.grey),
          currentIndex: currentIndex,
          selectedFontSize: 0,
          onTap: (value) {
            setState(() {
              currentIndex = value;
            });
          },
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.home),
                activeIcon: Icon(Icons.home),
                label: "Home"),
            BottomNavigationBarItem(
                icon: Icon(Icons.search),
                activeIcon: Icon(Icons.search),
                label: "Search"),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                activeIcon: Icon(Icons.settings),
                label: "Settings"),
          ],
        ),
        body: SafeArea(child: screens[currentIndex]),
      ),
    );
  }
}
