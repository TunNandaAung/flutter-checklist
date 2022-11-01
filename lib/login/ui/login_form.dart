import 'package:checklist/authentication_bloc/bloc.dart';
import 'package:checklist/data/user_repository.dart';
import 'package:checklist/login/bloc/login_bloc.dart';
import 'package:checklist/register/ui/register_screen.dart';
import 'package:checklist/todo/widgets/dialogs.dart';
import 'package:checklist/utils/custom_icons.dart';
import 'package:checklist/utils/header.dart';
import 'package:checklist/utils/social_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'signin_button.dart';

class LoginForm extends StatefulWidget {
  final UserRepository _userRepository;

  LoginForm({Key key, @required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  LoginBloc _loginBloc;
  UserRepository get _userRepository => widget._userRepository;

  final _focusNode = FocusNode();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool get isPopulated =>
      _emailController.text.isNotEmpty && _passwordController.text.isNotEmpty;

  bool isLoginButtonEnabled(LoginState state) {
    return state.isFormValid && isPopulated && !state.isSubmitting;
  }

  bool isForgotPasswordEnabled(LoginState state) {
    return state.isEmailValid && _emailController.text.isNotEmpty;
  }

  @override
  void initState() {
    super.initState();
    _loginBloc = context.read<LoginBloc>();
    _emailController.addListener(_onEmailChanged);
    _passwordController.addListener(_onPasswordChanged);

    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {}
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [
            Theme.of(context).backgroundColor,
            Theme.of(context).canvasColor,
          ],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              tileMode: TileMode.clamp)),
      child: Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: BlocListener<LoginBloc, LoginState>(
              listener: (context, state) {
                if (state.isFailure) {
                  ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(
                      SnackBar(
                        elevation: 6.0,
                        behavior: SnackBarBehavior.floating,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        content: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Login Failure',
                              style: TextStyle(fontFamily: 'Poppins-Bold'),
                            ),
                            Icon(Icons.error)
                          ],
                        ),
                        backgroundColor: Colors.red,
                      ),
                    );
                }
                if (state.isPasswordResetFailure) {
                  ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(
                      SnackBar(
                        elevation: 6.0,
                        behavior: SnackBarBehavior.floating,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        content: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Failed to send password reset email',
                              style: TextStyle(fontFamily: 'Poppins-Bold'),
                            ),
                            Icon(Icons.error)
                          ],
                        ),
                        backgroundColor: Colors.red,
                      ),
                    );
                }
                if (state.isPasswordResetMailSent) {
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
                              'Password reset mail has been sent to your email address',
                              style: TextStyle(fontFamily: 'Poppins-Bold'),
                            ),
                            Icon(Icons.check)
                          ],
                        ),
                        backgroundColor: Colors.red,
                      ),
                    );
                }
                if (state.isSubmitting) {
                  ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(
                      SnackBar(
                        elevation: 6.0,
                        behavior: SnackBarBehavior.floating,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        backgroundColor: Color(0xFF5d74e3),
                        content: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Logging In...',
                              style: TextStyle(fontFamily: 'Poppins-Bold'),
                            ),
                            CircularProgressIndicator(),
                          ],
                        ),
                      ),
                    );
                }
                if (state.isSuccess) {
                  context.read<AuthenticationBloc>().add(LoggedIn());
                }
              },
              child:
                  BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
                return Column(children: <Widget>[
                  // Padding(
                  //   padding: EdgeInsets.only(top: 63.0),
                  //   child: Image(
                  //     image: AssetImage(
                  //       'assets/app_icon/app-icon-tick-box-128.png',
                  //     ),
                  //     width: 64,
                  //     height: 64,
                  //   ),
                  // ),

                  Stack(
                    children: <Widget>[
                      Header(
                        text: 'Checklist',
                      ),
                      Align(
                        alignment: Alignment(-0.9, -0.9),
                        child: Padding(
                          padding: EdgeInsets.only(
                            left: 28.0,
                            right: 28.0,
                            top: kToolbarHeight +
                                MediaQuery.of(context).size.height / 7,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                width: double.infinity,
                                height: null,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8.0),
                                    boxShadow: [
                                      BoxShadow(
                                          color:
                                              Theme.of(context).highlightColor,
                                          offset: Offset(0.0, 15.0),
                                          blurRadius: 15.0),
                                      BoxShadow(
                                          color:
                                              Theme.of(context).highlightColor,
                                          offset: Offset(0.0, -10.0),
                                          blurRadius: 10.0),
                                    ]),
                                child: Form(
                                  key: _formKey,
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        left: 16.0, right: 16.0, top: 16.0),
                                    child: SingleChildScrollView(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text("Login",
                                              style: TextStyle(
                                                  fontSize:
                                                      ScreenUtil().setSp(45),
                                                  decoration:
                                                      TextDecoration.none,
                                                  color: Colors.black
                                                      .withOpacity(.80),
                                                  fontFamily: "Poppins-Bold",
                                                  letterSpacing: .6)),
                                          SizedBox(
                                            height: ScreenUtil().setHeight(30),
                                          ),
                                          Text("Email",
                                              style: TextStyle(
                                                  fontFamily: "Poppins-Medium",
                                                  color: Colors.black
                                                      .withOpacity(.80),
                                                  decoration:
                                                      TextDecoration.none,
                                                  fontSize:
                                                      ScreenUtil().setSp(26))),
                                          TextFormField(
                                            controller: _emailController,
                                            focusNode: _focusNode,
                                            autovalidateMode: AutovalidateMode
                                                .onUserInteraction,
                                            autocorrect: false,
                                            validator: (_) {
                                              if (!state.isEmailValid) {
                                                return ('Invalid Email');
                                              }
                                              return null;
                                            },
                                            cursorColor: Color(0xFF5d74e3),
                                            decoration: InputDecoration(
                                                hintText: "email",
                                                errorStyle: TextStyle(
                                                    fontFamily:
                                                        'Poppins-Medium'),
                                                hintStyle: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 12.0)),
                                          ),
                                          SizedBox(
                                            height: ScreenUtil().setHeight(20),
                                          ),
                                          Text("Password",
                                              style: TextStyle(
                                                  color: Colors.black
                                                      .withOpacity(.80),
                                                  decoration:
                                                      TextDecoration.none,
                                                  fontFamily: "Poppins-Medium",
                                                  fontSize:
                                                      ScreenUtil().setSp(26))),
                                          TextFormField(
                                            controller: _passwordController,
                                            autovalidateMode: AutovalidateMode
                                                .onUserInteraction,
                                            autocorrect: false,
                                            validator: (_) {
                                              if (!state.isPasswordValid) {
                                                return ('Invalid Password');
                                              }
                                              return null;
                                            },
                                            obscureText: true,
                                            cursorColor: Color(0xFF5d74e3),
                                            decoration: InputDecoration(
                                                errorStyle: TextStyle(
                                                    fontFamily:
                                                        'Poppins-Medium'),
                                                hintText: "Password",
                                                hintStyle: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 12.0)),
                                          ),
                                          SizedBox(
                                            height: ScreenUtil().setHeight(30),
                                          ),
                                          // SizedBox(
                                          //   height:
                                          //       ScreenUtil().setHeight(35),
                                          // ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: <Widget>[
                                              TextButton(
                                                onPressed: () async {
                                                  if (isForgotPasswordEnabled(
                                                      state)) {
                                                    _onForgotPasswordPressed();
                                                    final action = await Dialogs
                                                        .passwordResetDialog(
                                                            context,
                                                            'Don\'t Worry :)',
                                                            'A password reset link will be sent to your email. Make sure to check spam folders if you don\'t see one');
                                                    if (action ==
                                                        DialogAction.close) {}
                                                  }
                                                },
                                                child: Text(
                                                  "Forgot Password?",
                                                  style: TextStyle(
                                                      color: Color(0xFF5d74e3),
                                                      fontFamily:
                                                          "Poppins-Medium",
                                                      fontSize: ScreenUtil()
                                                          .setSp(28)),
                                                ),
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10.0,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: ScreenUtil().setHeight(40.0),
                              ),
                              SigninButton(
                                enable: isLoginButtonEnabled(state),
                                onTap: isLoginButtonEnabled(state)
                                    ? _onFormSubmitted
                                    : null,
                              ),
                              SizedBox(
                                height: ScreenUtil().setHeight(40.0),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  horizontalLine(),
                                  Text(
                                    'Social Login',
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        fontFamily: 'Poppins-Medium',
                                        decoration: TextDecoration.none,
                                        color: Theme.of(context).dividerColor),
                                  ),
                                  horizontalLine(),
                                ],
                              ),
                              SizedBox(
                                height: ScreenUtil().setHeight(30.0),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  SocialIcon(
                                    colors: [
                                      Color(0xFF102397),
                                      Color(0xFF187adf),
                                      Color(0xFF00eaf8)
                                    ],
                                    iconData: CustomIcons.facebook,
                                    onPressed: () {},
                                  ),
                                  SocialIcon(
                                    colors: [
                                      Color(0xFFff4f38),
                                      Color(0xFFff355d)
                                    ],
                                    iconData: CustomIcons.googlePlus,
                                    onPressed: () {
                                      _loginBloc.add(LoginWithGooglePressed());
                                    },
                                  ),
                                  SocialIcon(
                                    colors: [
                                      Color(0xFF17ead9),
                                      Color(0xFF6078ea)
                                    ],
                                    iconData: CustomIcons.twitter,
                                    onPressed: () {},
                                  ),
                                  SocialIcon(
                                    colors: [
                                      Color(0xFF00c6fb),
                                      Color(0xFF005bea)
                                    ],
                                    iconData: CustomIcons.linkedin,
                                    onPressed: () {},
                                  )
                                ],
                              ),
                              SizedBox(height: ScreenUtil().setHeight(30.0)),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    'New User?',
                                    style: TextStyle(
                                        decoration: TextDecoration.none,
                                        fontFamily: 'Poppins-Medium',
                                        color: Theme.of(context).dividerColor),
                                  ),
                                  SizedBox(
                                    width: ScreenUtil().setWidth(4.0),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(builder: (context) {
                                        return RegisterScreen(
                                            userRepository: _userRepository);
                                      }));
                                    },
                                    child: Text(
                                      'SignUp',
                                      style: TextStyle(
                                          color: Color(0xFF5d74e3),
                                          decoration: TextDecoration.none,
                                          fontFamily: 'Poppins-Bold'),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ]);
              }),
            ),
          )),
    );
  }

  Widget horizontalLine() => Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
        width: ScreenUtil().setHeight(120),
        height: 1.0,
        color: Theme.of(context).dividerColor,
      ));

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onEmailChanged() {
    _loginBloc.add(
      EmailChanged(email: _emailController.text),
    );
  }

  void _onPasswordChanged() {
    _loginBloc.add(
      PasswordChanged(password: _passwordController.text),
    );
  }

  void _onForgotPasswordPressed() {
    _loginBloc.add(
      ForgotPasswordPressed(
        email: _emailController.text,
      ),
    );
  }

  void _onFormSubmitted() {
    _loginBloc.add(
      LoginWithCredentialsPressed(
        email: _emailController.text,
        password: _passwordController.text,
      ),
    );
  }
}

// Future<void> signIn() async {
//   final formState = _formKey.currentState;
//   if (formState.validate()) {
//     formState.save();
//     try {
//       setState(() {
//         _showError = false;
//         _isLoading = true;
//       });

//       AuthResult result = await FirebaseAuth.instance
//           .signInWithEmailAndPassword(email: _email, password: _password);
//       FirebaseUser user = result.user;
//       Navigator.push(
//           context, MaterialPageRoute(builder: (context) => Home(user)));
//     } catch (e) {
//       setState(() {
//         _showError = true;
//         _isLoading = false;
//       });
//       print(e.message);
//     }
//   }
// }
