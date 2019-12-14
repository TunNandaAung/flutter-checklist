import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final FirebaseUser user;
  final String message;

  const ProfileLoaded({this.user, this.message = ''});

  @override
  List<Object> get props => [user];

  @override
  String toString() => 'ProfileLoaded { Profile: $user }';
}

class ProfileUpdated extends ProfileState {
  final FirebaseUser user;

  const ProfileUpdated(this.user);

  @override
  List<Object> get props => [user];

  @override
  String toString() => 'ProfileUpdated { User: $user }';
}

class PasswordChanged extends ProfileState {}

class ProfileNotUpdated extends ProfileState {
  final String error;

  ProfileNotUpdated(this.error);

  @override
  List<Object> get props => [error];
}
