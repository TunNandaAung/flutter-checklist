import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  final String image;
  final String text;

  const Header({Key key, this.image, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: MyClipper(),
      child: Container(
        padding: EdgeInsets.only(left: 20.0, top: 90.0, right: 20.0),
        height: 350,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Color(0xFF36D1DC),
              Color(0xFF5B86E5),
            ],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                image != null
                    ? Image.asset(
                        image,
                        width: 64.0,
                        fit: BoxFit.fitWidth,
                        alignment: Alignment.topCenter,
                      )
                    : Text(''),
                text != null
                    ? Text(
                        '$text',
                        style: Theme.of(context)
                            .textTheme
                            .title
                            .copyWith(fontSize: 30.0),
                      )
                    : Text(''),
                Container(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = new Path();

    path.lineTo(0.0, size.height - 80);
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height - 80);
    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
