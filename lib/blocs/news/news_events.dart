import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

@immutable
abstract class NewsEvents extends Equatable{}

class LoadNewsEvent extends NewsEvents{
  @override
  List<Object> get props=>[];
}