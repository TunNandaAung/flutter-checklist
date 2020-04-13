import 'package:checklist/authentication_bloc/bloc.dart';
import 'package:checklist/login/bloc/login_barrel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class VerifyOtpForm extends StatefulWidget {
  final String phoneNumber;
  VerifyOtpForm({Key key, this.phoneNumber}) : super(key: key);

  @override
  _VerifyOtpFormState createState() => _VerifyOtpFormState();
}

class _VerifyOtpFormState extends State<VerifyOtpForm> {
  final TextEditingController _otpController = TextEditingController();

  LoginBloc _loginBloc;

  bool _enable = true;

  bool get isPopulated => _otpController.text.isNotEmpty;

  // bool isRegisterButtonEnabled(RegisterState state) {
  //   return state.isFormValid && isPopulated && !state.isSubmitting;
  // }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _loginBloc = BlocProvider.of<LoginBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil.getInstance()..init(context);
    ScreenUtil.instance =
        ScreenUtil(width: 750, height: 1250, allowFontScaling: true);
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.isSubmitting) {
          Scaffold.of(context)
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
                      'Verifying....',
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
          BlocProvider.of<AuthenticationBloc>(context).add(LoggedIn());
          int count = 0;
          Navigator.of(context).popUntil((_) => count++ >= 3);
        }
        if (state.isFailure) {
          Scaffold.of(context)
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
                      'Failed to verify OTP!',
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
      child: BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
        return SingleChildScrollView(
          reverse: true,
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
                                    _loginBloc.add(ResetLoginEvent());
                                    Navigator.pop(context);
                                  },
                                  child: Icon(
                                    Icons.arrow_back_ios,
                                    color: Color(0xFF5d74e3),
                                  ),
                                ),
                              ]),
                          SizedBox(
                            height: 5.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text("OTP Verification",
                                  style: TextStyle(
                                    fontSize:
                                        ScreenUtil.getInstance().setSp(42),
                                    fontFamily: "Poppins-Bold",
                                    letterSpacing: .6,
                                    color: Colors.white,
                                  )),
                            ],
                          ),
                          SizedBox(
                            height: ScreenUtil.getInstance().setHeight(80),
                          ),
                          Container(
                            height: ScreenUtil.getInstance().setHeight(270),
                            child: SvgPicture.asset(
                              'assets/verify_otp.svg',
                            ),
                          ),
                          SizedBox(
                            height: ScreenUtil.getInstance().setHeight(30),
                          ),
                          Center(
                            child: Text(
                              'A SMS with 6 digits verification code \nhas been sent to +95 0${widget.phoneNumber}',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 15.0),
                            ),
                          ),
                          SizedBox(
                            height: ScreenUtil.getInstance().setHeight(30),
                          ),
                          Container(
                            width: double.infinity,
                            height: null,
                            margin: EdgeInsets.symmetric(horizontal: 22),
                            decoration: BoxDecoration(
                                color: Color(0xFF2d3447),
                                borderRadius: BorderRadius.circular(8),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black26,
                                      offset: Offset(0, 10),
                                      blurRadius: 30)
                                ]),
                            child: Center(
                              child: Padding(
                                padding: EdgeInsets.only(left: 18.0, right: 12),
                                child: TextFormField(
                                  controller: _otpController,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: <TextInputFormatter>[
                                    LengthLimitingTextInputFormatter(6),
                                  ],
                                  validator: (val) {
                                    return val.trim().isEmpty
                                        ? 'Please enter some text'
                                        : null;
                                  },

                                  //onSaved: (value) => _task = value,
                                  cursorColor: Color(0xFF5d74e3),
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Poppins-Medium',
                                      fontSize: 21.0),
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    suffixIcon: Icon(Icons.sms),
                                    hintText: "123456",
                                    errorStyle: TextStyle(
                                      fontFamily: 'Poppins-Medium',
                                    ),
                                    hintStyle: TextStyle(
                                        fontFamily: 'Poppins-Medium',
                                        color: Colors.white30,
                                        fontSize: 21.0),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: ScreenUtil.getInstance().setHeight(30),
                          ),
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                InkWell(
                                  child: Container(
                                    width:
                                        ScreenUtil.getInstance().setWidth(200),
                                    height:
                                        ScreenUtil.getInstance().setHeight(80),
                                    decoration: BoxDecoration(
                                        gradient: _enable
                                            ? LinearGradient(
                                                colors: [
                                                  Color(0xFF17ead9),
                                                  Color(0xFF6078ea)
                                                ],
                                              )
                                            : LinearGradient(
                                                colors: [
                                                  Colors.grey,
                                                  Colors.grey
                                                ],
                                              ),
                                        borderRadius:
                                            BorderRadius.circular(30.0),
                                        boxShadow: [
                                          BoxShadow(
                                              color: Color(0xFF6078ea)
                                                  .withOpacity(.3),
                                              offset: Offset(0.0, 8.0),
                                              blurRadius: 8.0)
                                        ]),
                                    child: Material(
                                      color: Colors.transparent,
                                      child: InkWell(
                                        onTap: _onFormSubmitted,
                                        child: Center(
                                          child: Text('Verify',
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
                          ),
                          SizedBox(
                            height: ScreenUtil.getInstance().setHeight(30),
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
    _otpController.dispose();
    super.dispose();
  }

  void _onFormSubmitted() {
    _loginBloc.add(
      VerifyOtpEvent(otp: _otpController.text),
    );
  }
}
