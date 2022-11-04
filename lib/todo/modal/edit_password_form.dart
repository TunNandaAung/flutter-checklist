import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

typedef OnSaveCallback = Function(String currentPassword, String newPassword);

class EditPasswordForm extends StatefulWidget {
  final OnSaveCallback onSave;
  const EditPasswordForm({Key? key, required this.onSave}) : super(key: key);

  @override
  EditPasswordFormState createState() => EditPasswordFormState();
}

class EditPasswordFormState extends State<EditPasswordForm> {
  late String _currentPassword;
  late String _newPassword;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 0),
      child: Container(
        height: 600,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          boxShadow: [
            BoxShadow(
                color: Theme.of(context).highlightColor,
                offset: const Offset(3.0, 6.0),
                blurRadius: 10.0)
          ],
          color: Theme.of(context).bottomSheetTheme.backgroundColor,
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(left: 22.0),
                              child: GestureDetector(
                                onTap: () => Navigator.of(context).pop(),
                                child: const Text("Cancel",
                                    style: TextStyle(
                                        fontFamily: "Poppins-Medium",
                                        fontSize: 18.0,
                                        color: Color(0xFF5d74e3))),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 22.0),
                              child: TextButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    _formKey.currentState!.save();

                                    widget.onSave(
                                        _currentPassword, _newPassword);
                                    int count = 0;
                                    Navigator.of(context)
                                        .popUntil((_) => count++ >= 2);
                                  }
                                },
                                style: TextButton.styleFrom(
                                  backgroundColor:
                                      Theme.of(context).primaryColorLight,
                                  disabledBackgroundColor: Colors.grey,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50.0),
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(0.0),
                                  child: Text(
                                    'Update',
                                    style: Theme.of(context).textTheme.button,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16.0),
                        Container(
                          width: double.infinity,
                          height: null,
                          margin: const EdgeInsets.symmetric(horizontal: 22),
                          decoration: BoxDecoration(
                              color: Theme.of(context).cardColor,
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: [
                                BoxShadow(
                                    color: Theme.of(context).highlightColor,
                                    offset: const Offset(0, 10),
                                    blurRadius: 30)
                              ]),
                          child: Center(
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 18.0, right: 12),
                              child: TextFormField(
                                //initialValue:
                                autofocus: true,
                                obscureText: true,
                                validator: (val) {
                                  return val!.trim().isEmpty
                                      ? 'Please enter your password'
                                      : null;
                                },
                                onSaved: (value) => _currentPassword = value!,
                                cursorColor: const Color(0xFF5d74e3),
                                style: Theme.of(context).textTheme.headline1,
                                decoration: InputDecoration(
                                  suffixIcon:
                                      const Icon(MdiIcons.formTextboxPassword),
                                  hintText: "Current Password",
                                  errorStyle: const TextStyle(
                                    fontFamily: 'Poppins-Medium',
                                  ),
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
                              boxShadow: [
                                BoxShadow(
                                    color: Theme.of(context).highlightColor,
                                    offset: const Offset(0, 10),
                                    blurRadius: 30)
                              ]),
                          child: Center(
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 18.0, right: 12),
                              child: SingleChildScrollView(
                                child: TextFormField(
                                  obscureText: true,
                                  onSaved: (value) => _newPassword = value!,
                                  autofocus: false,
                                  validator: (val) {
                                    return val!.trim().isEmpty
                                        ? 'Please enter new password'
                                        : null;
                                  },
                                  cursorColor: const Color(0xFF5d74e3),
                                  style: Theme.of(context).textTheme.headline1,
                                  decoration: InputDecoration(
                                    hintText: "New Password",
                                    suffixIcon: const Icon(MdiIcons.key),
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
                        ),
                        const SizedBox(
                          height: 35,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
