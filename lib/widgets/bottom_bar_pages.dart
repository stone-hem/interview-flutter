import 'package:flutter/cupertino.dart';
import 'package:interview/ui/categories/categories.dart';
import 'package:interview/ui/recent/recent.dart';
import 'package:interview/ui/search/search.dart';

Widget buildPage(int index) {
  List<Widget> widget = [const Recent(), const Categories(),const Search()];
  return widget[index];
}
