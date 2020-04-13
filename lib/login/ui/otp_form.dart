import 'package:checklist/login/bloc/login_barrel.dart';
import 'package:checklist/login/ui/verify_otp_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OtpForm extends StatefulWidget {
  OtpForm({Key key}) : super(key: key);

  @override
  _OtpFormState createState() => _OtpFormState();
}

class _OtpFormState extends State<OtpForm> {
  final TextEditingController _phoneNumberController = TextEditingController();
  String phoneNumber;

  LoginBloc _loginBloc;

  bool _enable = true;

  bool get isPopulated => _phoneNumberController.text.isNotEmpty;

  bool isSendButtonEnabled(LoginState state) {
    return state.isPhoneValid && isPopulated && !state.isSubmitting;
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _loginBloc = BlocProvider.of<LoginBloc>(context);
    _phoneNumberController.addListener(_onphoneNumberChanged);
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil.getInstance()..init(context);
    ScreenUtil.instance =
        ScreenUtil(width: 750, height: 1250, allowFontScaling: true);
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
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
                      'Error sending OTP!',
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
                      'Sending OTP.',
                      style: TextStyle(fontFamily: 'Poppins-Bold'),
                    ),
                    CircularProgressIndicator(),
                  ],
                ),
              ),
            );
          CircularProgressIndicator();
        }
        if (state.isOtpSent) {
          Scaffold.of(context)..hideCurrentSnackBar();
          Navigator.of(context).push(
            CupertinoPageRoute(
              builder: (_) =>
                  VerifyOtpScreen(phoneNumber: _phoneNumberController.text),
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
                              Text("Verify Your Number",
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
                              'assets/otp_screen.svg',
                            ),
                          ),
                          SizedBox(
                            height: ScreenUtil.getInstance().setHeight(30),
                          ),
                          Center(
                            child: Text(
                              'A SMS with verification code \nwill be sent to this number',
                              style: TextStyle(
                                  color: Colors.white60, fontSize: 15.0),
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
                                  controller: _phoneNumberController,
                                  keyboardType: TextInputType.phone,
                                  validator: (_) {
                                    if (!state.isPhoneValid) {
                                      return ('Invalid Phone Number');
                                    }
                                    return null;
                                  },

                                  //onSaved: (value) => _task = value,
                                  cursorColor: Color(0xFF5d74e3),
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Poppins-Medium',
                                      fontSize: 21.0),
                                  decoration: InputDecoration(
                                    prefixText: '+95 ',
                                    border: InputBorder.none,
                                    suffixIcon: Icon(Icons.phone),
                                    hintText: "9 123456789",
                                    errorStyle: TextStyle(
                                      color: Colors.red,
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
                                      gradient: isSendButtonEnabled(state)
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
                                      borderRadius: BorderRadius.circular(30.0),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Color(0xFF6078ea)
                                                .withOpacity(.3),
                                            offset: Offset(0.0, 8.0),
                                            blurRadius: 8.0)
                                      ],
                                    ),
                                    child: Material(
                                      color: Colors.transparent,
                                      child: InkWell(
                                        onTap: _onFormSubmitted,
                                        child: Center(
                                          child: Text(
                                            'Send',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontFamily: 'Poppins-Bold',
                                                fontSize: 18,
                                                letterSpacing: 1.0),
                                          ),
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
    _phoneNumberController.dispose();
    super.dispose();
  }

  void _onphoneNumberChanged() {
    _loginBloc.add(
      PhoneChanged(phone: '+950' + _phoneNumberController.text),
    );
  }

  void _onFormSubmitted() {
    _loginBloc.add(
      SendOTPPressed(
        phoneNumber: '+950' + _phoneNumberController.text,
      ),
    );
  }
}
