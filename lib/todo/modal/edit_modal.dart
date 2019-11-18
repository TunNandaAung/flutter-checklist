import 'package:firebase_integrations/todo/bloc/todos_bloc/todos_bloc_barrel.dart';
import 'package:firebase_integrations/todo/modal/edit_todo_form.dart';
import 'package:firebase_integrations/todo/todos_repository/lib/todos_barrel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditModal {
  mainBottomSheet(BuildContext context, Todo todo) {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return EditTodoForm(
            onSave: (task, note) {
              BlocProvider.of<TodosBloc>(context).add(
                UpdateTodo(
                  todo.copyWith(task: task, note: note),
                ),
              );
            },
            isEditing: true,
            todo: todo,
          );
        });
  }
}
