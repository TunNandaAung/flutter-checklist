import 'package:checklist/todo/todos_repository/lib/todos_barrel.dart';
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
            color: Theme.of(context).bottomSheetTheme.backgroundColor),
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
                                      widget.onSave(_task, _note);
                                      Navigator.pop(context);
                                    }
                                  },
                                  color: Theme.of(context).buttonColor,
                                  disabledColor: Colors.grey,
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(50.0)),
                                  child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text('Update',
                                          style: Theme.of(context)
                                              .textTheme
                                              .button)),
                                ),
                              ),
                            ],
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
                            height: null,
                            margin: EdgeInsets.symmetric(horizontal: 22),
                            decoration: BoxDecoration(
                                color: Theme.of(context).cardColor,
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
                                  cursorColor: Color(0xFF5d74e3),
                                  style: Theme.of(context).textTheme.display4,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    suffixIcon: Icon(Icons.title),
                                    hintText: "What needs to be done?",
                                    errorStyle: TextStyle(
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
                          SizedBox(height: 30.0),
                          Container(
                            width: double.infinity,
                            height: null,
                            constraints: BoxConstraints(
                              maxHeight: 100.0,
                            ),
                            margin: EdgeInsets.symmetric(horizontal: 22),
                            decoration: BoxDecoration(
                                color: Theme.of(context).cardColor,
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
                                    initialValue:
                                        isEditing ? widget.todo.note : '',
                                    maxLines: null,
                                    onSaved: (value) => _note = value,
                                    autofocus: !isEditing,
                                    validator: (val) {
                                      return val.trim().isEmpty
                                          ? 'Please enter some text'
                                          : null;
                                    },
                                    cursorColor: Color(0xFF5d74e3),
                                    style: Theme.of(context).textTheme.display4,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "What needs to be done?",
                                      suffixIcon: Icon(Icons.description),
                                      errorStyle: TextStyle(
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
