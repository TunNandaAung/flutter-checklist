import 'package:firebase_integrations/authentication_bloc/bloc.dart';
import 'package:firebase_integrations/data/user_repository.dart';
import 'package:firebase_integrations/login/bloc/login_barrel.dart';
import 'package:firebase_integrations/modal.dart';
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
  Modal modal = new Modal();

  bool get isPopulated =>
      _emailController.text.isNotEmpty && _passwordController.text.isNotEmpty;

  bool isLoginButtonEnabled(LoginState state) {
    return state.isFormValid && isPopulated && !state.isSubmitting;
  }

  int _cardHeight = 500;
  bool _hasError = false;

  void changeCardHeight(int height) {
    setState(() {
      _cardHeight = height;
    });
  }

  @override
  void initState() {
    super.initState();
    _loginBloc = BlocProvider.of<LoginBloc>(context);
    _emailController.addListener(_onEmailChanged);
    _passwordController.addListener(_onPasswordChanged);

    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        _hasError = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil.getInstance()..init(context);
    ScreenUtil.instance =
        ScreenUtil(width: 750, height: 1250, allowFontScaling: true);

    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [
            Color(0xFF1b1e44),
            Color(0xFF2d3447),
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
                  Scaffold.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(
                      SnackBar(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
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
                if (state.isSubmitting) {
                  Scaffold.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(
                      SnackBar(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        backgroundColor: Color(0xFF2d3447),
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
                  BlocProvider.of<AuthenticationBloc>(context).add(LoggedIn());
                }
              },
              child:
                  BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
                return Padding(
                  padding: const EdgeInsets.only(
                      left: 28.0, right: 28.0, top: 140.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        width: double.infinity,
                        height: ScreenUtil.getInstance().setHeight(_cardHeight),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8.0),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black12,
                                  offset: Offset(0.0, 15.0),
                                  blurRadius: 15.0),
                              BoxShadow(
                                  color: Colors.black12,
                                  offset: Offset(0.0, -10.0),
                                  blurRadius: 10.0),
                            ]),
                        child: Form(
                          key: _formKey,
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: 16.0, right: 16.0, top: 16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text("Login",
                                    style: TextStyle(
                                        fontSize:
                                            ScreenUtil.getInstance().setSp(45),
                                        fontFamily: "Poppins-Bold",
                                        letterSpacing: .6)),
                                SizedBox(
                                  height:
                                      ScreenUtil.getInstance().setHeight(30),
                                ),
                                Text("Email",
                                    style: TextStyle(
                                        fontFamily: "Poppins-Medium",
                                        fontSize: ScreenUtil.getInstance()
                                            .setSp(26))),
                                TextFormField(
                                  controller: _emailController,
                                  focusNode: _focusNode,
                                  autovalidate: true,
                                  autocorrect: false,
                                  validator: (_) {
                                    if (!state.isEmailValid) {
                                      return ('Invalid Email');
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                      hintText: "email",
                                      errorStyle: TextStyle(
                                          fontFamily: 'Poppins-Medium'),
                                      hintStyle: TextStyle(
                                          color: Colors.grey, fontSize: 12.0)),
                                ),
                                SizedBox(
                                  height:
                                      ScreenUtil.getInstance().setHeight(30),
                                ),
                                Text("Password",
                                    style: TextStyle(
                                        fontFamily: "Poppins-Medium",
                                        fontSize: ScreenUtil.getInstance()
                                            .setSp(26))),
                                TextFormField(
                                  controller: _passwordController,
                                  autovalidate: true,
                                  autocorrect: false,
                                  validator: (_) {
                                    if (!state.isPasswordValid) {
                                      return ('Invalid Password');
                                    }
                                    return null;
                                  },
                                  obscureText: true,
                                  decoration: InputDecoration(
                                      errorStyle: TextStyle(
                                          fontFamily: 'Poppins-Medium'),
                                      hintText: "Password",
                                      hintStyle: TextStyle(
                                          color: Colors.grey, fontSize: 12.0)),
                                ),
                                SizedBox(
                                  height:
                                      ScreenUtil.getInstance().setHeight(30),
                                ),
                                // SizedBox(
                                //   height:
                                //       ScreenUtil.getInstance().setHeight(35),
                                // ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Text(
                                      "Forgot Password?",
                                      style: TextStyle(
                                          color: Colors.blue,
                                          fontFamily: "Poppins-Medium",
                                          fontSize: ScreenUtil.getInstance()
                                              .setSp(28)),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: ScreenUtil.getInstance().setHeight(40.0),
                      ),
                      SigninButton(
                        enable: isLoginButtonEnabled(state),
                        onTap: isLoginButtonEnabled(state)
                            ? _onFormSubmitted
                            : null,
                      ),
                      SizedBox(
                        height: ScreenUtil.getInstance().setHeight(40.0),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          horizontalLine(),
                          Text(
                            'New User?',
                            style: TextStyle(
                                fontSize: 16.0,
                                fontFamily: 'Poppins-Medium',
                                color: Colors.white),
                          ),
                          horizontalLine(),
                        ],
                      ),
                      SizedBox(height: ScreenUtil.getInstance().setHeight(30)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          FlatButton(
                            onPressed: () {
                              modal.mainBottomSheet(context);
                            },
                            color: Color(0xFF5d74e3),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0)),
                            child: Text('Sign Up',
                                style: TextStyle(
                                    fontFamily: 'Poppins-Bold',
                                    color: Colors.white)),
                          ),
                        ],
                      )
                    ],
                  ),
                );
              }),
            ),
          )),
    );
  }

  Widget horizontalLine() => Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
        width: ScreenUtil.getInstance().setHeight(120),
        height: 1.0,
        color: Colors.white30.withOpacity(.2),
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
