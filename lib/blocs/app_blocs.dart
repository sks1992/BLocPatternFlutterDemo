import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_pattern/service/user_service.dart';

import 'app_events.dart';
import 'app_states.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  late final UserService _userService;

  UserBloc(this._userService) : super(UserLoadingState()) {
    on<LoadUserEvent>((event, emit) async {
      emit(UserLoadingState());
      print('you Emitted the first State');

      try {
        final users = await _userService.getUser();
        emit(UserLoadedState(users));
      } catch (e) {
        emit(UserErrorState(e.toString()));
      }
    });
  }
}
