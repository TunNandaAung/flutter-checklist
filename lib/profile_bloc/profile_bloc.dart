import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_integrations/data/user_repository.dart';
import 'package:firebase_integrations/profile_bloc/profile_barrel.dart';
import 'package:flutter/services.dart';
import 'package:meta/meta.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final UserRepository _userRepository;

  StreamSubscription _profileSubscription;

  ProfileBloc({@required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository;

  @override
  ProfileState get initialState => ProfileLoading();

  @override
  Stream<ProfileState> mapEventToState(
    ProfileEvent event,
  ) async* {
    if (event is LoadProfile) {
      yield* _mapLoadProfileToState();
    } else if (event is UpdateProfile) {
      yield* _mapUpdateProfileToState(event);
    } else if (event is ChangePassword) {
      yield* _mapChangePasswordToState(event);
    }
  }

  Stream<ProfileState> _mapLoadProfileToState() async* {
    _profileSubscription?.cancel();
    final user = await _userRepository.getUser();

    yield ProfileLoaded(user: user);
  }

  Stream<ProfileState> _mapUpdateProfileToState(UpdateProfile event) async* {
    try {
      yield ProfileLoading();
      FirebaseUser user = await _userRepository.updateProfile(
          user: event.user, name: event.name, email: event.email);
      print('User : $user');
      yield ProfileLoaded(user: user);
    } catch (e) {
      print(e);
      yield ProfileNotUpdated(e.toString());
    }
  }

  Stream<ProfileState> _mapChangePasswordToState(ChangePassword event) async* {
    try {
      yield ProfileLoading();
      await _userRepository.changePassword(
          user: event.user,
          currentPassword: event.currentPassword,
          newPassword: event.newPassword);
      yield PasswordChanged();
      yield ProfileLoaded(user: event.user);
    } on PlatformException catch (e) {
      yield ProfileNotUpdated(e.message);

      await Future.delayed(Duration(milliseconds: 300));
      yield ProfileLoaded(user: event.user);
    }
  }
}
