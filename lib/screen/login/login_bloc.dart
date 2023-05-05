import 'dart:html';

import 'package:bloc/bloc.dart';
import 'package:sartex/screen/login/login_actions.dart';

import 'login_states.dart';

class LoginBloc extends Bloc<LoginAction, LoginState> {

  LoginBloc(super.initialState) {
  }

  Future<void> mapEventToState(LoginAction event) async {
    emit(LoginStateLoading());
    await event.proccesing();
    emit(event.state);
  }

  void dispose() {}
}
