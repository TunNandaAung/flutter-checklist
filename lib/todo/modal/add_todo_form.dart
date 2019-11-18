import 'package:firebase_integrations/todo/todos_repository/lib/todos_barrel.dart';
import 'package:flutter/material.dart';

typedef OnSaveCallback = Function(String task, String note);

class AddTodoForm extends StatefulWidget {
  final bool isEditing;
  final OnSaveCallback onSave;
  final Todo todo;

  AddTodoForm(
      {Key key, @required this.isEditing, @required this.onSave, this.todo})
      : super(key: key);

  @override
  _AddTodoFormState createState() => _AddTodoFormState();
}

class _AddTodoFormState extends State<AddTodoForm> {
  String _task;
  String _note;

  bool get isEditing => widget.isEditing;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 600,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(
              color: Colors.black12, offset: Offset(3.0, 6.0), blurRadius: 10.0)
        ],
        color: Color(0xFF2d3447),
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Container(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Form(
                  key: _formKey,
                  child: Padding(
                    padding:
                        EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("Your Task",
                            style: TextStyle(
                                fontFamily: "Poppins-Medium",
                                fontSize: 21.0,
                                color: Colors.white)),
                        SizedBox(height: 16.0),
                        TextFormField(
                          initialValue: isEditing ? widget.todo.task : '',
                          autofocus: !isEditing,
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
                              fillColor: Colors.white,
                              hintText: "What needs to be done?",
                              errorStyle:
                                  TextStyle(fontFamily: 'Poppins-Medium'),
                              hintStyle: TextStyle(
                                  fontFamily: 'Poppins-Medium',
                                  color: Colors.white30,
                                  fontSize: 21.0)),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        TextFormField(
                          initialValue: isEditing ? widget.todo.note : '',
                          maxLines: 7,
                          onSaved: (value) => _note = value,
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Poppins-Medium',
                              fontSize: 21.0),
                          decoration: InputDecoration(
                              hintText: "Say something about task ...",
                              errorStyle:
                                  TextStyle(fontFamily: 'Poppins-Medium'),
                              hintStyle: TextStyle(
                                  fontFamily: 'Poppins-Medium',
                                  color: Colors.white30,
                                  fontSize: 21.0)),
                        ),
                        SizedBox(
                          height: 35,
                        ),
                        Row(
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
                                  borderRadius: BorderRadius.circular(50.0)),
                              child: Text('Add',
                                  style: TextStyle(
                                      fontFamily: 'Poppins-Bold',
                                      fontSize: 18.0,
                                      color: Colors.white)),
                            )
                          ],
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
