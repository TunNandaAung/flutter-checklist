import 'package:flutter/material.dart';

class RegisterButton extends StatelessWidget {
  final VoidCallback _onPressed;

  const RegisterButton({Key key, VoidCallback onPressed})
      : _onPressed = onPressed,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: _onPressed,
      color: Color(0xFF5d74e3),
      disabledColor: Colors.grey,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      child: Text('Sign Up',
          style: TextStyle(fontFamily: 'Poppins-Bold', color: Colors.white)),
    );
  }
}
