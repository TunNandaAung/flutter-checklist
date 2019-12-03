import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  List<Object> get props => [];
}

class LoadProfile extends ProfileEvent {}

class UpdateProfile extends ProfileEvent {
  final FirebaseUser user;
  final String name;
  final String email;

  const UpdateProfile(this.user, this.name, this.email);

  @override
  List<Object> get props => [user];

  @override
  String toString() => 'UpdateTodo { user: $user }';
}
