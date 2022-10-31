import 'package:checklist/todo/bloc/todos_bloc/todos_bloc.dart';
import 'package:checklist/todo/modal/add_todo_form.dart';
import 'package:checklist/todo/todos_repository/lib/todos_barrel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddModal {
  mainBottomSheet(BuildContext context, String userId) {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return AddTodoForm(
            onSave: (task, note, time) {
              context.read<TodosBloc>().add(
                    AddTodo(Todo(task,
                        note: note, userId: userId, time: time ?? 0)),
                  );
            },
            isEditing: false,
          );
        });
  }
}
