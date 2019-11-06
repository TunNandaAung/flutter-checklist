import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_integrations/data/user_repository.dart';
import 'package:firebase_integrations/home.dart';
import 'package:firebase_integrations/modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'login_bloc/login_bloc.dart';

class LoginPage extends StatefulWidget {
  final UserRepository _userRepository;

  LoginPage({Key key, @required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _email, _password, _errorMessage;
  bool _showError = false;
  bool _isLoading = false;
  final _controller = TextEditingController();
  final _focusNode = FocusNode();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Modal modal = new Modal();

  LoginBloc _loginBloc;

  UserRepository get _userRepository => widget._userRepository;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        _showError = false;
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
            child: Padding(
              padding:
                  const EdgeInsets.only(left: 28.0, right: 28.0, top: 160.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  buildFormCard(),
                  SizedBox(height: ScreenUtil.getInstance().setHeight(40)),
                  Row(
                    mainAxisAlignment: _isLoading
                        ? MainAxisAlignment.spaceBetween
                        : MainAxisAlignment.end,
                    children: <Widget>[
                      _isLoading
                          ? SizedBox(
                              height: 40,
                              width: 40,
                              child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    Color(0xFF17ead9)),
                              ))
                          : Text(''),
                      InkWell(
                        child: Container(
                          width: ScreenUtil.getInstance().setWidth(330),
                          height: ScreenUtil.getInstance().setHeight(100),
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [Color(0xFF17ead9), Color(0xFF6078ea)],
                              ),
                              borderRadius: BorderRadius.circular(6.0),
                              boxShadow: [
                                BoxShadow(
                                    color: Color(0xFF6078ea).withOpacity(.3),
                                    offset: Offset(0.0, 8.0),
                                    blurRadius: 8.0)
                              ]),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: signIn,
                              child: Center(
                                child: Text('SIGN IN',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'Poppins-Bold',
                                        fontSize: 18,
                                        letterSpacing: 1.0)),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
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
                          _showError = false;
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

  Container buildFormCard() {
    return Container(
      width: double.infinity,
      height: ScreenUtil.getInstance().setHeight(500),
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
          padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text("Login",
                  style: TextStyle(
                      fontSize: ScreenUtil.getInstance().setSp(45),
                      fontFamily: "Poppins-Bold",
                      letterSpacing: .6)),
              SizedBox(
                height: ScreenUtil.getInstance().setHeight(30),
              ),
              Text("Email",
                  style: TextStyle(
                      fontFamily: "Poppins-Medium",
                      fontSize: ScreenUtil.getInstance().setSp(26))),
              TextFormField(
                focusNode: _focusNode,
                onSaved: (input) => _email = input,
                decoration: InputDecoration(
                    hintText: "email",
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 12.0)),
              ),
              SizedBox(
                height: ScreenUtil.getInstance().setHeight(30),
              ),
              Text("Password",
                  style: TextStyle(
                      fontFamily: "Poppins-Medium",
                      fontSize: ScreenUtil.getInstance().setSp(26))),
              TextFormField(
                obscureText: true,
                onSaved: (input) => _password = input,
                decoration: InputDecoration(
                    hintText: "Password",
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 12.0)),
              ),
              SizedBox(
                height: ScreenUtil.getInstance().setHeight(35),
              ),
              Row(
                mainAxisAlignment: _showError
                    ? MainAxisAlignment.spaceBetween
                    : MainAxisAlignment.end,
                children: <Widget>[
                  _showError
                      ? Text("Error Occured!",
                          style: TextStyle(
                              fontFamily: "Poppins-Medium",
                              color: Colors.red,
                              fontSize: ScreenUtil.getInstance().setSp(26)))
                      : Text(''),
                  Text(
                    "Forgot Password?",
                    style: TextStyle(
                        color: Colors.blue,
                        fontFamily: "Poppins-Medium",
                        fontSize: ScreenUtil.getInstance().setSp(28)),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> signIn() async {
    final formState = _formKey.currentState;
    if (formState.validate()) {
      formState.save();
      try {
        setState(() {
          _showError = false;
          _isLoading = true;
        });

        AuthResult result = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: _email, password: _password);
        FirebaseUser user = result.user;
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Home(user)));
      } catch (e) {
        setState(() {
          _showError = true;
          _isLoading = false;
        });
        print(e.message);
      }
    }
  }

  @override
  void dispose() {
    _isLoading = false;
    super.dispose();
  }
}
