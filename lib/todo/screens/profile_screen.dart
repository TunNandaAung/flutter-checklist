import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  Profile({Key key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Stack(alignment: Alignment.center, children: <Widget>[
      Padding(
        padding: const EdgeInsets.only(
            top: 45.0, left: 20.0, right: 20, bottom: 10.0),
        child: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    color: Colors.black54,
                    blurRadius: 30.0,
                    offset: Offset(0, 10))
              ],
              color: Color(0xFF2d3447),
              borderRadius: BorderRadius.circular(30.0)),
          child: Padding(
            padding: EdgeInsets.only(top: 60.0),
            child: Column(
              children: <Widget>[
                Text('Darth Vader',
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Poppins-Bold',
                        fontSize: 25.0)),
                Text('vader@sithlord.com',
                    style: TextStyle(
                        color: Colors.white54,
                        fontFamily: 'Poppins-Bold',
                        fontSize: 15.0)),
              ],
            ),
          ),
        ),
      ),
      Positioned(
          top: 0.0,
          right: 35.0,
          child: Container(
            width: 50.0,
            height: 50.0,
            decoration: BoxDecoration(
                color: Colors.black.withOpacity(.25),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                      color: Colors.black54.withOpacity(.3),
                      offset: Offset(0.0, 8.0),
                      blurRadius: 8.0)
                ]),
            child: RawMaterialButton(
              shape: CircleBorder(),
              child: Icon(
                Icons.edit,
                size: 25.0,
                color: Colors.white,
              ),
              onPressed: () {},
            ),
          )),
      Positioned(
        top: 5.0,
        child: Container(
          width: 90.0,
          height: 90.0,
          decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                    color: Colors.black54,
                    blurRadius: 30.0,
                    offset: Offset(0, 10))
              ],
              image: DecorationImage(
                  image: AssetImage('assets/Darth-Vader-Avatar.png'))),
        ),
      )
    ]);
  }
}
