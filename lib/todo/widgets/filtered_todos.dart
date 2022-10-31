import 'package:checklist/todo/bloc/filtered_todos/filtered_todos_bloc.dart';
import 'package:checklist/todo/bloc/todos_bloc/todos_bloc.dart';
import 'package:checklist/todo/screens/screen.dart';
import 'package:checklist/todo/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FilteredTodos extends StatelessWidget {
  final String userId;
  FilteredTodos({Key key, this.userId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FilteredTodosBloc, FilteredTodosState>(
      builder: (context, state) {
        if (state is FilteredTodosLoading) {
          return LoadingIndicator();
        } else if (state is FilteredTodosLoaded) {
          final todos = state.filteredTodos;
          if (todos.isEmpty) {
            return SingleChildScrollView(
              child: Center(
                child: Container(
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 30.0, vertical: 60.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image.asset('assets/task-complete.png'),
                        SizedBox(
                          height: 10.0,
                        ),
                        Text('You have no task! Enjoy your day',
                            style: Theme.of(context).textTheme.bodyText1)
                      ],
                    ),
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
                  context.read<TodosBloc>().add(DeleteTodo(todo));
                  ScaffoldMessenger.of(context).showSnackBar(DeleteTodoSnackBar(
                    todo: todo,
                    onUndo: () => context.read<TodosBloc>().add(AddTodo(todo)),
                  ));
                },
                onTap: () async {
                  final removedTodo = await Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) {
                      return DetailsScreen(id: todo.id);
                    }),
                  );
                  if (removedTodo != null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      DeleteTodoSnackBar(
                        todo: todo,
                        onUndo: () =>
                            context.read<TodosBloc>().add(AddTodo(todo)),
                      ),
                    );
                  }
                },
                onCheckboxChanged: (_) {
                  context.read<TodosBloc>().add(
                        UpdateTodo(todo.copyWith(
                            complete: !todo.complete, userId: userId)),
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
