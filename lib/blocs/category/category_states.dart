import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import '../../models/CategoryModel.dart';

@immutable
abstract class CategoryStates extends Equatable{}

class CategoryLoadingState extends CategoryStates{
  @override
  List<Object?> get props=>[];
}

class CategoryLoadedState extends CategoryStates{
  CategoryLoadedState(this.category);
  final List<CategoryModel> category;
  @override
  List<Object?> get props=>[];
}

class CategoryErrorState extends CategoryStates{
  CategoryErrorState(this.error);
  final String error;
  @override
  List<Object?> get props=>[error];
}