import 'package:firebase_integrations/todo/bloc/filtered_todos/filtered_todos_barrel.dart';
import 'package:firebase_integrations/todo/bloc/todos_bloc/todos_bloc_barrel.dart';
import 'package:firebase_integrations/todo/screens/screen.dart';
import 'package:firebase_integrations/todo/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FilteredTodos extends StatelessWidget {
  FilteredTodos({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FilteredTodosBloc, FilteredTodosState>(
      builder: (context, state) {
        if (state is FilteredTodosLoading) {
          return LoadingIndicator();
        } else if (state is FilteredTodosLoaded) {
          final todos = state.filteredTodos;
          if (todos.length <= 0) {
            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 60.0),
                child: Container(
                  child: Column(
                    children: <Widget>[
                      Image.asset('assets/task-complete.svg'),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text('You have no task! Enjoy your day',
                          style: Theme.of(context).textTheme.body1)
                    ],
                  ),
                ),
              ),
            );
          }
          return ListView.builder(
            itemCount: todos.length,
            itemBuilder: (context, index) {
              final todo = todos[index];
              return TodoItem(
                todo: todo,
                onDismissed: (direction) {
                  BlocProvider.of<TodosBloc>(context).add(DeleteTodo(todo));
                  Scaffold.of(context).showSnackBar(DeleteTodoSnackBar(
                    todo: todo,
                    onUndo: () =>
                        BlocProvider.of<TodosBloc>(context).add(AddTodo(todo)),
                  ));
                },
                onTap: () async {
                  final removedTodo = await Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) {
                      return DetailsScreen(id: todo.id);
                    }),
                  );
                  if (removedTodo != null) {
                    Scaffold.of(context).showSnackBar(
                      DeleteTodoSnackBar(
                        todo: todo,
                        onUndo: () => BlocProvider.of<TodosBloc>(context)
                            .add(AddTodo(todo)),
                      ),
                    );
                  }
                },
                onCheckboxChanged: (_) {
                  BlocProvider.of<TodosBloc>(context).add(
                    UpdateTodo(todo.copyWith(complete: !todo.complete)),
                  );
                },
              );
            },
          );
        } else {
          return Container();
        }
      },
    );
  }
}
