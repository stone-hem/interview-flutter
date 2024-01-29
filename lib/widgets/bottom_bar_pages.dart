import 'package:flutter/cupertino.dart';
import 'package:interview/ui/categories/categories.dart';
import 'package:interview/ui/recent/recent.dart';
import 'package:interview/ui/show/show.dart';

Widget buildPage(int index) {
  List<Widget> widget = [const Recent(), const Categories(), const Show()];
  return widget[index];
}
