import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:study_buddy/models/user.dart';
import 'package:study_buddy/repositories/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthRepository _authRepository;

  AuthBloc({@required AuthRepository authRepository})
      : assert(authRepository != null),
        _authRepository = authRepository;

  @override
  AuthState get initialState => AuthInitial();

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    if (event is AppStarted) {
      yield* mapAppStartToState();
    }
  }

  Stream<AuthState> mapAppStartToState() async* {
    try {
      final isAuthenticated = await _authRepository.isAuthenticated();
      if (isAuthenticated) {
        yield Authenticated(user: await _authRepository.getUser());
      } else {
        yield Unauthenticated();
      }
    } catch (e) {
      yield AuthErrorState(errorMessage: e.message.toString());
    }
  }
}
