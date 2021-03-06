import 'package:checklist/authentication_bloc/bloc.dart';
import 'package:checklist/register/bloc/register_barrel.dart';
import 'package:checklist/register/ui/register_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RegisterForm extends StatefulWidget {
  RegisterForm({Key key}) : super(key: key);

  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  RegisterBloc _registerBloc;

  bool get isPopulated =>
      _emailController.text.isNotEmpty &&
      _passwordController.text.isNotEmpty &&
      _nameController.text.isNotEmpty;

  bool isRegisterButtonEnabled(RegisterState state) {
    return state.isFormValid && isPopulated && !state.isSubmitting;
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _registerBloc = context.read<RegisterBloc>();
    _nameController.addListener(_onNameChanged);
    _emailController.addListener(_onEmailChanged);
    _passwordController.addListener(_onPasswordChanged);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterBloc, RegisterState>(
      listener: (context, state) {
        if (state.isSubmitting) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                elevation: 6.0,
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                //backgroundColor: Color(0xFF2d3447),
                backgroundColor: Color(0xFF5d74e3),
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Registering...',
                      style: TextStyle(fontFamily: 'Poppins-Bold'),
                    ),
                    CircularProgressIndicator(),
                  ],
                ),
              ),
            );
          CircularProgressIndicator();
        }
        if (state.isSuccess) {
          context.read<AuthenticationBloc>().add(LoggedIn());
          Navigator.of(context).pop();
        }
        if (state.isFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                elevation: 6.0,
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Register Failure',
                      style: TextStyle(fontFamily: 'Poppins-Bold'),
                    ),
                    Icon(Icons.error)
                  ],
                ),
                backgroundColor: Colors.red,
              ),
            );
        }
      },
      child:
          BlocBuilder<RegisterBloc, RegisterState>(builder: (context, state) {
        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Container(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Form(
                    key: _formKey,
                    child: Padding(
                      padding:
                          EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text("Cancel",
                                      style: TextStyle(
                                          fontSize: ScreenUtil().setSp(30),
                                          fontFamily: "Poppins-Medium",
                                          letterSpacing: .6,
                                          color: Color(0xFF5d74e3))),
                                ),
                                RegisterButton(
                                  onPressed: isRegisterButtonEnabled(state)
                                      ? _onFormSubmitted
                                      : null,
                                ),
                              ]),
                          SizedBox(
                            height: 5.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text("Create Account",
                                  style: TextStyle(
                                      fontSize: ScreenUtil().setSp(42),
                                      fontFamily: "Poppins-Bold",
                                      letterSpacing: .6,
                                      color: Theme.of(context).dividerColor)),
                            ],
                          ),
                          SizedBox(
                            height: ScreenUtil().setHeight(30),
                          ),
                          TextFormField(
                            controller: _nameController,
                            autocorrect: false,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (_) {
                              return !state.isNameValid
                                  ? 'Plase enter a name'
                                  : null;
                            },
                            cursorColor: Color(0xFF5d74e3),
                            autofocus: true,
                            style: Theme.of(context).textTheme.headline1,
                            decoration: InputDecoration(
                                fillColor: Colors.white,
                                hintText: "name",
                                errorStyle:
                                    TextStyle(fontFamily: 'Poppins-Medium'),
                                hintStyle: Theme.of(context)
                                    .inputDecorationTheme
                                    .hintStyle),
                          ),
                          SizedBox(
                            height: ScreenUtil().setHeight(15),
                          ),
                          TextFormField(
                            controller: _emailController,
                            autocorrect: false,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (_) {
                              return !state.isEmailValid
                                  ? 'Invalid Email'
                                  : null;
                            },
                            cursorColor: Color(0xFF5d74e3),
                            autofocus: true,
                            style: Theme.of(context).textTheme.headline1,
                            decoration: InputDecoration(
                                fillColor: Colors.white,
                                hintText: "email",
                                errorStyle:
                                    TextStyle(fontFamily: 'Poppins-Medium'),
                                hintStyle: Theme.of(context)
                                    .inputDecorationTheme
                                    .hintStyle),
                          ),
                          SizedBox(
                            height: ScreenUtil().setHeight(15),
                          ),
                          TextFormField(
                            controller: _passwordController,
                            obscureText: true,
                            autocorrect: false,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (_) {
                              return !state.isPasswordValid
                                  ? 'Invalid Password'
                                  : null;
                            },
                            style: Theme.of(context).textTheme.headline1,
                            decoration: InputDecoration(
                                hintText: "Password",
                                errorStyle:
                                    TextStyle(fontFamily: 'Poppins-Medium'),
                                hintStyle: Theme.of(context)
                                    .inputDecorationTheme
                                    .hintStyle),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onEmailChanged() {
    _registerBloc.add(
      EmailChanged(email: _emailController.text),
    );
  }

  void _onPasswordChanged() {
    _registerBloc.add(
      PasswordChanged(password: _passwordController.text),
    );
  }

  void _onNameChanged() {
    _registerBloc.add(
      NameChanged(name: _nameController.text),
    );
  }

  void _onFormSubmitted() {
    _registerBloc.add(
      Submitted(
        name: _nameController.text,
        email: _emailController.text,
        password: _passwordController.text,
      ),
    );
  }
}

// Future<void> signIn(BuildContext context) async {
//   print('Called');
//   final formState = _formKey.currentState;
//   print(_email);
//   if (formState.validate()) {
//     formState.save();
//     try {
//       AuthResult result = await FirebaseAuth.instance
//           .createUserWithEmailAndPassword(email: _email, password: _password);
//       FirebaseUser user = result.user;
//       user.sendEmailVerification();
//       Navigator.of(context).pop();
//     } catch (e) {
//       _showError = true;
//       print(e.message);
//     }
//   }
// }
