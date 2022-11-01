import 'package:flutter/material.dart';

class CircularCheckbox extends StatelessWidget {
  final bool value;
  final void Function(bool?)? onChanged;
  final Color? activeColor;

  const CircularCheckbox({
    Key? key,
    required this.value,
    required this.onChanged,
    this.activeColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      checkColor: this.activeColor ?? Color(0xFF17ead9),
      // fillColor: MaterialStateProperty.resolveWith(getColor),
      value: value,
      shape: CircleBorder(),
      onChanged: onChanged,
    );
  }
}
