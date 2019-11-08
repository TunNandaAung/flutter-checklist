import 'package:flutter/material.dart';

class SocialIcon extends StatelessWidget {
  final List<Color> colors;
  final IconData iconData;
  final Function onPressed;

  SocialIcon({this.colors, this.iconData, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return new Padding(
      padding: EdgeInsets.only(left: 14.0),
      child: Container(
        width: 40.0,
        height: 40.0,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(colors: colors, tileMode: TileMode.clamp)),
        child: RawMaterialButton(
          shape: CircleBorder(),
          onPressed: onPressed,
          child: Center(
            child: Icon(
              iconData,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
