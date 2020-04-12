import 'package:checklist/data/user_repository.dart';
import 'package:checklist/register/bloc/register_barrel.dart';
import 'package:checklist/register/ui/register_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Modal {
  mainBottomSheet(BuildContext context, UserRepository _userRepository) {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return BlocProvider<RegisterBloc>(
              builder: (context) =>
                  RegisterBloc(userRepository: _userRepository),
              child: RegisterForm());
        });
  }
}
