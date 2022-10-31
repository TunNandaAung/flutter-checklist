part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  List<Object> get props => [];
}

class LoadProfile extends ProfileEvent {}

class UpdateProfile extends ProfileEvent {
  final User user;
  final String name;
  final String email;

  const UpdateProfile(this.user, this.name, this.email);

  @override
  List<Object> get props => [user];

  @override
  String toString() => 'UpdateProfile { user: $user }';
}

class ChangePassword extends ProfileEvent {
  final User user;
  final String currentPassword;
  final String newPassword;

  const ChangePassword(this.user, this.currentPassword, this.newPassword);

  @override
  List<Object> get props => [user];

  @override
  String toString() => 'UpdateProfile { user: $user }';
}
