import 'package:flutter/material.dart';

class RegisterButton extends StatelessWidget {
  final VoidCallback _onPressed;

  const RegisterButton({Key key, VoidCallback onPressed})
      : _onPressed = onPressed,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70.0,
      height: 30.0,
      child: TextButton(
        onPressed: _onPressed,
        style: TextButton.styleFrom(
          backgroundColor: Color(0xFF5d74e3),
          disabledBackgroundColor: Colors.grey,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0)),
        ),
        child: Text('Next',
            style: TextStyle(fontFamily: 'Poppins-Bold', color: Colors.white)),
      ),
    );
  }
}
