import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

class Uninitialized extends AuthenticationState {}

class Authenticated extends AuthenticationState {
  final FirebaseUser displayUser;

  const Authenticated(this.displayUser);

  @override
  List<Object> get props => [displayUser];

  @override
  String toString() => 'Authenticated { displayUser: $displayUser }';
}

class Unauthenticated extends AuthenticationState {}
