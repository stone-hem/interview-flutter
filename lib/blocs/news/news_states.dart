import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import '../../models/NewsModel.dart';

@immutable
abstract class NewsStates extends Equatable{}

class NewsLoadingState extends NewsStates{
  @override
  List<Object?> get props=>[];
}

class NewsLoadedState extends NewsStates{
  NewsLoadedState(this.news);
  final List<NewsModel> news;
  @override
  List<Object?> get props=>[];
}

class NewsErrorState extends NewsStates{
  NewsErrorState(this.error);
  final String error;
  @override
  List<Object?> get props=>[error];
}