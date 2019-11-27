import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_integrations/authentication_bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Profile extends StatefulWidget {
  final FirebaseUser user;

  Profile({Key key, this.user}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Stack(alignment: Alignment.center, children: <Widget>[
      Padding(
        // padding: const EdgeInsets.only(
        //     top: 45.0, left: 20.0, right: 20, bottom: 10.0),
        padding: const EdgeInsets.only(top: kToolbarHeight + 45),
        child: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    color: Colors.black54,
                    blurRadius: 30.0,
                    offset: Offset(0, -30))
              ],
              gradient: LinearGradient(
                  colors: [
                    Color(0xFF1b1e44),
                    Color(0xFF2d3447),
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  tileMode: TileMode.clamp),
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
                Text(widget.user.email,
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
          top: 45.0,
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
          top: 45.0,
          left: 35.0,
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
                Icons.exit_to_app,
                size: 25.0,
                color: Colors.white,
              ),
              onPressed: () {
                BlocProvider.of<AuthenticationBloc>(context).add(
                  LoggedOut(),
                );
              },
            ),
          )),
      Positioned(
        top: 45.0,
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
