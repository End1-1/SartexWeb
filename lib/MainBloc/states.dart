abstract class SartexAppState {
  String errorString = '';
}

class SartexAppStateStarting extends SartexAppState {

}

class SartexAppStateLoadingData extends SartexAppState {

}

class SartexAppStateDone extends SartexAppState {

}

class SartexAppStateError extends SartexAppState {
  SartexAppStateError(String error) {
    errorString = error;
  }
}

class SartexAppStateLoginComplete extends SartexAppState {

}