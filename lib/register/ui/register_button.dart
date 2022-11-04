import 'package:flutter/material.dart';

class RegisterButton extends StatelessWidget {
  final VoidCallback? onPressed;

  const RegisterButton({Key? key, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 70.0,
      height: 30.0,
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          padding: const EdgeInsets.all(3.0),
          backgroundColor: const Color(0xFF5d74e3),
          disabledBackgroundColor: Colors.grey,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0)),
        ),
        child: const Text(
          'Next',
          style: TextStyle(fontFamily: 'Poppins-Bold', color: Colors.white),
        ),
      ),
    );
  }
}
