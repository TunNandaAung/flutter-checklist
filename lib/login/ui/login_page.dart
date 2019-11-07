import 'package:firebase_integrations/data/user_repository.dart';
import 'package:firebase_integrations/login/bloc/login_barrel.dart';
import 'package:firebase_integrations/login/ui/login_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatelessWidget {
  final UserRepository _userRepository;

  LoginPage({Key key, @required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginBloc>(
      builder: (context) => LoginBloc(userRepository: _userRepository),
      child: LoginForm(userRepository: _userRepository),
    );
  }
}