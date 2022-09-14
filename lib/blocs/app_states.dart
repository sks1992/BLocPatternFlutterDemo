import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../model/user_model.dart';

//create state for loading state
@immutable
abstract class UserState extends Equatable {}

//data loading state
class UserLoadingState extends UserState {
  @override
  List<Object?> get props => [];
}

class UserLoadedState extends UserState {
  UserLoadedState(this.user);

  final List<UserModel> user;

  @override
  List<Object?> get props => [user];
}
//data loaded state

//data error loading state
class UserErrorState extends UserState {
  UserErrorState(this.error);

  final String error;

  @override
  List<Object?> get props => [error];
}
//in block pattern we need to create a class for each state
