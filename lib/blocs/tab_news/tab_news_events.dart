import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

@immutable
abstract class TabNewsEvents extends Equatable{}

class LoadTabNewsEvent extends TabNewsEvents{
  @override
  List<Object> get props=>[];
}