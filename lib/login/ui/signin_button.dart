import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SigninButton extends StatelessWidget {
  final bool enable;
  final VoidCallback? onTap;

  const SigninButton({Key? key, required this.enable, this.onTap})
      : super(key: key);

  final bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          _isLoading ? MainAxisAlignment.spaceBetween : MainAxisAlignment.end,
      children: <Widget>[
        _isLoading
            ? const SizedBox(
                height: 40,
                width: 40,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF17ead9)),
                ))
            : const Text(''),
        InkWell(
          child: Container(
            width: ScreenUtil().setWidth(330),
            height: ScreenUtil().setHeight(100),
            decoration: BoxDecoration(
                gradient: enable
                    ? const LinearGradient(
                        colors: [Color(0xFF17ead9), Color(0xFF6078ea)],
                      )
                    : const LinearGradient(
                        colors: [Colors.grey, Colors.grey],
                      ),
                borderRadius: BorderRadius.circular(6.0),
                boxShadow: [
                  enable
                      ? BoxShadow(
                          color: const Color(0xFF6078ea).withOpacity(.3),
                          offset: const Offset(0.0, 8.0),
                          blurRadius: 8.0)
                      : const BoxShadow()
                ]),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: onTap,
                child: const Center(
                  child: Text('SIGN IN',
                      style: TextStyle(
                          color: Colors.white,
                          decoration: TextDecoration.none,
                          fontFamily: 'Poppins-Bold',
                          fontSize: 18,
                          letterSpacing: 1.0)),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
