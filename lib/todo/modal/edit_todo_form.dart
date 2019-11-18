import 'package:firebase_integrations/todo/todos_repository/lib/todos_barrel.dart';
import 'package:flutter/material.dart';

typedef OnSaveCallback = Function(String task, String note);

class EditTodoForm extends StatefulWidget {
  final bool isEditing;
  final OnSaveCallback onSave;
  final Todo todo;

  EditTodoForm(
      {Key key, @required this.isEditing, @required this.onSave, this.todo})
      : super(key: key);

  @override
  _EditTodoFormState createState() => _EditTodoFormState();
}

class _EditTodoFormState extends State<EditTodoForm> {
  String _task;
  String _note;

  bool get isEditing => widget.isEditing;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 0),
      child: Container(
        width: double.infinity,
        height: 600,
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
                          Padding(
                            padding: const EdgeInsets.only(left: 22.0),
                            child: Text("Edit Task",
                                style: TextStyle(
                                    fontFamily: "Poppins-Medium",
                                    fontSize: 21.0,
                                    color: Colors.white)),
                          ),
                          SizedBox(height: 16.0),
                          // TextFormField(
                          //   initialValue: isEditing ? widget.todo.task : '',
                          //   autofocus: !isEditing,
                          //   validator: (val) {
                          //     return val.trim().isEmpty
                          //         ? 'Please enter some text'
                          //         : null;
                          //   },
                          //   onSaved: (value) => _task = value,
                          //   cursorColor: Colors.white,
                          //   style: TextStyle(
                          //       color: Colors.white,
                          //       fontFamily: 'Poppins-Medium',
                          //       fontSize: 21.0),
                          //   decoration: InputDecoration(
                          //       fillColor: Colors.white,
                          //       hintText: "What needs to be done?",
                          //       errorStyle:
                          //           TextStyle(fontFamily: 'Poppins-Medium'),
                          //       hintStyle: TextStyle(
                          //           fontFamily: 'Poppins-Medium',
                          //           color: Colors.white30,
                          //           fontSize: 21.0)),
                          // ),
                          // SizedBox(
                          //   height: 30,
                          // ),
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
                                  initialValue:
                                      isEditing ? widget.todo.task : '',
                                  autofocus: isEditing,
                                  validator: (val) {
                                    return val.trim().isEmpty
                                        ? 'Please enter some text'
                                        : null;
                                  },
                                  onSaved: (value) => _task = value,
                                  cursorColor: Colors.white,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Poppins-Medium',
                                      fontSize: 21.0),
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    suffixIcon: Icon(Icons.title),
                                    hintText: "What needs to be done?",
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
                            height: 250,
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
                                  initialValue:
                                      isEditing ? widget.todo.note : '',
                                  maxLines: 7,
                                  onSaved: (value) => _note = value,
                                  autofocus: !isEditing,
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
                                    hintText: "What needs to be done?",
                                    suffixIcon: Icon(Icons.description),
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

                          SizedBox(
                            height: 35,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                FlatButton(
                                  onPressed: () {
                                    if (_formKey.currentState.validate()) {
                                      _formKey.currentState.save();
                                      widget.onSave(_task, _note);
                                      Navigator.pop(context);
                                    }
                                  },
                                  color: Color(0xFF5d74e3),
                                  disabledColor: Colors.grey,
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(50.0)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text('Update',
                                        style: TextStyle(
                                            fontFamily: 'Poppins-Bold',
                                            fontSize: 18.0,
                                            color: Colors.white)),
                                  ),
                                )
                              ],
                            ),
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
