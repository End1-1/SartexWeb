import 'package:bloc/bloc.dart';

import 'language_event.dart';
import 'language_state.dart';

class LanguageBloc extends Bloc<LanguageEvent, LanguageState> {
  LanguageBloc(super.initialState) {
    on<LanguageEventRefresh>((event, emit) => emit(LanguageStateRefresh()));
  }
}