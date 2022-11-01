import 'package:checklist/data/user_repository.dart';
import 'package:checklist/login/bloc/login_bloc.dart';
import 'package:checklist/login/ui/login_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatelessWidget {
  final UserRepository _userRepository;

  LoginPage({Key? key, required UserRepository userRepository})
      : _userRepository = userRepository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginBloc>(
      create: (context) => LoginBloc(userRepository: _userRepository),
      child: LoginForm(userRepository: _userRepository),
    );
  }
}
