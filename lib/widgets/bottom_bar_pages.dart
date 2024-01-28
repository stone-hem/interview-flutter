import 'package:flutter/cupertino.dart';

Widget buildPage(int index) {
  List<Widget> widget = [
    Center(
      child: Text("home"),
    ),
    Center(
      child: Text("History"),
    ),
    Center(
      child: Text("Profile"),
    ),
  ];
  return widget[index];
}