import 'package:checklist/theme/cubit/theme_cubit.dart';
import 'package:checklist/todo/widgets/custom_snack_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:checklist/authentication_bloc/bloc.dart';
import 'package:checklist/preferences/preferences.dart';
import 'package:checklist/profile_bloc/profile_bloc.dart';
import 'package:checklist/theme/app_theme.dart';
import 'package:checklist/todo/widgets/loading_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'edit_profile_screen.dart';

class ProfileScreen extends StatefulWidget {
  final User user;

  const ProfileScreen({Key? key, required this.user}) : super(key: key);

  @override
  ProfileScreenState createState() => ProfileScreenState();
}

class ProfileScreenState extends State<ProfileScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController animController;
  late Animation<Offset> animation;
  int themeIndex = 1;
  late double _scale;

  final _scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

  @override
  void initState() {
    animController = AnimationController(
        vsync: this,
        duration: const Duration(
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
    void onThemeDarkTapUp(TapUpDetails details) {
      animController.forward();
      context.read<ThemeCubit>().changeTheme(AppTheme.Dark);
    }

    void onThemeDarkTapDown(TapDownDetails details) {
      animController.reverse();
    }

    void onThemeLightTapUp(TapUpDetails details) {
      animController.forward();
      context.read<ThemeCubit>().changeTheme(AppTheme.Light);
    }

    void onThemeLightTapDown(TapDownDetails details) {
      animController.reverse();
    }

    _scale = 1 - animController.value;
    return BlocListener<ProfileBloc, ProfileState>(
      listener: (context, state) {
        if (state is PasswordChanged) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              CustomSnackBar.show(
                title: 'Password Successfully Changed!',
                icon: const Icon(Icons.check),
              ),
            );
        } else if (state is ProfileNotUpdated) {
          if (state.error.trim().isNotEmpty) {
            _scaffoldMessengerKey.currentState!.showSnackBar(
              SnackBar(
                elevation: 6.0,
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                //backgroundColor: Color(0xFF2d3447),
                backgroundColor: Colors.red,
                duration: const Duration(seconds: 2),
                content: SizedBox(
                  height: null,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          state.error,
                          style: const TextStyle(fontFamily: 'Poppins-Bold'),
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
        key: _scaffoldMessengerKey,
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
                            color: Theme.of(context).highlightColor,
                            blurRadius: 30.0,
                            offset: const Offset(0, -30))
                      ],
                      gradient: Prefer.prefs.getInt('theme') == 0
                          ? LinearGradient(
                              colors: [
                                  Theme.of(context).backgroundColor,
                                  Theme.of(context).canvasColor,
                                ],
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                              tileMode: TileMode.clamp)
                          : null,
                      color: Prefer.prefs.getInt('theme') == 1
                          ? Theme.of(context).cardColor.withOpacity(0.4)
                          : null,
                      borderRadius: BorderRadius.circular(30.0)),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 60.0),
                    child: Column(
                      children: <Widget>[
                        Text(
                            state.user.displayName == null
                                ? 'No Name'
                                : state.user.displayName!,
                            style: Theme.of(context).textTheme.headline5),
                        Text(
                            state.user.email == null
                                ? 'No Email'
                                : state.user.email!,
                            style: Theme.of(context).textTheme.headline2),
                        Transform.translate(
                          offset: Offset(0.0,
                              -1 * MediaQuery.of(context).viewInsets.bottom),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 50.0),
                            child: SizedBox(
                              width: 50.0,
                              height: 50.0,
                              child: Prefer.prefs.getInt('theme') == 0
                                  ? GestureDetector(
                                      onTapUp: onThemeDarkTapUp,
                                      onTapDown: onThemeDarkTapDown,
                                      // onTap: () {
                                      //   animController.forward();
                                      //   context.read<ThemeBloc>()
                                      //       .add(ThemeChanged(
                                      //           AppTheme.Dark));
                                      // },
                                      child: Transform.scale(
                                        scale: _scale,
                                        child: const Image(
                                          image: AssetImage(
                                              'assets/btn_icon/btn-moon-96.png'),
                                          height: 50,
                                          width: 50,
                                        ),
                                      ),
                                    )
                                  : GestureDetector(
                                      onTapUp: onThemeLightTapUp,
                                      onTapDown: onThemeLightTapDown,
                                      // onTap: () {
                                      //   animController.reverse();
                                      //   context.read<ThemeBloc>()
                                      //       .add(ThemeChanged(AppTheme.Light));
                                      // },
                                      child: Transform.scale(
                                        scale: _scale,
                                        child: const Image(
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
                              color: Theme.of(context).highlightColor,
                              offset: const Offset(0.0, 8.0),
                              blurRadius: 8.0)
                        ]),
                    child: RawMaterialButton(
                      shape: const CircleBorder(),
                      child: const Icon(
                        Icons.edit,
                        size: 25.0,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.of(context).push(CupertinoPageRoute(
                            builder: (_) => EditProfileScreen(
                                  user: state.user,
                                  onSave: (user, name, email) {
                                    context.read<ProfileBloc>().add(
                                          UpdateProfile(user, name, email),
                                        );
                                  },
                                  onPasswordChanged:
                                      (currentPassword, newPassword) {
                                    context.read<ProfileBloc>().add(
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
                              color: Theme.of(context).highlightColor,
                              offset: const Offset(0.0, 8.0),
                              blurRadius: 8.0)
                        ]),
                    child: RawMaterialButton(
                      shape: const CircleBorder(),
                      child: const Icon(
                        Icons.exit_to_app,
                        size: 25.0,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        context.read<AuthenticationBloc>().add(
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
                            color: Theme.of(context).highlightColor,
                            blurRadius: 30.0,
                            offset: const Offset(0, 10))
                      ],
                      image: const DecorationImage(
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
                      children: const <Widget>[
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
