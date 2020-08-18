import 'package:checklist/data/user_repository.dart';
import 'package:checklist/register/bloc/register_barrel.dart';
import 'package:checklist/register/ui/register_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterScreen extends StatelessWidget {
  final UserRepository _userRepository;

  RegisterScreen({Key key, @required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 30.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          boxShadow: [
            BoxShadow(
                color: Theme.of(context).highlightColor,
                offset: Offset(3.0, 6.0),
                blurRadius: 10.0)
          ],
          color: Theme.of(context).bottomSheetTheme.backgroundColor,
        ),
        child: Scaffold(
            resizeToAvoidBottomPadding: true,
            backgroundColor: Colors.transparent,
            body: BlocProvider<RegisterBloc>(
                create: (context) =>
                    RegisterBloc(userRepository: _userRepository),
                child: RegisterForm())));
  }
}
