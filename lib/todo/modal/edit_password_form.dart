import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class EditPasswordForm extends StatefulWidget {
  EditPasswordForm({Key key}) : super(key: key);

  @override
  _EditPasswordFormState createState() => _EditPasswordFormState();
}

class _EditPasswordFormState extends State<EditPasswordForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 0),
      child: Container(
        height: 600,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          boxShadow: [
            BoxShadow(
                color: Colors.black12,
                offset: Offset(3.0, 6.0),
                blurRadius: 10.0)
          ],
          color: Color(0xFF2d3447),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Container(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Form(
                    key: _formKey,
                    child: Padding(
                      padding: EdgeInsets.only(top: 16.0),
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
                                  child: Text("Cancel",
                                      style: TextStyle(
                                          fontFamily: "Poppins-Medium",
                                          fontSize: 18.0,
                                          color: Color(0xFF5d74e3))),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(right: 22.0),
                                child: FlatButton(
                                  onPressed: () {
                                    if (_formKey.currentState.validate()) {
                                      _formKey.currentState.save();
                                      // widget.onSave(_task, _note);
                                      Navigator.pop(context);
                                    }
                                  },
                                  color: Colors.black.withOpacity(.40),
                                  disabledColor: Colors.grey,
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(50.0)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(0.0),
                                    child: Text('Update',
                                        style: TextStyle(
                                            fontFamily: 'Poppins-Bold',
                                            fontSize: 15.0,
                                            color: Color(0xFF5d74e3))),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 16.0),
                          Container(
                            width: double.infinity,
                            height: 60,
                            margin: EdgeInsets.symmetric(horizontal: 22),
                            decoration: BoxDecoration(
                                color: Color(0xFF2d3447),
                                borderRadius: BorderRadius.circular(8),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black26,
                                      offset: Offset(0, 10),
                                      blurRadius: 30)
                                ]),
                            child: Center(
                              child: Padding(
                                padding: EdgeInsets.only(left: 18.0, right: 12),
                                child: TextFormField(
                                  //initialValue:
                                  autofocus: true,
                                  obscureText: true,
                                  validator: (val) {
                                    return val.trim().isEmpty
                                        ? 'Please enter some text'
                                        : null;
                                  },
                                  //onSaved: (value) => _task = value,
                                  cursorColor: Colors.white,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Poppins-Medium',
                                      fontSize: 21.0),
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    suffixIcon: Icon(MdiIcons.textboxPassword),
                                    hintText: "Current Password",
                                    errorStyle:
                                        TextStyle(fontFamily: 'Poppins-Medium'),
                                    hintStyle: TextStyle(
                                        fontFamily: 'Poppins-Medium',
                                        color: Colors.white30,
                                        fontSize: 21.0),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 30.0),
                          Container(
                            width: double.infinity,
                            height: 60,
                            margin: EdgeInsets.symmetric(horizontal: 22),
                            decoration: BoxDecoration(
                                color: Color(0xFF2d3447),
                                borderRadius: BorderRadius.circular(8),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black26,
                                      offset: Offset(0, 10),
                                      blurRadius: 30)
                                ]),
                            child: Center(
                              child: Padding(
                                padding: EdgeInsets.only(left: 18.0, right: 12),
                                child: SingleChildScrollView(
                                  child: TextFormField(
                                    obscureText: true,
                                    //onSaved: (value) => _note = value,
                                    autofocus: false,
                                    validator: (val) {
                                      return val.trim().isEmpty
                                          ? 'Please enter some text'
                                          : null;
                                    },
                                    cursorColor: Colors.white,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'Poppins-Medium',
                                        fontSize: 21.0),
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "New Password",
                                      suffixIcon: Icon(MdiIcons.key),
                                      errorStyle: TextStyle(
                                          fontFamily: 'Poppins-Medium'),
                                      hintStyle: TextStyle(
                                          fontFamily: 'Poppins-Medium',
                                          color: Colors.white30,
                                          fontSize: 21.0),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
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
      ),
    );
  }
}
