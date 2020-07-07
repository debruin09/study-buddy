part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class Uninitialized extends AuthState {
  @override
  String toString() => 'Uninitialized';
}

class Authenticated extends AuthState {
  final User user;

  Authenticated({@required this.user}) : assert(user != null);

  @override
  String toString() => 'Authenticated { user: $user }';
}

class Unauthenticated extends AuthState {
  @override
  String toString() => 'Unauthenticated';
}

class AuthErrorState extends AuthState {
  final String errorMessage;

  AuthErrorState({@required this.errorMessage}) : assert(errorMessage != null);
  @override
  String toString() => 'AuthErrorState { errorMessage: $errorMessage }';
}
