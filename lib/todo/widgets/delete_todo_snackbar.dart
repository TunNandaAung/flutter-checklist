import 'package:checklist/todo/todos_repository/lib/todos_barrel.dart';
import 'package:flutter/material.dart';

class DeleteTodoSnackBar extends SnackBar {
  DeleteTodoSnackBar({
    Key? key,
    required Todo todo,
    required VoidCallback onUndo,
  }) : super(
          elevation: 6.0,
          behavior: SnackBarBehavior.floating,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          key: key,
          content: Text(
            'Deleted ${todo.task}',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontFamily: 'Poppins-Bold'),
          ),
          backgroundColor: Color(0xFF5d74e3),
          duration: Duration(seconds: 2),
          action: SnackBarAction(
            label: 'Undo',
            textColor: Color(0xFF17ead9),
            onPressed: onUndo,
          ),
        );
}
