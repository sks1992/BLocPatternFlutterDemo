import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
//create state for loading state
@immutable
abstract class UserState extends Equatable {}

//data loading state
class UserLoadingState extends UserState {
  @override
  List<Object?> get props => [];
}

//data loaded state

//data error loading state


//in block pattern we need to create a class for each state