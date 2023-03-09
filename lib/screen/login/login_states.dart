abstract class LoginState {
  String errorString = '';
}

class LoginStateStarting extends LoginState {

}

class LoginStateLoading extends LoginState {

}

class LoginStateDone extends LoginState {

}

class SartexAppStateError extends LoginState {
  SartexAppStateError(String error) {
    errorString = error;
  }
}

class LoginStateLoginComplete extends LoginState {

}