import 'package:checklist/data/user_repository.dart';
import 'package:checklist/login/ui/login_form.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  final UserRepository _userRepository;

  LoginPage({Key key, @required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return LoginForm(userRepository: _userRepository);
  }
}
