part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
  List<Object> get props => [];
}

class AppStarted extends AuthEvent {
  @override
  String toString() => 'AppStarted';
}

class LogOutAuthEvent extends AuthEvent {
  @override
  String toString() => 'LoggedOut';
}

class LogInAuthEvent extends AuthEvent {
  @override
  String toString() => 'Logging In';
}

class ErrorAuthEvent extends AuthEvent {
  final String errorMessage;
  ErrorAuthEvent({@required this.errorMessage}) : assert(errorMessage != null);

  @override
  String toString() => 'ErrorAuthEvent { messsage: $errorMessage }';
}
