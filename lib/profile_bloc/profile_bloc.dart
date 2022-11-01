import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:checklist/data/user_repository.dart';
import 'package:flutter/services.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final UserRepository _userRepository;

  late StreamSubscription _profileSubscription;

  ProfileBloc({required UserRepository userRepository})
      : _userRepository = userRepository,
        super(ProfileLoading()) {
    on<LoadProfile>(_onLoadProfile);
    on<UpdateProfile>(_onUpdateProfile);
    on<ChangePassword>(_onChangePassword);
  }

  Future<void> _onLoadProfile(
    LoadProfile event,
    Emitter<ProfileState> emit,
  ) async {
    _profileSubscription.cancel();
    final user = await _userRepository.getUser();

    emit(ProfileLoaded(user: user!));
  }

  Future<void> _onUpdateProfile(
    UpdateProfile event,
    Emitter<ProfileState> emit,
  ) async {
    try {
      emit(ProfileLoading());
      User? user = await _userRepository.updateProfile(
          user: event.user, name: event.name, email: event.email);
      print('User : $user');

      emit(ProfileLoaded(user: user!));
    } catch (e) {
      print(e);
      emit(ProfileNotUpdated(e.toString()));
    }
  }

  Future<void> _onChangePassword(
    ChangePassword event,
    Emitter<ProfileState> emit,
  ) async {
    try {
      emit(ProfileLoading());
      await _userRepository.changePassword(
          user: event.user,
          currentPassword: event.currentPassword,
          newPassword: event.newPassword);
      emit(PasswordChanged());

      await Future.delayed(Duration(milliseconds: 300));

      emit(ProfileLoaded(user: event.user));
    } on PlatformException catch (e) {
      emit(ProfileNotUpdated(e.toString()));

      await Future.delayed(Duration(milliseconds: 300));

      emit(ProfileLoaded(user: event.user));
    }
  }
}
