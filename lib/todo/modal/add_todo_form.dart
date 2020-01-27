import 'package:checklist/todo/todos_repository/lib/todos_barrel.dart';
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
        color: Theme.of(context).canvasColor,
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            GestureDetector(
                              onTap: () => Navigator.pop(context),
                              child: Text("Cancel",
                                  style: TextStyle(
                                      fontFamily: "Poppins-Medium",
                                      fontSize: 18.0,
                                      color: Color(0xFF5d74e3))),
                            ),
                            FlatButton(
                              onPressed: () {
                                if (_formKey.currentState.validate()) {
                                  _formKey.currentState.save();
                                  widget.onSave(
                                    _task,
                                    _note,
                                  );
                                  Navigator.pop(context);
                                }
                              },
                              color: Theme.of(context).buttonColor,
                              disabledColor: Colors.grey,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50.0)),
                              child: Text('Add',
                                  style: Theme.of(context).textTheme.button),
                            )
                          ],
                        ),
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
                          cursorColor: Color(0xFF5d74e3),
                          style: Theme.of(context).textTheme.display4,
                          decoration: InputDecoration(
                              fillColor: Theme.of(context)
                                  .inputDecorationTheme
                                  .fillColor,
                              hintText: "What needs to be done?",
                              errorStyle:
                                  TextStyle(fontFamily: 'Poppins-Medium'),
                              hintStyle: Theme.of(context)
                                  .inputDecorationTheme
                                  .hintStyle),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Container(
                          height: null,
                          constraints: BoxConstraints(
                            maxHeight: 100.0,
                          ),
                          child: SingleChildScrollView(
                            child: TextFormField(
                              initialValue: isEditing ? widget.todo.note : '',
                              maxLines: null,
                              onSaved: (value) => _note = value,
                              style: Theme.of(context).textTheme.display4,
                              decoration: InputDecoration(
                                  fillColor: Theme.of(context)
                                      .inputDecorationTheme
                                      .fillColor,
                                  hintText: "Say something about task ...",
                                  errorStyle:
                                      TextStyle(fontFamily: 'Poppins-Medium'),
                                  hintStyle: Theme.of(context)
                                      .inputDecorationTheme
                                      .hintStyle),
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
    );
  }
}
