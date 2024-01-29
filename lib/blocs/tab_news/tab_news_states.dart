import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:interview/models/TabNewsModel.dart';


@immutable
abstract class TabNewsStates extends Equatable{}

class TabNewsLoadingState extends TabNewsStates{
  @override
  List<Object?> get props=>[];
}

class TabNewsLoadedState extends TabNewsStates{
  TabNewsLoadedState(this.tabNews);
  final List<TabNewsModel> tabNews;
  @override
  List<Object?> get props=>[];
}

class TabNewsErrorState extends TabNewsStates{
  TabNewsErrorState(this.error);
  final String error;
  @override
  List<Object?> get props=>[error];
}