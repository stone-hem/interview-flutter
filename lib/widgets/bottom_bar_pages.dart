import 'package:flutter/cupertino.dart';
import 'package:interview/screens/categories/news_categories.dart';
import 'package:interview/screens/home/home.dart';

Widget buildPage(int index) {
  List<Widget> widget = [
   const HomeScreen(),
  const NewsCategories(),
    Center(
      child: Text("Profile"),
    ),
  ];
  return widget[index];
}