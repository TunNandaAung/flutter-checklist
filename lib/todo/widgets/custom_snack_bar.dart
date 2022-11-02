import 'package:flutter/material.dart';

class CustomSnackBar {
  static SnackBar showActionSnackBar({
    Duration? duration,
    required IconData icon,
    Color? iconColor,
    required String title,
    required Color backgroundColor,
    required String actionLabel,
    required Function() onActionPressed,
  }) {
    return SnackBar(
      duration: duration ?? Duration(seconds: 30),
      elevation: 6.0,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(
            icon,
            color: iconColor ?? Colors.white,
          ),
          SizedBox(
            width: 8.0,
          ),
          Text(
            title,
            style: TextStyle(fontFamily: 'Poppins-Bold'),
          ),
        ],
      ),
      backgroundColor: backgroundColor,
      action: SnackBarAction(
        label: 'Dismiss',
        textColor: Colors.white,
        onPressed: onActionPressed,
      ),
    );
  }
}
