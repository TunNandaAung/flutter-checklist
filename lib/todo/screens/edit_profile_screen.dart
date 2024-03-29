import 'package:firebase_auth/firebase_auth.dart';
import 'package:checklist/todo/modal/edit_password_modal.dart';
import 'package:flutter/material.dart';

typedef OnSaveCallback = Function(User user, String name, String email);
typedef OnPasswordChangedCallBack = Function(
    String currentPassword, String newPassword);

class EditProfileScreen extends StatefulWidget {
  final User user;
  final OnSaveCallback onSave;
  final OnPasswordChangedCallBack onPasswordChanged;

  const EditProfileScreen({
    Key? key,
    required this.user,
    required this.onSave,
    required this.onPasswordChanged,
  }) : super(key: key);

  @override
  EditProfileScreenState createState() => EditProfileScreenState();
}

class EditProfileScreenState extends State<EditProfileScreen> {
  late String _name;
  late String _email;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Theme.of(context).backgroundColor,
            Theme.of(context).canvasColor,
          ],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          tileMode: TileMode.clamp,
        ),
      ),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Form(
            key: _formKey,
            child: Stack(alignment: Alignment.center, children: <Widget>[
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
                          offset: const Offset(0, -30),
                        )
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
                    padding: const EdgeInsets.only(top: 60.0),
                    child: ListView(children: <Widget>[
                      Column(
                        children: <Widget>[
                          Container(
                            width: double.infinity,
                            height: null,
                            margin: const EdgeInsets.symmetric(horizontal: 22),
                            decoration: BoxDecoration(
                                color: Theme.of(context).cardColor,
                                borderRadius: BorderRadius.circular(8),
                                boxShadow: const [
                                  BoxShadow(
                                      color: Colors.black26,
                                      offset: Offset(0, 10),
                                      blurRadius: 30)
                                ]),
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 18.0, right: 12),
                                child: TextFormField(
                                  initialValue: widget.user.displayName,
                                  autofocus: false,
                                  validator: (val) {
                                    return val!.trim().isEmpty
                                        ? 'Please enter your name'
                                        : null;
                                  },
                                  onSaved: (value) => _name = value!,
                                  cursorColor: const Color(0xFF5d74e3),
                                  style: Theme.of(context).textTheme.headline1,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    suffixIcon:
                                        const Icon(Icons.person_outline),
                                    hintText: "Darth Vader",
                                    errorStyle: const TextStyle(
                                        fontFamily: 'Poppins-Medium'),
                                    hintStyle: Theme.of(context)
                                        .inputDecorationTheme
                                        .hintStyle,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 30.0),
                          Container(
                            width: double.infinity,
                            height: null,
                            margin: const EdgeInsets.symmetric(horizontal: 22),
                            decoration: BoxDecoration(
                                color: Theme.of(context).cardColor,
                                borderRadius: BorderRadius.circular(8),
                                boxShadow: const [
                                  BoxShadow(
                                      color: Colors.black26,
                                      offset: Offset(0, 10),
                                      blurRadius: 30)
                                ]),
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 18.0, right: 12),
                                child: TextFormField(
                                  initialValue: widget.user.email,
                                  onSaved: (value) => _email = value!,
                                  validator: (val) {
                                    return val!.trim().isEmpty
                                        ? 'Please enter your email'
                                        : null;
                                  },
                                  cursorColor: const Color(0xFF5d74e3),
                                  style: Theme.of(context).textTheme.headline1,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    suffixIcon:
                                        const Icon(Icons.alternate_email),
                                    hintText: "you@example.com",
                                    errorStyle: const TextStyle(
                                        fontFamily: 'Poppins-Medium'),
                                    hintStyle: Theme.of(context)
                                        .inputDecorationTheme
                                        .hintStyle,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 30.0),
                          InkWell(
                            onTap: () {
                              EditPasswordModal().mainBottomSheet(
                                  context: context,
                                  // onSave: (currentPassword, newPassword) {
                                  //   context.read<ProfileBloc>().add(
                                  //     ChangePassword(widget.user,
                                  //         currentPassword, newPassword),
                                  //   );
                                  // }
                                  onSave: widget.onPasswordChanged);
                            },
                            child: Container(
                              width: double.infinity,
                              height: 60,
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 22),
                              decoration: BoxDecoration(
                                  color: Theme.of(context).cardColor,
                                  borderRadius: BorderRadius.circular(8),
                                  boxShadow: const [
                                    BoxShadow(
                                        color: Colors.black26,
                                        offset: Offset(0, 10),
                                        blurRadius: 30)
                                  ]),
                              child: Center(
                                child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 18.0, right: 20),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text(
                                          'Change Password',
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline1,
                                        ),
                                        const Icon(
                                          Icons.arrow_forward_ios,
                                          color: Color(0xFF5d74e3),
                                        )
                                      ],
                                    )),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ]),
                  ),
                ),
              ),
              Positioned(
                top: 35.0,
                right: 30.0,
                height: 40.0,
                child: TextButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      widget.onSave(widget.user, _name, _email);
                      Navigator.of(context).pop();
                    }
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: Theme.of(context)
                        .floatingActionButtonTheme
                        .backgroundColor,
                    disabledBackgroundColor: Colors.grey,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(0.0),
                    child: Text('Update',
                        style: TextStyle(
                            fontFamily: 'Poppins-Bold',
                            fontSize: 15.0,
                            color: Color(0xFF5d74e3))),
                  ),
                ),
              ),
              Positioned(
                  top: 35.0,
                  left: 30.0,
                  child: Container(
                    height: 40.0,
                    decoration: BoxDecoration(
                        color: Theme.of(context)
                            .floatingActionButtonTheme
                            .backgroundColor,
                        borderRadius: BorderRadius.circular(20.0),
                        boxShadow: [
                          BoxShadow(
                              color: Theme.of(context).highlightColor,
                              offset: const Offset(0.0, 8.0),
                              blurRadius: 8.0)
                        ]),
                    child: RawMaterialButton(
                      child: const Text(
                        'Cancel',
                        style: TextStyle(
                            color: Colors.white,
                            decoration: TextDecoration.none,
                            fontFamily: 'Poppins-Medium',
                            fontSize: 15.0),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
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
              ),
              Positioned(
                  top: 100.0,
                  right: 160.0,
                  child: GestureDetector(
                    onTap: () {},
                    child: Container(
                        width: 30,
                        height: 30,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: Colors.white),
                        child: const Icon(
                          Icons.camera_alt,
                          color: Color(0xFF5d74e3),
                        )),
                  ))
            ]),
          )),
    );
  }
}
