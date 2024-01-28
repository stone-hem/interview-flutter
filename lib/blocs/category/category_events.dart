import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

@immutable
abstract class CategoryEvents extends Equatable{}

class LoadCategoryEvent extends CategoryEvents{
  @override
  List<Object> get props=>[];
}