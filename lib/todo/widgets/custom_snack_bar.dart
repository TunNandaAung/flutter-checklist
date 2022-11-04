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
      duration: duration ?? const Duration(seconds: 30),
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
          const SizedBox(
            width: 8.0,
          ),
          Text(
            title,
            style: const TextStyle(fontFamily: 'Poppins-Bold'),
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

  static SnackBar show({
    required String title,
    Color? backgroundColor,
    Widget? icon,
  }) {
    return SnackBar(
      elevation: 6.0,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      backgroundColor: backgroundColor ?? const Color(0xFF5d74e3),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(fontFamily: 'Poppins-Bold'),
          ),
          icon ?? const SizedBox()
        ],
      ),
    );
  }
}
