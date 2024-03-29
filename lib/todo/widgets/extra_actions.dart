import 'package:firebase_auth/firebase_auth.dart';
import 'package:checklist/todo/bloc/todos_bloc/todos_bloc.dart';
import 'package:checklist/todo/model/extra_action.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExtraActions extends StatelessWidget {
  final User user;

  const ExtraActions({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodosBloc, TodosState>(
      builder: (context, state) {
        if (state is TodosLoaded) {
          bool allComplete = state.todos.every((todo) => todo.complete);
          return Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: PopupMenuButton<ExtraAction>(
              icon: Icon(
                Icons.more_horiz,
                color: Theme.of(context).dividerColor,
                size: 36.0,
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)),
              color: Theme.of(context).popupMenuTheme.color,
              onSelected: (action) {
                switch (action) {
                  case ExtraAction.clearCompleted:
                    context.read<TodosBloc>().add(ClearCompleted());
                    break;
                  case ExtraAction.toggleAllComplete:
                    context.read<TodosBloc>().add(ToggleAll(user.uid));
                    break;
                }
              },
              itemBuilder: (BuildContext context) =>
                  <PopupMenuItem<ExtraAction>>[
                PopupMenuItem<ExtraAction>(
                  value: ExtraAction.toggleAllComplete,
                  child: Text(
                      allComplete ? 'Mark all incomplete' : 'Mark all complete',
                      style: TextStyle(
                          fontFamily: 'Poppins-Medium',
                          color: Theme.of(context).dividerColor)),
                ),
                PopupMenuItem<ExtraAction>(
                  value: ExtraAction.clearCompleted,
                  child: Text('Clear completed',
                      style: TextStyle(
                          fontFamily: 'Poppins-Medium',
                          color: Theme.of(context).dividerColor)),
                ),
              ],
            ),
          );
        }
        return Container();
      },
    );
  }
}
