import 'package:firebase_auth/firebase_auth.dart';
import 'package:checklist/authentication_bloc/bloc.dart';
import 'package:checklist/preferences/preferences.dart';
import 'package:checklist/profile_bloc/profile_barrel.dart';
import 'package:checklist/theme/app_theme.dart';
import 'package:checklist/theme/bloc/theme_barrel.dart';
import 'package:checklist/todo/widgets/loading_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'edit_profile_screen.dart';

class Profile extends StatefulWidget {
  final FirebaseUser user;

  Profile({Key key, this.user}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> with SingleTickerProviderStateMixin {
  AnimationController animController;
  Animation<Offset> animation;
  int themeIndex = 1;
  double _scale;

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    animController = AnimationController(
        vsync: this,
        duration: Duration(
          milliseconds: 200,
        ),
        lowerBound: 0.0,
        upperBound: 0.1)
      ..addListener(() {
        setState(() {});
      });

    // final curvedAnimation = CurvedAnimation(
    //   parent: animController,
    //   curve: Curves.decelerate,
    // );

    // animation = Tween<Offset>(begin: Offset.zero, end: Offset(0.0, -1.0))
    //     .animate(curvedAnimation)
    //       ..addListener(() {
    //         setState(() {});
    //       });
    //       ..addStatusListener((status) {
    //         if (status == AnimationStatus.completed) {
    //           animController.reverse();
    //         } else if (status == AnimationStatus.dismissed) {
    //           animController.forward();
    //         }
    //       });

    // animController.forward();
    super.initState();
  }

  @override
  void dispose() {
    animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    void _onThemeDarkTapUp(TapUpDetails details) {
      animController.forward();
      BlocProvider.of<ThemeBloc>(context).add(ThemeChanged(AppTheme.Dark));
    }

    void _onThemeDarkTapDown(TapDownDetails details) {
      animController.reverse();
    }

    void _onThemeLightTapUp(TapUpDetails details) {
      animController.forward();
      BlocProvider.of<ThemeBloc>(context).add(ThemeChanged(AppTheme.Light));
    }

    void _onThemeLightTapDown(TapDownDetails details) {
      animController.reverse();
    }

    _scale = 1 - animController.value;
    return BlocListener<ProfileBloc, ProfileState>(
      listener: (context, state) {
        if (state is PasswordChanged) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                elevation: 6.0,
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                //backgroundColor: Color(0xFF2d3447),
                backgroundColor: Color(0xFF5d74e3),
                duration: Duration(seconds: 2),
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Password Successfully Changed!',
                      style: TextStyle(fontFamily: 'Poppins-Bold'),
                    ),
                  ],
                ),
              ),
            );
        } else if (state is ProfileNotUpdated) {
          if (state.error.trim().length != 0) {
            _scaffoldKey.currentState.showSnackBar(
              SnackBar(
                elevation: 6.0,
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                //backgroundColor: Color(0xFF2d3447),
                backgroundColor: Colors.red,
                duration: Duration(seconds: 2),
                content: Container(
                  height: null,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          state.error,
                          style: TextStyle(fontFamily: 'Poppins-Bold'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
        }
      },
      child: Scaffold(
        key: _scaffoldKey,
        body: BlocBuilder<ProfileBloc, ProfileState>(builder: (context, state) {
          if (state is ProfileLoaded) {
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
                            color: Colors.black38,
                            blurRadius: 30.0,
                            offset: Offset(0, -30))
                      ],
                      gradient: LinearGradient(
                          colors: [
                            Theme.of(context).backgroundColor,
                            Theme.of(context).canvasColor,
                          ],
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          tileMode: TileMode.clamp),
                      borderRadius: BorderRadius.circular(30.0)),
                  child: Padding(
                    padding: EdgeInsets.only(top: 60.0),
                    child: Column(
                      children: <Widget>[
                        Text(
                            state.user == null || state.user.displayName == null
                                ? 'No Name'
                                : state.user.displayName,
                            style: Theme.of(context).textTheme.headline),
                        Text(
                            state.user == null || state.user.email == null
                                ? 'No Email'
                                : state.user.email,
                            style: Theme.of(context).textTheme.display3),
                        Transform.translate(
                          offset: Offset(0.0,
                              -1 * MediaQuery.of(context).viewInsets.bottom),
                          child: Padding(
                            padding: EdgeInsets.only(top: 50.0),
                            child: Container(
                              width: 50.0,
                              height: 50.0,
                              child: Prefer.prefs.getInt('theme') == 0
                                  ? GestureDetector(
                                      onTapUp: _onThemeDarkTapUp,
                                      onTapDown: _onThemeDarkTapDown,
                                      // onTap: () {
                                      //   animController.forward();
                                      //   BlocProvider.of<ThemeBloc>(context)
                                      //       .add(ThemeChanged(
                                      //           AppTheme.Dark));
                                      // },
                                      child: Transform.scale(
                                        scale: _scale,
                                        child: Image(
                                          image: AssetImage(
                                              'assets/btn_icon/btn-moon-96.png'),
                                          height: 50,
                                          width: 50,
                                        ),
                                      ),
                                    )
                                  : GestureDetector(
                                      onTapUp: _onThemeLightTapUp,
                                      onTapDown: _onThemeLightTapDown,
                                      // onTap: () {
                                      //   animController.reverse();
                                      //   BlocProvider.of<ThemeBloc>(context)
                                      //       .add(ThemeChanged(AppTheme.Light));
                                      // },
                                      child: Transform.scale(
                                        scale: _scale,
                                        child: Image(
                                          image: AssetImage(
                                              'assets/btn_icon/btn-sun-128.png'),
                                          height: 50,
                                          width: 50,
                                        ),
                                      ),
                                    ),
                            ),
                          ),
                        )
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
                        color: Theme.of(context)
                            .floatingActionButtonTheme
                            .backgroundColor,
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
                      onPressed: () {
                        Navigator.of(context).push(CupertinoPageRoute(
                            builder: (_) => EditProfileScreen(
                                  user: state.user,
                                  onSave: (user, name, email) {
                                    BlocProvider.of<ProfileBloc>(context).add(
                                      UpdateProfile(user, name, email),
                                    );
                                  },
                                  onPasswordChanged:
                                      (currentPassword, newPassword) {
                                    BlocProvider.of<ProfileBloc>(context).add(
                                      ChangePassword(widget.user,
                                          currentPassword, newPassword),
                                    );
                                  },
                                )));
                      },
                    ),
                  )),
              Positioned(
                  top: 45.0,
                  left: 35.0,
                  child: Container(
                    width: 50.0,
                    height: 50.0,
                    decoration: BoxDecoration(
                        color: Theme.of(context)
                            .floatingActionButtonTheme
                            .backgroundColor,
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
          if (state is ProfileLoading) {
            return Center(
                child: Container(
                    width: 300.0,
                    height: 100.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: Theme.of(context)
                          .floatingActionButtonTheme
                          .backgroundColor,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        LoadingIndicator(),
                        SizedBox(height: 9.0),
                        Text(
                          'Updating Your Profile',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15.0,
                              fontFamily: 'Poppins-Bold'),
                        )
                      ],
                    )));
          }
          return Container();
        }),
      ),
    );
  }
}
