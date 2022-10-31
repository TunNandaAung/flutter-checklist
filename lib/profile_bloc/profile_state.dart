part of 'profile_bloc.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final User user;
  final String message;

  const ProfileLoaded({this.user, this.message = ''});

  @override
  List<Object> get props => [user];

  @override
  String toString() => 'ProfileLoaded { Profile: $user }';
}

class ProfileUpdated extends ProfileState {
  final User user;

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
