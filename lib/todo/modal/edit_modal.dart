import 'package:checklist/todo/bloc/todos_bloc/todos_bloc_barrel.dart';
import 'package:checklist/todo/modal/edit_todo_form.dart';
import 'package:checklist/todo/todos_repository/lib/todos_barrel.dart';
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
            onSave: (task, note, time) {
              context.read<TodosBloc>().add(
                    UpdateTodo(
                      todo.copyWith(
                          task: task,
                          note: note,
                          userId: todo.userId,
                          time: time),
                    ),
                  );
            },
            isEditing: true,
            todo: todo,
          );
        });
  }
}
